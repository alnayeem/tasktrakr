# TaskTrakr MVP Plan - Ramadan 2026

> **This is the primary document for development.** Load this first.

## Key Decisions (LOCKED)

| Decision | Choice | Rationale |
|----------|--------|-----------|
| **Framework** | **Flutter** | Faster MVP, better RTL/Arabic support, single codebase, Hive for local storage |
| **Target Launch** | **Ramadan 2026** | Feb 20 submission → Feb 28 Ramadan start |
| **MVP Approach** | **AI-First (Gemini)** | Use LLM for all goal generation, templates as fallback |
| **Languages (MVP)** | **English + Arabic** | 2 languages, add more post-launch |
| **AI Provider** | **Gemini API (Free Tier)** | 1M tokens/month free, via Cloudflare Worker |

---

## MVP Scope (4 Weeks)

### What's IN:

| Feature | Description | Priority |
|---------|-------------|----------|
| ✅ Goal Input | Free-form text in English/Arabic | P0 |
| ✅ AI Generation | Gemini API generates daily tasks | P0 |
| ✅ Task Tracking | Daily checkboxes, completion status | P0 |
| ✅ Ramadan Mode | Hijri dates, 3 phases, Laylatul Qadr | P0 |
| ✅ Progress View | Simple progress bar per goal | P0 |
| ✅ Local Storage | Hive for offline data persistence | P0 |
| ✅ Basic Streaks | Goal-specific streak counter | P1 |
| ✅ Dark Mode | System-aware theming | P1 |
| ✅ 5 Fallback Templates | If AI fails or offline | P1 |

### What's OUT (Post-Launch):

| Feature | When |
|---------|------|
| ❌ 10 additional languages | Week 2-3 post-launch |
| ❌ Voice input | Post-launch |
| ❌ Milestones & Badges | Post-launch |
| ❌ Export/Import | Post-launch |
| ❌ Donation system | Month 2 |

---

## 4-Week Sprint Plan

### Week 1 (Feb 1-7): FOUNDATION
- Day 1-2: Flutter project setup, folder structure, CI/CD
- Day 3-4: Data models, Hive setup, state management (Riverpod)
- Day 5-6: Cloudflare Worker proxy deployment
- Day 7: Gemini API integration, basic prompt testing
- **Deliverable:** AI generates tasks from text input

### Week 2 (Feb 8-14): CORE UI
- Day 1-2: Onboarding flow, language selection (EN/AR)
- Day 3-4: Goal creation screen, AI loading state
- Day 5-6: Task list view, checkbox interactions
- Day 7: Goal detail view, progress bar
- **Deliverable:** Full user flow working (create → track)

### Week 3 (Feb 15-19): RAMADAN + POLISH
- Day 1-2: Ramadan mode (Hijri dates, phases, special nights)
- Day 3: Streak counter, basic gamification
- Day 4: Dark mode, RTL layout fixes for Arabic
- Day 5: Error handling, offline states, edge cases
- **Deliverable:** Feature-complete app

### Week 4 (Feb 20-27): LAUNCH
- Day 1: App Store assets (screenshots, descriptions)
- Day 2: Submit to iOS App Store + Google Play
- Day 3-5: Bug fixes from review feedback
- Day 6-7: Marketing prep, soft launch
- **Deliverable:** APP LIVE BEFORE RAMADAN

---

## Tech Stack

```
MOBILE APP
├── Framework: Flutter 3.x (Dart)
├── State Management: Riverpod
├── Local Database: Hive
├── HTTP Client: Dio
├── Localization: flutter_localizations + intl
├── Hijri Dates: hijri package
└── UI: Material 3

BACKEND (Minimal)
├── AI Proxy: Cloudflare Worker (free tier)
├── AI Provider: Google Gemini API (free tier)
└── Monitoring: Sentry (free tier)
```

---

## AI Flow

```
User enters goal → Online?
                      │
                 YES  │  NO
                      ↓   ↓
              Call Gemini   Show templates
                      │
              Valid JSON?
                      │
                 YES  │  NO (retry 2x)
                      ↓   ↓
              Store tasks   Use fallback template
```

---

## Success Criteria

| Metric | Target |
|--------|--------|
| App live before Ramadan | Feb 28 |
| Core flow works | 100% |
| AI success rate | >95% |
| Crash rate | <1% |
| Arabic RTL works | 100% |

---

## Related Documents

- [01-FEATURES.md](./01-FEATURES.md) - Detailed feature specs
- [02-AI-INTEGRATION.md](./02-AI-INTEGRATION.md) - AI prompts, schemas, API details
- [03-DATA-MODELS.md](./03-DATA-MODELS.md) - TypeScript/Dart data structures
- [04-UI-SCREENS.md](./04-UI-SCREENS.md) - Screen mockups and flows
- [05-TECH-REQUIREMENTS.md](./05-TECH-REQUIREMENTS.md) - Technical architecture
- [06-SAFETY-SECURITY.md](./06-SAFETY-SECURITY.md) - Content moderation, guardrails
- [07-MONETIZATION.md](./07-MONETIZATION.md) - Donation system (post-MVP)
- [08-SCALING.md](./08-SCALING.md) - AI cost scaling strategy
