# TaskTrakr AI Integration Specification

> Load after: [00-MVP-PLAN.md](./00-MVP-PLAN.md)

## Overview

```
User enters goal
       ↓
┌─────────────────────────────────────────┐
│             INPUT PROCESSOR             │
│  • Detect category                      │
│  • Extract duration                     │
│  • Build context object                 │
└─────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────┐
│             PROMPT BUILDER              │
│  • Select system prompt                 │
│  • Inject user context                  │
│  • Add schema definition                │
└─────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────┐
│          GEMINI API CALL                │
│  • Via Cloudflare Worker proxy          │
│  • Request JSON mode                    │
│  • Handle retries                       │
└─────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────┐
│          RESPONSE VALIDATOR             │
│  • Parse JSON                           │
│  • Validate schema                      │
│  • Check task count                     │
└─────────────────────────────────────────┘
       ↓
┌─────────────────────────────────────────┐
│          STORE IN HIVE                  │
│  • Convert to local model               │
│  • Generate UUIDs                       │
│  • Calculate dates                      │
└─────────────────────────────────────────┘
```

---

## Input Context Object

```dart
class GoalContext {
  final String rawInput;           // "I want to run a 5K"
  final String language;           // "en" or "ar"
  final String category;           // "fitness", "ramadan", etc.
  final int durationDays;          // 30
  final String startDate;          // "2026-02-28"
  final String? difficulty;        // "easy" | "moderate" | "challenging"
  final String? specialMode;       // "ramadan" | null
  final RamadanContext? ramadan;   // Only if specialMode = "ramadan"
}

class RamadanContext {
  final String hijriStart;         // "1447-09-01"
  final List<int> laylaulQadrNights; // [21, 23, 25, 27, 29]
}
```

---

## System Prompt

### Base Prompt (All Categories)

```
You are TaskTrakr, an AI goal planning assistant. Create a structured daily plan.

IMPORTANT: Respond in the language specified. All text must be in that language.

RULES:
1. Respond ONLY with valid JSON matching the schema
2. Generate one entry per day for the full duration
3. Each day can have an optional assignment OR be a rest day (omit task fields)
4. Assignments must be specific, actionable, achievable
5. Progress should build logically (easier → harder)
6. Include 1-2 rest days per week (days with no assignment)

DAY PLAN STRUCTURE:
- Days WITH assignment: include task, task_short, estimated_minutes, intensity
- Rest days: only include day number, omit task fields entirely

ASSIGNMENT QUALITY:
- Be specific: "Read pages 1-20" not "Read some pages"
- Be measurable: "Run 15 minutes" not "Go for a run"
- Be realistic: Don't schedule 3 hours for a 30-minute goal
- Be progressive: Day 1 easier than Day 30
- Include estimated_minutes so users can track partial progress
```

### Ramadan Addition

```
CATEGORY: RAMADAN / ISLAMIC
- Consider the three phases:
  * Days 1-10: Mercy (رحمة)
  * Days 11-20: Forgiveness (مغفرة)
  * Days 21-30: Salvation (عتق من النار)
- Laylatul Qadr: odd nights 21, 23, 25, 27, 29 = INCREASED tasks
- Use Islamic terminology (Juz, Surah, Rakah)
- Best times: after Fajr, before Iftar, after Taraweeh

For Quran goals:
- 1 Juz = ~20 pages = ~30-45 minutes
- Full Quran = 30 Juz = 1 Juz/day for 30 days
```

### Fitness Addition

```
CATEGORY: FITNESS
- Progressive overload (gradually increase intensity)
- Include warm-up/cool-down in notes
- Schedule rest days every 3-4 days
- Account for muscle recovery
```

### Learning Addition

```
CATEGORY: LEARNING
- Apply spaced repetition
- Balance new material with review
- Include practice tasks, not just reading
- Break complex topics into chunks
```

---

## AI Response Schema

```typescript
interface TaskTrakrPlanResponse {
  success: boolean;
  error_message?: string;

  goal: {
    title: string;           // "Complete Reading the Quran"
    title_short: string;     // "Read Quran"
    category: string;
    duration_days: number;
    difficulty: string;
    description: string;
    icon_suggestion: string; // Emoji: "📖"
  };

  // Day plans - one entry per day, assignment is optional
  day_plans: Array<{
    day: number;             // 1, 2, 3...

    // Assignment (optional - null/omitted means rest day)
    task?: string;           // Full task description (omit for rest days)
    task_short?: string;     // Compact version
    estimated_minutes?: number;
    notes?: string;
    intensity?: "light" | "moderate" | "intense";

    // Ramadan only:
    ramadan_phase?: "mercy" | "forgiveness" | "salvation";
    is_laylatul_qadr_night?: boolean;
  }>;

  milestones: Array<{
    day: number;
    title: string;
    description: string;
    icon: string;
  }>;

  tips: string[];

  ramadan_data?: {
    phases: { mercy, forgiveness, salvation };
    laylatul_qadr_nights: number[];
  };
}
```

---

## Gemini API Call

### Endpoint
```
POST https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent
```

### Request Format
```json
{
  "contents": [{
    "parts": [{
      "text": "[System prompt + User goal context as JSON]"
    }]
  }],
  "generationConfig": {
    "responseMimeType": "application/json",
    "temperature": 0.7,
    "maxOutputTokens": 4096
  }
}
```

### Via Cloudflare Worker
```javascript
// Worker hides API key, adds rate limiting
export default {
  async fetch(request, env) {
    const deviceId = request.headers.get("X-Device-Id");

    // Rate limit: 5/day per device
    if (await isRateLimited(deviceId, env)) {
      return new Response(JSON.stringify({
        error: true,
        message: "Daily limit reached"
      }), { status: 429 });
    }

    const response = await fetch(GEMINI_URL + `?key=${env.GEMINI_API_KEY}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: request.body
    });

    return response;
  }
};
```

---

## Error Handling

| Error | Action |
|-------|--------|
| Network failure | Show offline message, offer templates |
| Invalid JSON | Retry up to 2 times |
| Rate limited | Show "Try again tomorrow" |
| Timeout (>10s) | Retry once, then show error |
| Content policy | Show generic error, don't expose reason |

### Retry Logic
```dart
Future<TaskTrakrPlanResponse> generatePlan(GoalContext context) async {
  for (int attempt = 0; attempt < 3; attempt++) {
    try {
      final response = await callGemini(context);
      final parsed = parseResponse(response);
      if (isValid(parsed)) return parsed;
    } catch (e) {
      if (attempt == 2) rethrow;
      await Future.delayed(Duration(seconds: pow(2, attempt)));
    }
  }
  throw Exception("Failed after 3 attempts");
}
```

---

## Fallback Templates (5 for MVP)

When AI fails or offline, offer these pre-built plans:

1. **Complete the Quran in 30 days** (Ramadan)
2. **Pray 5 times daily for 30 days** (Ramadan)
3. **Run a 5K in 30 days** (Fitness)
4. **Read 1 book in 30 days** (Learning)
5. **Meditate daily for 30 days** (Wellness)

Templates stored as JSON in app assets, loaded at startup.

---

## Cost Estimation

| Metric | Value |
|--------|-------|
| Avg tokens per request | ~800 input + ~2000 output |
| Gemini free tier | 1M tokens/month |
| Generations per month | ~10,000 |
| Cost | **$0** (free tier) |

If exceeding free tier:
- Gemini 1.5 Flash: ~$0.001 per generation
- 50K generations = ~$50/month
