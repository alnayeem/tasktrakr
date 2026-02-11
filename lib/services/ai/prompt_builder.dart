import 'dart:convert';
import 'models/goal_context.dart';

/// Builds prompts for the Gemini AI based on goal context
class PromptBuilder {
  const PromptBuilder();

  /// Build the complete prompt for goal generation
  String buildPrompt(GoalContext context) {
    final systemPrompt = _buildSystemPrompt(context);
    final userContext = _buildUserContext(context);

    return '''$systemPrompt

USER GOAL REQUEST:
$userContext

Generate a complete daily plan following the schema exactly. Respond ONLY with valid JSON.''';
  }

  String _buildSystemPrompt(GoalContext context) {
    final buffer = StringBuffer();

    // Base prompt
    buffer.writeln(_basePrompt);

    // Category-specific additions
    if (context.isRamadanMode) {
      buffer.writeln();
      buffer.writeln(_ramadanPrompt);
    } else if (context.category == 'fitness') {
      buffer.writeln();
      buffer.writeln(_fitnessPrompt);
    } else if (context.category == 'learning') {
      buffer.writeln();
      buffer.writeln(_learningPrompt);
    }

    // Schema definition
    buffer.writeln();
    buffer.writeln(_schemaPrompt);

    return buffer.toString();
  }

  String _buildUserContext(GoalContext context) {
    return jsonEncode(context.toJson());
  }

  static const String _basePrompt = '''
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
- Include estimated_minutes so users can track partial progress''';

  static const String _ramadanPrompt = '''
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
- Full Quran = 30 Juz = 1 Juz/day for 30 days''';

  static const String _fitnessPrompt = '''
CATEGORY: FITNESS
- Progressive overload (gradually increase intensity)
- Include warm-up/cool-down in notes
- Schedule rest days every 3-4 days
- Account for muscle recovery''';

  static const String _learningPrompt = '''
CATEGORY: LEARNING
- Apply spaced repetition
- Balance new material with review
- Include practice tasks, not just reading
- Break complex topics into chunks''';

  static const String _schemaPrompt = '''
RESPONSE SCHEMA (JSON):
{
  "success": true,
  "goal": {
    "title": "string - Full goal title",
    "title_short": "string - Short version (max 20 chars)",
    "category": "string - ramadan|fitness|learning|wellness|general",
    "duration_days": number,
    "difficulty": "easy|moderate|challenging",
    "description": "string - 1-2 sentence description",
    "icon_suggestion": "string - single emoji"
  },
  "day_plans": [
    {
      "day": 1,
      "task": "string - Full task description (omit for rest days)",
      "task_short": "string - Short version (omit for rest days)",
      "estimated_minutes": number,
      "notes": "string - Optional tips",
      "intensity": "light|moderate|intense",
      "ramadan_phase": "mercy|forgiveness|salvation (only for Ramadan)",
      "is_laylatul_qadr_night": boolean (only for Ramadan)
    }
  ],
  "milestones": [
    {
      "day": number,
      "title": "string",
      "description": "string",
      "icon": "emoji"
    }
  ],
  "tips": ["string - helpful tip 1", "string - helpful tip 2"],
  "ramadan_data": {
    "phases": {
      "mercy": "Days 1-10: Mercy",
      "forgiveness": "Days 11-20: Forgiveness",
      "salvation": "Days 21-30: Salvation"
    },
    "laylatul_qadr_nights": [21, 23, 25, 27, 29]
  }
}''';
}
