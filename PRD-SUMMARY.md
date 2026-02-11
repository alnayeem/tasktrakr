# TaskTrakr - PRD Summary

**AI-Powered Goal & Habit Builder**

> Full documentation in [docs/](./docs/) folder. Load progressively.

---

## Quick Reference

### What We're Building
A free mobile app that uses AI to turn goals into daily task schedules.

### Key Decisions
| Decision | Choice |
|----------|--------|
| Framework | Flutter |
| AI | Gemini API (free tier) |
| Languages | English + Arabic (MVP) |
| Storage | Local only (Hive) |
| Launch | Before Ramadan 2026 (Feb 28) |

### MVP Features
- ✅ Free-form goal input
- ✅ AI generates daily tasks
- ✅ Task checkboxes
- ✅ Ramadan mode (Hijri dates, phases)
- ✅ Progress tracking
- ✅ Basic streaks

### NOT in MVP
- ❌ 10+ languages
- ❌ Voice input
- ❌ Milestones & badges
- ❌ Donations
- ❌ Export/import

---

## Documentation

| Topic | Document |
|-------|----------|
| **Start here** | [docs/00-MVP-PLAN.md](./docs/00-MVP-PLAN.md) |
| Features | [docs/01-FEATURES.md](./docs/01-FEATURES.md) |
| AI Integration | [docs/02-AI-INTEGRATION.md](./docs/02-AI-INTEGRATION.md) |
| Data Models | [docs/03-DATA-MODELS.md](./docs/03-DATA-MODELS.md) |
| UI Screens | [docs/04-UI-SCREENS.md](./docs/04-UI-SCREENS.md) |
| Tech Setup | [docs/05-TECH-REQUIREMENTS.md](./docs/05-TECH-REQUIREMENTS.md) |
| Safety | [docs/06-SAFETY-SECURITY.md](./docs/06-SAFETY-SECURITY.md) |
| Monetization | [docs/07-MONETIZATION.md](./docs/07-MONETIZATION.md) |
| Scaling | [docs/08-SCALING.md](./docs/08-SCALING.md) |

---

## 4-Week Timeline

| Week | Focus | Deliverable |
|------|-------|-------------|
| 1 | Foundation | AI generates tasks |
| 2 | Core UI | Full user flow |
| 3 | Ramadan + Polish | Feature complete |
| 4 | Launch | App live |

---

## Tech Stack

```
Flutter + Riverpod + Hive + Dio
           ↓
   Cloudflare Worker (proxy)
           ↓
      Gemini API (free)
```

---

## Next Steps

1. Read [docs/00-MVP-PLAN.md](./docs/00-MVP-PLAN.md)
2. Set up Flutter project
3. Deploy Cloudflare Worker
4. Start building!
