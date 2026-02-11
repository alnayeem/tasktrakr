# TaskTrakr Documentation

AI-Powered Goal & Habit Builder - Ramadan 2026 MVP

## Document Index

Load documents progressively based on what you're working on:

### Always Start Here
| Doc | Description | When to Load |
|-----|-------------|--------------|
| [00-MVP-PLAN.md](./00-MVP-PLAN.md) | **Key decisions, scope, timeline** | Always first |

### Core Development
| Doc | Description | When to Load |
|-----|-------------|--------------|
| [01-FEATURES.md](./01-FEATURES.md) | Feature specs, acceptance criteria | Building features |
| [02-AI-INTEGRATION.md](./02-AI-INTEGRATION.md) | Prompts, schemas, Gemini API | AI implementation |
| [03-DATA-MODELS.md](./03-DATA-MODELS.md) | Dart/Hive models, repository | Data layer |
| [04-UI-SCREENS.md](./04-UI-SCREENS.md) | Screen mockups, flows | UI implementation |
| [05-TECH-REQUIREMENTS.md](./05-TECH-REQUIREMENTS.md) | Flutter setup, Cloudflare Worker | Project setup |

### Specialized Topics
| Doc | Description | When to Load |
|-----|-------------|--------------|
| [06-SAFETY-SECURITY.md](./06-SAFETY-SECURITY.md) | Content moderation | AI safety |
| [07-MONETIZATION.md](./07-MONETIZATION.md) | Donation system | Post-MVP |
| [08-SCALING.md](./08-SCALING.md) | AI cost scaling | Growth planning |

---

## Quick Reference

### Tech Stack
- **Framework:** Flutter 3.x
- **State:** Riverpod
- **Database:** Hive
- **AI:** Gemini API via Cloudflare Worker

### MVP Scope
- English + Arabic
- AI goal generation
- Task tracking with checkboxes
- Ramadan mode
- Basic streaks
- 5 fallback templates

### Timeline
- Week 1: Foundation + AI
- Week 2: Core UI
- Week 3: Ramadan + Polish
- Week 4: Launch

### Key Files to Create
```
lib/
├── data/models/stored_goal.dart
├── data/models/stored_task.dart
├── data/services/ai_service.dart
├── features/dashboard/
├── features/goal_creation/
└── features/goal_detail/
```
