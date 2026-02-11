# TaskTrakr App Build Strategy: Vibe Coding with Claude Code + Design Tools

## Project Overview
- **App**: TaskTrakr - AI-Powered Goal & Habit Builder
- **Stack**: Flutter + Riverpod + Hive + Gemini API (via Cloudflare Worker)
- **Timeline**: 4 weeks (target: before Ramadan 2026, Feb 28)
- **Languages**: English + Arabic (RTL support)

---

## Phase 1: Design Foundation (Days 1-3)

### Use Figma/Canva for:

1. **App Icon & Branding** (Canva)
   - Create app icon with Islamic/minimal aesthetic
   - Color palette: Primary #2196F3, Ramadan accent #1B5E20
   - Export at required sizes (1024x1024 for stores)

2. **UI Mockups** (Figma)
   - Convert ASCII mockups from `docs/04-UI-SCREENS.md` to visual designs
   - Create 6 core screens: Onboarding, Dashboard, Goal Creation, AI Loading, Goal Detail, Settings
   - Design both light and dark themes
   - Create RTL variants for Arabic

3. **Design Tokens Export**
   - Export colors, spacing, typography as JSON
   - Feed to Claude Code for consistent implementation

---

## Phase 2: Claude Code Vibe Coding Workflow

### Recommended approach for each feature:

```
1. Describe intent naturally → Claude generates code
2. Review & iterate → Refine with follow-up prompts
3. Test immediately → Fix issues in real-time
4. Commit working chunks → Small, frequent commits
```

### Session Structure:

| Session | Focus | Claude Code Prompts |
|---------|-------|---------------------|
| **Day 1-2** | Project Setup | "Create Flutter project with Riverpod, Hive, Dio. Use the folder structure from my docs." |
| **Day 3-4** | Data Models | "Implement StoredGoal, StoredDayPlan, UserPreferences as Hive models based on docs/03-DATA-MODELS.md" |
| **Day 5-6** | Cloudflare Worker | "Create a Cloudflare Worker that proxies to Gemini API with rate limiting per device" |
| **Day 7** | AI Service | "Build AI service that sends goals to Gemini and parses responses per docs/02-AI-INTEGRATION.md" |
| **Week 2** | UI Screens | "Create Dashboard screen with today's tasks and goal cards. Follow my Figma mockup." |
| **Week 3** | Ramadan + Polish | "Add Hijri date support and Ramadan phases. Style the Laylatul Qadr nights differently." |
| **Week 4** | Launch Prep | "Generate App Store screenshots and descriptions in English and Arabic" |

---

## Phase 3: Vibe Coding Best Practices

### 1. Context Loading
Start each Claude Code session by loading relevant docs:
```
"Read docs/00-MVP-PLAN.md, docs/03-DATA-MODELS.md, and docs/04-UI-SCREENS.md
for context on what we're building"
```

### 2. Incremental Building
Break features into small, testable chunks:
```
BAD:  "Build the entire goal creation flow"
GOOD: "Create the goal input text field with Arabic/English support.
       Then I'll ask you to add the duration selector."
```

### 3. Design-to-Code Flow
```
Figma → Screenshot → Claude Code
"Here's my Figma mockup for the Dashboard. Implement this in Flutter
using Material 3. Match the colors and spacing exactly."
```

### 4. Iterative Refinement
```
"The task cards look good but need more padding. Also add the streak
fire emoji with a bounce animation when tapped."
```

---

## Phase 4: Design Tool Integration

### Figma Workflow:
1. Design screens in Figma
2. Use Figma's Dev Mode to extract spacing/colors
3. Screenshot components and share with Claude Code
4. Generate Flutter widgets that match designs

### Canva Workflow:
1. Create marketing assets (App Store screenshots)
2. Design onboarding illustrations
3. Generate social media promotional graphics
4. Export optimized images for app assets

### Design Handoff Format:
```markdown
## Screen: Dashboard
- Background: #FAFAFA (light) / #121212 (dark)
- Card padding: 16px
- Card border-radius: 12px
- Task checkbox: 24x24, primary color when checked
- Streak badge: Fire emoji + count, Success green (#4CAF50)
```

---

## Phase 5: Parallel Workstreams

Run these simultaneously for efficiency:

| Stream | Tool | Task |
|--------|------|------|
| **Design** | Figma | Create all 6 screen mockups |
| **Backend** | Claude Code | Deploy Cloudflare Worker |
| **Models** | Claude Code | Generate Hive models + adapters |
| **Localization** | Manual + Claude | Write ARB files for EN/AR |

---

## Sample Claude Code Session Flow

```
You: "Let's build the goal creation screen. I have the mockup in Figma.
     It needs: text input, duration chips (7/14/30/60 days), category
     icons, and a Generate Plan button."

Claude: [Generates GoalCreationScreen widget]

You: "Good, but add RTL support for Arabic and validate that the goal
     text isn't empty before enabling the button"

Claude: [Updates with Directionality wrapper and validation]

You: "Now connect it to Riverpod - create a goalCreationProvider that
     holds the form state"

Claude: [Generates provider and updates screen]

You: "Test it - run the app and let me see if it works"

Claude: [Runs flutter run, identifies any issues]
```

---

## Key Files to Generate First

1. `lib/main.dart` - App entry with Hive init
2. `lib/data/models/` - All 3 Hive models
3. `lib/data/services/ai_service.dart` - Gemini integration
4. `lib/providers/` - Riverpod providers
5. `lib/features/dashboard/` - Home screen
6. `lib/l10n/` - Localization files

---

## Tips for Effective Vibe Coding

1. **Be specific about patterns**: "Use Riverpod's AsyncValue for loading states"
2. **Reference your docs**: "Follow the schema in 02-AI-INTEGRATION.md"
3. **Test frequently**: Ask Claude to run `flutter analyze` and fix issues
4. **Commit often**: Small commits after each working feature
5. **Use screenshots**: Share Figma screenshots for pixel-accurate implementation

---

## Recommended Tool Split

| Task | Best Tool |
|------|-----------|
| App logic & code | Claude Code |
| Visual design | Figma |
| Marketing graphics | Canva |
| Icon design | Figma or Canva |
| Localization QA | Native speakers |
| App Store assets | Canva |
