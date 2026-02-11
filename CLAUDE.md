# TaskTrakr - Claude Code Instructions

## Project Context
Building **TaskTrakr**, an AI-powered goal & habit tracking app for iOS/Android.
Target launch: Before Ramadan 2026 (Feb 28).

## Tech Stack
- **Framework**: Flutter 3.x (Dart)
- **State Management**: Riverpod
- **Local Storage**: Hive (NoSQL)
- **HTTP Client**: Dio
- **AI Backend**: Gemini API via Cloudflare Worker proxy
- **Languages**: English + Arabic (RTL support)

## Key Documentation
Always reference these docs for specifications:
- `docs/00-MVP-PLAN.md` - Primary development guide, timeline, scope
- `docs/01-FEATURES.md` - Feature requirements and acceptance criteria
- `docs/02-AI-INTEGRATION.md` - Gemini prompts, schemas, API flow
- `docs/03-DATA-MODELS.md` - Hive models (StoredGoal, StoredDayPlan, UserPreferences)
- `docs/04-UI-SCREENS.md` - Screen mockups and user flows
- `docs/05-TECH-REQUIREMENTS.md` - Dependencies, project structure, Cloudflare setup

## Coding Standards

### Flutter/Dart
- Use Material 3 design system
- Follow the folder structure in `docs/05-TECH-REQUIREMENTS.md`
- Use Riverpod for all state management (prefer `@riverpod` annotations)
- All Hive models need `@HiveType` and `@HiveField` annotations
- Support RTL layouts using `Directionality` widget for Arabic

### Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/functions: `camelCase`
- Providers: `{name}Provider`

### Localization
- All user-facing strings must use ARB files (`lib/l10n/`)
- Support: English (`app_en.arb`) and Arabic (`app_ar.arb`)

## Important Patterns

### AI Service Flow
```
User goal → GoalContext → Cloudflare Worker → Gemini API → Parse JSON → Store in Hive
```

### Ramadan Mode
- Activated when category = "ramadan" or goal mentions Ramadan
- Uses Hijri calendar dates
- Three phases: Mercy (1-10), Forgiveness (11-20), Salvation (21-30)
- Laylatul Qadr nights: 21, 23, 25, 27, 29

### Data Storage
- All data is local-only (no backend database)
- Hive boxes: `goals`, `dayPlans`, `preferences`
- Data is lost on app uninstall (warn users)

## What NOT to Do
- Don't embed Gemini API key in app code (use Cloudflare proxy)
- Don't add features not in MVP scope (see `docs/00-MVP-PLAN.md`)
- Don't skip RTL support for Arabic layouts
- Don't use global state; always use Riverpod providers

## Testing Commands
```bash
flutter analyze          # Check for issues
flutter test             # Run unit tests
flutter run              # Run app
flutter build apk        # Build Android
flutter build ios        # Build iOS
```

## Quick Reference

### Colors
| Name | Hex | Usage |
|------|-----|-------|
| Primary | #2196F3 | Buttons, links |
| Success | #4CAF50 | Completed, streaks |
| Warning | #FF9800 | Streak at risk |
| Ramadan | #1B5E20 | Islamic mode accent |
| Background Light | #FAFAFA | Light mode |
| Background Dark | #121212 | Dark mode |

### MVP Screens (6 total)
1. Onboarding (language selection)
2. Dashboard (today's tasks, goals)
3. Goal Creation (input, duration, category)
4. AI Loading (generating plan)
5. Goal Detail (tasks, progress, streak)
6. Settings (language, theme)
