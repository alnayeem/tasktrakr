# Product Requirements Document (PRD)
## TaskTrakr - AI-Powered Goal & Habit Builder

**Version:** 1.2
**Date:** February 1, 2026
**Author:** Product Team

---

## 0. FINAL DECISIONS & MVP PLAN FOR RAMADAN 2026

### 0.1 Key Decisions (LOCKED)

| Decision | Choice | Rationale |
|----------|--------|-----------|
| **Framework** | **Flutter** | Faster MVP, better RTL/Arabic support, single codebase, excellent local storage (Hive) |
| **Target Launch** | **Ramadan 2026** | Feb 20 submission → Feb 28 Ramadan start |
| **MVP Approach** | **AI-First (Gemini)** | Use LLM for all goal generation, templates as fallback |
| **Languages (MVP)** | **English + Arabic** | 2 languages, add more post-launch |
| **AI Provider** | **Gemini API (Free Tier)** | 1M tokens/month free, via Cloudflare Worker |

---

### 0.2 MVP Scope for Ramadan 2026 (4 Weeks)

**Target: Submit to App Store by Feb 20, 2026**

#### What's IN the MVP:

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

#### What's OUT of MVP (Post-Launch):

| Feature | Reason | When |
|---------|--------|------|
| ❌ 10 additional languages | Time constraint | Week 2-3 post-launch |
| ❌ Voice input | Nice-to-have | Post-launch |
| ❌ Milestones & Badges | Gamification polish | Post-launch |
| ❌ Tips system | Non-essential | Post-launch |
| ❌ Export/Import | Non-essential | Post-launch |
| ❌ Donation system | Need users first | Month 2 |
| ❌ On-device AI | Future tech | Phase 3 |
| ❌ BYOK (own API keys) | Power user feature | Phase 3 |

---

### 0.3 4-Week Sprint Plan

```
┌─────────────────────────────────────────────────────────────────────┐
│                    RAMADAN 2026 MVP SPRINT                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  WEEK 1 (Feb 1-7): FOUNDATION                                        │
│  ├── Day 1-2: Flutter project setup, folder structure, CI/CD        │
│  ├── Day 3-4: Data models, Hive setup, state management (Riverpod)  │
│  ├── Day 5-6: Cloudflare Worker proxy deployment                    │
│  ├── Day 7: Gemini API integration, basic prompt testing            │
│  └── Deliverable: AI generates tasks from text input (CLI/debug)    │
│                                                                       │
│  WEEK 2 (Feb 8-14): CORE UI                                          │
│  ├── Day 1-2: Onboarding flow, language selection (EN/AR)           │
│  ├── Day 3-4: Goal creation screen, AI loading state                │
│  ├── Day 5-6: Task list view, checkbox interactions                 │
│  ├── Day 7: Goal detail view, progress bar                          │
│  └── Deliverable: Full user flow working (create → track)           │
│                                                                       │
│  WEEK 3 (Feb 15-19): RAMADAN + POLISH                                │
│  ├── Day 1-2: Ramadan mode (Hijri dates, phases, special nights)    │
│  ├── Day 3: Streak counter, basic gamification                      │
│  ├── Day 4: Dark mode, RTL layout fixes for Arabic                  │
│  ├── Day 5: Error handling, offline states, edge cases              │
│  └── Deliverable: Feature-complete app                               │
│                                                                       │
│  WEEK 4 (Feb 20-27): LAUNCH                                          │
│  ├── Day 1: App Store assets (screenshots, descriptions)            │
│  ├── Day 2: Submit to iOS App Store + Google Play                   │
│  ├── Day 3-5: Bug fixes from review feedback                        │
│  ├── Day 6-7: Marketing prep, soft launch                           │
│  └── Deliverable: APP LIVE BEFORE RAMADAN 🚀                        │
│                                                                       │
│  RAMADAN STARTS: ~Feb 28, 2026                                       │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
```

---

### 0.4 Technical Stack (LOCKED)

```
┌─────────────────────────────────────────────────────────────────────┐
│                         TECH STACK                                   │
├────────────��────────────────────────────────────────────────────────┤
│                                                                       │
│  MOBILE APP                                                          │
│  ├── Framework: Flutter 3.x (Dart)                                  │
│  ├── State Management: Riverpod                                      │
│  ├── Local Database: Hive (NoSQL, fast, offline-first)              │
│  ├── HTTP Client: Dio                                                │
│  ├── Localization: flutter_localizations + intl                     │
│  ├── Hijri Dates: hijri package                                     │
│  └── UI: Material 3 + custom components                             │
│                                                                       │
│  BACKEND (Minimal)                                                   │
│  ├── AI Proxy: Cloudflare Worker (free tier)                        │
│  ├── AI Provider: Google Gemini API (free tier)                     │
│  └── Analytics: None (privacy-first) or Firebase (anonymous)        │
│                                                                       │
│  INFRASTRUCTURE                                                      │
│  ├── iOS: App Store Connect                                          │
│  ├── Android: Google Play Console                                    │
│  ├── CI/CD: GitHub Actions (free for public repos)                  │
│  └── Monitoring: Sentry (free tier, crash reporting)                │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
```

---

### 0.5 AI-First Strategy (Gemini MVP)

Instead of templates-first, we're going **AI-first** with templates as fallback:

```
User enters goal
       ↓
┌──────────────────┐
│ Online?          │
└────────┬─────────┘
         │
    YES  │  NO
         ↓   ↓
┌────────────────┐   ┌────────────────┐
│ Call Gemini    │   │ Show offline   │
│ via Cloudflare │   │ message +      │
│ Worker         │   │ template       │
└────────┬───────┘   │ suggestions    │
         │           └────────────────┘
         ↓
┌────────────────┐
│ Valid JSON?    │
└────────┬───────┘
         │
    YES  │  NO (retry 2x)
         ↓   ↓
┌────────────────┐   ┌────────────────┐
│ Parse & store  │   │ Use fallback   │
│ tasks locally  │   │ template       │
└────────────────┘   └────────────────┘
```

**Why AI-First:**
- Differentiator: Most apps use templates, we use AI
- User delight: Personalized plans feel magical
- Simpler MVP: Don't need to create 100+ templates upfront
- Gemini free tier: 1M tokens = ~10K goal generations/month

**Fallback templates (5 for MVP):**
1. "Complete the Quran in 30 days" (Ramadan)
2. "Pray 5 times daily" (Ramadan)
3. "Run a 5K in 30 days" (Fitness)
4. "Read 1 book in 30 days" (Learning)
5. "Meditate daily for 30 days" (Wellness)

---

### 0.6 Risk Mitigation

| Risk | Mitigation |
|------|------------|
| **Gemini API down** | 5 fallback templates, clear error message |
| **App Store rejection** | Submit early (Feb 20), allow 1 week buffer |
| **Arabic RTL bugs** | Test on real devices, use Flutter's built-in RTL |
| **Hijri date accuracy** | Use established `hijri` package, note regional variation |
| **Scope creep** | This document is the scope. No additions. |

---

### 0.7 Success Criteria for Ramadan 2026 Launch

| Metric | Target |
|--------|--------|
| App live before Ramadan | ✅ Feb 28 |
| Core flow works (create → track) | ✅ 100% |
| AI generates valid plans | ✅ >95% success rate |
| No critical crashes | ✅ <1% crash rate |
| Arabic RTL works correctly | ✅ 100% |

**Post-Ramadan targets (Month 1-2):**
- 1,000+ downloads
- 4.0+ App Store rating
- 10+ languages added

---

## 1. PRD Assessment: Gaps & Feasibility Analysis

This section provides a critical assessment of the PRD, identifying gaps, risks, and feasibility concerns.

### 1.1 Overall Feasibility Verdict

| Aspect | Feasibility | Confidence | Notes |
|--------|-------------|------------|-------|
| **Core Concept** | ✅ High | 95% | Proven market, clear value proposition |
| **Technical Architecture** | ✅ High | 90% | Standard mobile stack, well-documented |
| **AI Integration** | ✅ High | 85% | Gemini free tier + templates is viable |
| **2-Language Support (MVP)** | ✅ High | 90% | English + Arabic is achievable |
| **Zero-Cost Model** | ✅ High | 80% | Viable up to ~50K users |
| **Timeline (Before Ramadan 2026)** | ✅ High | 75% | Tight but achievable with reduced scope |

**Overall: FEASIBLE ✅**

---

### 1.2 Resolved Gaps

#### ~~GAP 1: No Framework Decision~~
**RESOLVED:** Flutter selected. Better RTL support, faster MVP, excellent offline storage.

#### ~~GAP 2: MVP Scope Too Large~~
**RESOLVED:** Reduced to 2 languages, AI-first with 5 fallback templates, minimal gamification.

#### GAP 3: Template Creation Not Planned
**Issue:** PRD relies heavily on templates (80% of users) but no plan for creating them.
**Impact:** Templates are the most critical cost-saving feature.
**Recommendation:** Add a template creation sprint before development:
- Week 1-2: Create 25 templates using AI (once, during development)
- Each template needs: tasks for 30/60/90 days, in all 12 languages
- Estimated effort: 40-60 hours of prompt engineering + review

#### GAP 4: Hijri Calendar Implementation
**Issue:** Ramadan mode requires Hijri calendar but no library/API specified.
**Impact:** Non-trivial to implement correctly (moon sighting variations).
**Recommendation:**
- Use established library: `hijri-converter` (Python) or `hijri-date` (JS)
- Or use API: `aladhan.com/api` for prayer times + Hijri dates
- Accept that Ramadan dates may vary by 1-2 days by region

#### GAP 5: Offline-First Not Fully Designed
**Issue:** Claims "offline capability" but AI generation requires internet.
**Impact:** Poor UX if user tries to create goal without internet.
**Recommendation:**
- Clear messaging: "Creating a plan requires internet"
- Once generated, all tracking works offline
- Queue goal creation requests if offline, sync when online

#### GAP 6: No Analytics Strategy
**Issue:** "No user tracking" but also needs "KPIs" like MAU, retention, completion rate.
**Impact:** Can't measure success without some analytics.
**Recommendation:**
- Use privacy-preserving analytics (Plausible, PostHog with anonymization)
- Or use app store analytics only (basic installs/uninstalls)
- Clarify what "no tracking" means (no PII, but aggregate OK?)

#### GAP 7: App Store Approval Risk
**Issue:** AI-generated content apps face stricter review.
**Impact:** Potential rejection or delays.
**Recommendation:**
- Review Apple's guidelines on AI-generated content
- Add clear disclosure: "Plans generated by AI"
- Implement content filtering BEFORE submission
- Plan for 2-3 review cycles

#### GAP 8: No Error Recovery for AI Failures
**Issue:** What if AI generates invalid JSON, times out, or returns unsafe content?
**Impact:** App crashes or poor UX.
**Recommendation:** Already partially addressed in PRD, but add:
- Retry with backoff (1s, 3s, 10s)
- Maximum 3 retries before showing error
- Cache last successful response format as fallback
- Manual template suggestion if AI fails

#### GAP 9: Cloudflare Worker Not Specified
**Issue:** Recommends Cloudflare Worker proxy but no implementation details.
**Impact:** Security risk if skipped.
**Recommendation:** Add to MVP requirements:
- Deploy worker BEFORE app launch
- Include rate limiting logic
- Add device fingerprinting for abuse prevention

#### GAP 10: Testing Strategy Missing
**Issue:** No QA plan, test cases, or testing approach defined.
**Impact:** Bugs in production, especially in AI/localization.
**Recommendation:** Add testing section:
- Unit tests for data models, date calculations
- Integration tests for AI response parsing
- Manual testing for each language
- Beta testing with real users (TestFlight/Play Console)

---

### 0.3 Feasibility Risks

#### RISK 1: Ramadan 2026 Timeline
**Assessment:** High Risk

Ramadan 2026 starts approximately **February 28, 2026** (depending on moon sighting).

| Today | Feb 1, 2026 |
|-------|-------------|
| Time until Ramadan | ~27 days |
| PRD Timeline | 4 weeks design + 8 weeks dev = 12 weeks |
| **Gap** | **~9 weeks short** |

**Options:**
1. **Launch MVP-0 before Ramadan** (English + templates only, no AI)
2. **Launch MVP-1 during Ramadan** (miss the start, catch the middle)
3. **Target Ramadan 2027** (full feature set, proper testing)

**Recommendation:** Option 1 - Launch bare minimum before Ramadan, iterate during the month.

#### RISK 2: AI Quality in Non-English Languages
**Assessment:** Medium Risk

| Language | Gemini Quality | Risk |
|----------|----------------|------|
| English | Excellent | Low |
| Spanish, French, German | Very Good | Low |
| Arabic | Good (formal), Variable (dialects) | Medium |
| Urdu, Hindi, Bengali | Good | Medium |
| Indonesian, Malay, Turkish | Variable | Medium-High |

**Mitigation:**
- Test AI output in each language before launch
- Use templates as fallback for problematic languages
- Allow users to report bad translations

#### RISK 3: Gemini API Changes
**Assessment:** Low-Medium Risk

Google may change free tier limits without notice.

**Mitigation:**
- Monitor API usage closely
- Have fallback to templates-only mode
- Budget $50-100/month for paid tier if needed
- Document alternative providers (Groq, Mistral)

#### RISK 4: Single-Device Data Loss
**Assessment:** Medium Risk

No cloud backup means:
- Uninstall = data loss
- Device switch = data loss
- Device failure = data loss

**Mitigation:**
- Clear warning during onboarding
- Easy JSON export feature
- Consider optional iCloud/Google Drive backup (Post-MVP)

---

### 0.4 Scope Reduction Recommendations

To improve feasibility, consider this phased approach:

#### MVP-0 (Launch Before Ramadan - 4 weeks)
**Goal:** Something working before Ramadan 2026

| Include | Exclude |
|---------|---------|
| English + Arabic only | 10 other languages |
| 15 pre-built templates | AI generation |
| Basic task checkboxes | Streaks, milestones |
| Simple progress bar | Gamification, badges |
| Ramadan mode (template-based) | Custom Ramadan goals |
| Local storage | Export/import |

**Effort:** 1 developer, 4 weeks

#### MVP-1 (During Ramadan - +4 weeks)
**Goal:** Add AI and core engagement features

| Add |
|-----|
| Gemini AI integration |
| +10 templates |
| Streaks (goal-specific) |
| Milestones |
| +Spanish, Urdu languages |

#### MVP-2 (Post-Ramadan - +4 weeks)
**Goal:** Full feature set

| Add |
|-----|
| All 12 languages |
| Full gamification |
| Donation system |
| Export/import |
| On-device AI exploration |

---

### 0.5 Questions to Resolve Before Development

| # | Question | Options | Impact |
|---|----------|---------|--------|
| 1 | Framework choice? | Flutter vs React Native | Architecture |
| 2 | MVP-0 scope acceptable? | Yes / No, need more | Timeline |
| 3 | Target Ramadan 2026 or 2027? | 2026 (rushed) / 2027 (complete) | Everything |
| 4 | How many templates to create? | 15 / 25 / 50 | Effort |
| 5 | Analytics approach? | None / Anonymous / Full | Privacy |
| 6 | Who creates templates? | You / AI + review / Outsource | Cost |
| 7 | Beta test before launch? | Yes (adds 2 weeks) / No | Quality |

---

### 0.6 Estimated Effort (Realistic)

| Phase | Tasks | Effort | Calendar Time |
|-------|-------|--------|---------------|
| **Setup** | Repo, CI/CD, project structure | 8 hrs | 1-2 days |
| **Templates** | Create 25 templates in 2 languages | 40 hrs | 1 week |
| **Core UI** | Onboarding, goal list, task view, settings | 60 hrs | 2 weeks |
| **Data Layer** | Local storage, models, state management | 30 hrs | 1 week |
| **AI Integration** | Gemini API, proxy, parsing, error handling | 40 hrs | 1.5 weeks |
| **Ramadan Mode** | Hijri dates, phases, special UI | 20 hrs | 3-4 days |
| **Localization** | i18n setup, 2 languages | 16 hrs | 2-3 days |
| **Polish** | Animations, dark mode, edge cases | 24 hrs | 3-4 days |
| **Testing** | Manual testing, bug fixes | 24 hrs | 3-4 days |
| **App Store** | Screenshots, descriptions, submission | 16 hrs | 2-3 days |
| **TOTAL** | | **~280 hrs** | **~8 weeks** |

**With 1 full-time developer:** 8 weeks
**With 2 developers:** 4-5 weeks
**For MVP-0 only:** 4 weeks with 1 developer

---

### 0.7 Final Recommendation

**For Ramadan 2026 launch:**

1. ✅ **Commit to MVP-0 scope** (templates only, 2 languages)
2. ✅ **Start template creation immediately** (this week)
3. ✅ **Choose Flutter** (or RN if you have experience)
4. ✅ **Deploy Cloudflare worker early** (Week 1)
5. ✅ **Submit to App Store by Feb 20** (allow review time)
6. ⚠️ **Add AI during Ramadan** (MVP-1 update)
7. ⚠️ **Full features post-Ramadan** (MVP-2)

This PRD is **comprehensive and well-thought-out**, but needs **scope reduction** to hit the Ramadan 2026 deadline. The AI strategy and technical architecture are solid.

---

## 1. Executive Summary

**TaskTrakr** (Arabic for "intention") is a free mobile application (iOS & Android) that helps users set, plan, and track any personal goal or habit. Using AI, the app transforms free-form aspirations into structured, actionable daily tasks over a customizable time period. Users can track their progress through simple checkboxes, build streaks, and achieve meaningful personal growth.

The app features a **specialized Ramadan Mode** for Muslims tracking spiritual goals during the holy month, while remaining flexible enough for any type of goal: fitness, learning, creativity, productivity, wellness, and more.

---

## 2. Problem Statement

### Current Challenges
- People set goals but lack concrete daily action plans
- Breaking down big goals into daily tasks is mentally taxing
- Existing habit apps require manual setup and don't adapt to goal complexity
- No easy way to track multiple goals simultaneously with personalized schedules
- Generic apps don't understand domain-specific contexts (spiritual, fitness, learning)

### Opportunity
Create an AI-powered goal planner that takes any aspiration and generates a personalized, achievable task schedule—making goal achievement accessible to everyone.

---

## 3. Target Users

### Target Audience: Global Users
This app is designed for **anyone worldwide** who wants to set and achieve personal goals. Users can select their preferred language on first launch, and all AI-generated content, tasks, and UI will be displayed in that language.

### Supported Languages (MVP)

| Language | Code | Region Coverage | AI Quality |
|----------|------|-----------------|------------|
| English | `en` | Global | Excellent |
| Spanish | `es` | Latin America, Spain | Excellent |
| Arabic | `ar` | Middle East, North Africa | Excellent |
| French | `fr` | France, Africa, Canada | Excellent |
| German | `de` | Germany, Austria, Switzerland | Excellent |
| Portuguese | `pt` | Brazil, Portugal | Excellent |
| Indonesian | `id` | Indonesia | Very Good |
| Turkish | `tr` | Turkey | Very Good |
| Urdu | `ur` | Pakistan, India | Very Good |
| Hindi | `hi` | India | Very Good |
| Bengali | `bn` | Bangladesh, India | Good |
| Malay | `ms` | Malaysia, Singapore | Good |

**Language Selection:**
- User selects language on first app launch
- Can be changed anytime in Settings
- All generated tasks, tips, and milestones appear in selected language
- UI labels and navigation in selected language
- Ramadan mode supports Arabic terminology regardless of selected language

**Why These Languages?**
- Cover 70%+ of global internet users
- AI (Claude/GPT) produces high-quality output in these languages
- Strong representation of Muslim-majority regions (for Ramadan mode)
- Expandable based on user demand

### User Segments
| Segment | Example Goals | Needs |
|---------|---------------|-------|
| Fitness Enthusiasts | Run a 5K, do 100 pushups | Progressive workout schedules |
| Learners | Learn Spanish, read 12 books | Structured learning plans |
| Muslims (Ramadan Mode) | Complete Quran, daily prayers | Islamic-aware scheduling |
| Creative Individuals | Write a novel, learn guitar | Creative habit building |
| Professionals | Build a portfolio, learn coding | Skill development tracking |
| Wellness Seekers | Meditate daily, sleep 8 hours | Wellness habit formation |
| Anyone with a Goal | Save $5000, declutter home | Flexible goal planning |

### Core User Need
Anyone thinking *"I want to achieve X but don't know where to start"* needs help turning intention into action—in their own language.

---

## 4. Product Goals & Success Metrics

### Goals
1. Help users define and clarify any personal goal
2. Use AI to create achievable, personalized task schedules
3. Enable easy daily progress tracking
4. Increase goal completion rates through structured planning
5. Provide specialized modes for domain-specific goals (starting with Ramadan)

### Key Performance Indicators (KPIs)
| Metric | Target |
|--------|--------|
| Monthly Active Users (MAU) | 100,000+ |
| Goal Completion Rate | >50% of tasks marked complete |
| User Retention (30-day) | >35% |
| App Store Rating | 4.5+ stars |
| Goals Created per User | 2+ goals average |

---

## 5. Features & Requirements

### 5.1 Core Features (MVP)

#### F1: Onboarding & Goal Setting
**Description:** Users describe their goals in free-form natural language

**Requirements:**
- Text input field for free-form goal description
- Support for multiple goals (unlimited)
- Voice-to-text input option
- Goal duration selector (7 days, 14 days, 30 days, 60 days, 90 days, custom)
- Goal category selection (optional, for better AI context):
  - 🏃 Fitness & Health
  - 📚 Learning & Education
  - 🎨 Creative & Hobbies
  - 💼 Career & Productivity
  - 🧘 Wellness & Mindfulness
  - 💰 Financial
  - 🌙 Ramadan / Islamic (special mode)
  - ✨ Other

**Sample Goal Templates by Category:**

| Category | Example Goals |
|----------|---------------|
| Fitness | "Run a 5K in 30 days", "Do 100 pushups daily", "Lose 10 pounds" |
| Learning | "Learn 500 Spanish words", "Read 4 books this month", "Complete Python course" |
| Creative | "Write 50,000 words (NaNoWriMo)", "Draw daily for 30 days", "Learn 10 guitar songs" |
| Wellness | "Meditate 10 mins daily", "Sleep by 10pm every night", "Drink 8 glasses of water" |
| Financial | "Save $1000", "No unnecessary purchases for 30 days", "Track all expenses" |
| Ramadan | "Complete reading the Quran", "Pray all 5 prayers on time", "Donate $1000 to charity" |

**Acceptance Criteria:**
- [ ] User can type goals in natural language
- [ ] User can select goal duration
- [ ] User can optionally select category for better AI context
- [ ] User can select from pre-defined goal templates
- [ ] User can add multiple goals
- [ ] Goals are saved and editable

---

#### F2: AI Task Generation
**Description:** AI analyzes user goals and generates a structured task schedule for the chosen duration

**Requirements:**
- Parse natural language goals to understand intent and scope
- Calculate daily/weekly breakdown based on goal magnitude and duration
- Consider domain-specific knowledge (fitness progression, learning curves, etc.)
- Generate realistic, achievable daily tasks
- Account for rest days where appropriate
- Allow regeneration if user is unsatisfied
- Support difficulty preferences (easy, moderate, challenging)

**AI Task Generation Examples:**

| User Input | Duration | Generated Daily Tasks |
|------------|----------|----------------------|
| "I want to run a 5K" | 30 days | Week 1: Walk 20 mins → Week 4: Run 5K |
| "Read 4 books this month" | 30 days | "Read 25 pages per day" with book transition days |
| "Learn 500 Spanish words" | 60 days | "Learn 8-10 new words + review 20 old words daily" |
| "Complete reading the Quran" | 30 days | "Read 1 Juz per day (20 pages)" |
| "Save $1000" | 30 days | "Set aside $33 today, track spending" |

**Acceptance Criteria:**
- [ ] AI generates tasks within 5 seconds
- [ ] Tasks are appropriately distributed across chosen duration
- [ ] Tasks respect domain-specific best practices
- [ ] User can regenerate tasks if unsatisfied
- [ ] Tasks include rest/buffer days where appropriate
- [ ] Difficulty scales appropriately (progressive overload for fitness, spaced repetition for learning)

---

#### F2.1: Ramadan Mode - Islamic Goal Specialization

**Description:** A specialized mode for Muslims tracking spiritual goals during Ramadan (or year-round Islamic goals).

**When Activated:**
- User selects "Ramadan / Islamic" category, OR
- User mentions Ramadan, Islamic, or related terms in goal

**Special Features:**
- Hijri calendar integration
- Ramadan phase awareness:
  - First 10 days: Mercy (رحمة)
  - Middle 10 days: Forgiveness (مغفرة)
  - Last 10 days: Salvation from hellfire (عتق من النار)
- Laylatul Qadr emphasis (last 10 odd nights)
- Islamic terminology in generated tasks
- Prayer time awareness (optional)

**Ramadan Goal Templates:**
- "Complete reading the entire Quran"
- "Pray all 5 daily prayers on time"
- "Pray Taraweeh every night"
- "Donate $X to charity"
- "Memorize X Surahs"
- "Read 1 Islamic book"
- "Make dua for 10 minutes daily"
- "Give up a bad habit"

**AI Prompt Additions for Ramadan Mode:**
```
Additional context: This is an Islamic spiritual goal for Ramadan.
- Consider the three phases of Ramadan
- Emphasize increased worship during the last 10 nights
- Use appropriate Islamic terminology
- Suggest extra worship for odd nights (21, 23, 25, 27, 29)
```

**Acceptance Criteria:**
- [ ] Ramadan mode activates correctly
- [ ] Tasks reflect Islamic context and terminology
- [ ] Last 10 nights show increased worship suggestions
- [ ] Hijri date displayed when in Ramadan mode

---

## F2.2: AI Integration Specification

This section defines the complete AI integration layer, including prompt engineering, response schema, and data transformation for the TaskTrakr app.

### Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INPUT                              │
│  "I want to read the Quran during Ramadan"                     │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    INPUT PROCESSOR                              │
│  • Detect category (ramadan)                                    │
│  • Extract duration (30 days)                                   │
│  • Identify special mode (ramadan)                              │
│  • Build context object                                         │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    PROMPT BUILDER                               │
│  • Select appropriate system prompt                             │
│  • Inject user context                                          │
│  • Add schema definition                                        │
│  • Include examples for consistency                             │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    AI API CALL                                  │
│  • Send to OpenAI/Claude API                                    │
│  • Request JSON mode                                            │
│  • Handle retries                                               │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                  RESPONSE VALIDATOR                             │
│  • Parse JSON                                                   │
│  • Validate against schema                                      │
│  • Check required fields                                        │
│  • Verify task count matches duration                           │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                  DATA TRANSFORMER                               │
│  • Convert to local data model                                  │
│  • Generate UUIDs                                               │
│  • Calculate dates                                              │
│  • Store in local database                                      │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                         UX LAYER                                │
│  • Display task cards                                           │
│  • Show progress rings                                          │
│  • Enable checkboxes                                            │
└─────────────────────────────────────────────────────────────────┘
```

---

### Input Context Object

Before calling the AI, the app constructs this context object from user input:

```typescript
interface GoalContext {
  // User's raw input (can be in any language)
  raw_input: string;                    // "I want to run a 5K" or "أريد أن أختم القرآن"

  // Language setting (from user preferences)
  language: LanguageCode;               // "en", "ar", "es", etc.

  // Derived/selected values
  category: CategoryType;               // "fitness", "ramadan", etc.
  duration_days: number;                // 30
  start_date: string;                   // "2026-02-28" (ISO format)

  // Optional modifiers
  difficulty?: "easy" | "moderate" | "challenging";
  special_mode?: "ramadan" | "dhul_hijjah" | null;

  // Ramadan-specific (auto-populated when special_mode = "ramadan")
  ramadan_context?: {
    hijri_start: string;                // "1447-09-01"
    phase_1_end: number;                // Day 10
    phase_2_end: number;                // Day 20
    laylatul_qadr_nights: number[];     // [21, 23, 25, 27, 29]
  };
}

type CategoryType =
  | "fitness"
  | "learning"
  | "creative"
  | "wellness"
  | "financial"
  | "ramadan"
  | "other";

type LanguageCode =
  | "en"   // English
  | "es"   // Spanish
  | "ar"   // Arabic
  | "fr"   // French
  | "de"   // German
  | "pt"   // Portuguese
  | "id"   // Indonesian
  | "tr"   // Turkish
  | "ur"   // Urdu
  | "hi"   // Hindi
  | "bn"   // Bengali
  | "ms";  // Malay
```

---

### System Prompts

#### Base System Prompt (All Categories)

```
You are TaskTrakr, an AI goal planning assistant. Your job is to take a user's goal and create a structured daily task schedule.

IMPORTANT: Respond in the language specified by the "language" parameter. All task descriptions, notes, tips, and milestone text must be in that language.

RULES:
1. Respond ONLY with valid JSON matching the exact schema provided
2. Generate exactly one task per day for the specified duration
3. Tasks must be specific, actionable, and achievable in the estimated time
4. Progress should build logically (easier → harder, or cumulative)
5. ALL text content (tasks, notes, tips, milestones) must be in the specified language
5. Include 1-2 rest days per week where appropriate
6. Milestones should mark meaningful progress points
7. Tips should be practical and encouraging

TASK QUALITY GUIDELINES:
- Be specific: "Read pages 1-20 of Chapter 1" not "Read some pages"
- Be measurable: "Run for 15 minutes" not "Go for a run"
- Be realistic: Don't schedule 3 hours of work for a 30-minute goal
- Be progressive: Day 1 should be easier than Day 30
```

#### Category-Specific Prompt Additions

**Fitness:**
```
CATEGORY: FITNESS
- Apply progressive overload (gradually increase intensity)
- Include warm-up/cool-down reminders in notes
- Schedule rest days (typically every 3-4 days for beginners)
- Account for muscle recovery
- Suggest alternatives for bad weather (if outdoor activity)
```

**Learning:**
```
CATEGORY: LEARNING
- Apply spaced repetition principles
- Balance new material with review
- Include practice/application tasks, not just reading
- Break complex topics into digestible chunks
- Suggest active recall techniques
```

**Ramadan (Special Mode):**
```
CATEGORY: RAMADAN / ISLAMIC
- This is a sacred time; tasks should be spiritually meaningful
- Consider the three phases of Ramadan:
  * Days 1-10: Mercy (رحمة) - Establish routines
  * Days 11-20: Forgiveness (مغفرة) - Deepen practice
  * Days 21-30: Salvation (عتق من النار) - Intensify worship
- Laylatul Qadr falls on odd nights in the last 10 days
  * Days 21, 23, 25, 27, 29 should have INCREASED tasks
- Use Islamic terminology appropriately (Juz, Surah, Rakah, etc.)
- Consider fasting schedule (tasks may be lighter during day)
- Suggest best times: after Fajr, before Iftar, after Taraweeh

IMPORTANT: For Quran reading goals:
- 1 Juz = ~20 pages = ~30-45 minutes reading
- Full Quran = 30 Juz = 1 Juz per day for 30 days
- Adjust pace based on user's stated goal
```

**Financial:**
```
CATEGORY: FINANCIAL
- Break monetary goals into daily/weekly amounts
- Include tracking tasks, not just saving
- Suggest specific actions (pack lunch, skip coffee)
- Account for weekends/paydays differently if relevant
```

---

### AI Response Schema (TaskTrakr Format)

This is the **exact schema** the AI must return. The app's UX is built to consume this format.

```typescript
interface TaskTrakrPlanResponse {
  // Meta
  success: boolean;
  error_message?: string;              // Only if success = false

  // Goal Summary (displayed in UI)
  goal: {
    title: string;                     // "Complete Reading the Quran"
    title_short: string;               // "Read Quran" (for compact UI)
    category: CategoryType;
    duration_days: number;
    difficulty: "easy" | "moderate" | "challenging";
    description: string;               // 1-2 sentence summary
    icon_suggestion: string;           // Emoji: "📖" or "🏃"
  };

  // Daily Tasks (one per day)
  tasks: TaskTrakrTask[];

  // Milestones (3-5 key checkpoints)
  milestones: TaskTrakrMilestone[];

  // Tips (3-5 practical tips)
  tips: string[];

  // Special mode data (optional)
  ramadan_data?: RamadanData;
}

interface TaskTrakrTask {
  day: number;                         // 1, 2, 3... (1-indexed)
  task: string;                        // "Read Juz 1 (Surah Al-Fatiha to Al-Baqarah 141)"
  task_short: string;                  // "Read Juz 1" (for compact display)
  estimated_minutes: number;           // 30
  is_rest_day: boolean;                // false
  notes?: string;                      // "Best read after Fajr prayer"
  intensity: "light" | "moderate" | "intense";

  // Ramadan-specific (only when special_mode = "ramadan")
  ramadan_phase?: "mercy" | "forgiveness" | "salvation";
  is_laylatul_qadr_night?: boolean;
}

interface TaskTrakrMilestone {
  day: number;                         // When this milestone should be achieved
  title: string;                       // "First 10 Juz Complete"
  description: string;                 // "You've read 1/3 of the Quran!"
  icon: string;                        // "🎉" or "⭐"
}

interface RamadanData {
  phases: {
    mercy: { start: 1, end: 10 };
    forgiveness: { start: 11, end: 20 };
    salvation: { start: 21, end: 30 };
  };
  laylatul_qadr_nights: number[];      // [21, 23, 25, 27, 29]
  special_nights_message: string;      // "Increase worship on these nights"
}
```

---

### Example AI Requests/Responses

Below are examples showing how the AI generates plans for different goal categories and languages.

---

#### Example 1: Fitness Goal (Run a 5K) - English

**Request:**
```json
{
  "model": "claude-3-5-sonnet-20241022",
  "max_tokens": 4096,
  "messages": [
    {
      "role": "system",
      "content": "[Base system prompt + Fitness additions + Schema definition]"
    },
    {
      "role": "user",
      "content": {
        "goal_input": "I want to run a 5K",
        "language": "en",
        "category": "fitness",
        "duration_days": 30,
        "start_date": "2026-02-01",
        "difficulty": "moderate"
      }
    }
  ],
  "response_format": { "type": "json_object" }
}
```

**Response:**
```json
{
  "success": true,
  "goal": {
    "title": "Run a 5K",
    "title_short": "Run 5K",
    "category": "fitness",
    "duration_days": 30,
    "difficulty": "moderate",
    "description": "Build up from walking to running 5K (3.1 miles) in 30 days using a gradual progression approach.",
    "icon_suggestion": "🏃"
  },
  "tasks": [
    {
      "day": 1,
      "task": "Brisk walk for 20 minutes at a comfortable pace",
      "task_short": "Walk 20 min",
      "estimated_minutes": 20,
      "is_rest_day": false,
      "notes": "Focus on good posture. This is your baseline.",
      "intensity": "light"
    },
    {
      "day": 2,
      "task": "Walk 20 minutes with two 1-minute jog intervals",
      "task_short": "Walk + jog intervals",
      "estimated_minutes": 20,
      "is_rest_day": false,
      "notes": "Jog at a pace where you can still talk.",
      "intensity": "light"
    },
    {
      "day": 7,
      "task": "Rest day - light stretching only",
      "task_short": "Rest day 🧘",
      "estimated_minutes": 10,
      "is_rest_day": true,
      "notes": "Recovery is when your body gets stronger!",
      "intensity": "light"
    },
    {
      "day": 15,
      "task": "Run 2K continuously, walk 1K, run 1K",
      "task_short": "Run 2K + intervals",
      "estimated_minutes": 30,
      "is_rest_day": false,
      "notes": "You're halfway there! Your endurance is building.",
      "intensity": "moderate"
    },
    {
      "day": 28,
      "task": "Easy 3K jog at comfortable pace",
      "task_short": "Easy 3K jog",
      "estimated_minutes": 25,
      "is_rest_day": false,
      "notes": "Taper day - save energy for your 5K!",
      "intensity": "light"
    },
    {
      "day": 30,
      "task": "Run your first 5K! 🎉",
      "task_short": "Run 5K! 🎉",
      "estimated_minutes": 35,
      "is_rest_day": false,
      "notes": "You did it! Celebrate this achievement.",
      "intensity": "intense"
    }
  ],
  "milestones": [
    {
      "day": 7,
      "title": "First Week Complete",
      "description": "You've built the habit of daily movement!",
      "icon": "✅"
    },
    {
      "day": 14,
      "title": "Run 1 Mile Non-Stop",
      "description": "A huge milestone - your first continuous mile!",
      "icon": "🏅"
    },
    {
      "day": 21,
      "title": "Run 3K Non-Stop",
      "description": "More than halfway to 5K distance!",
      "icon": "⭐"
    },
    {
      "day": 30,
      "title": "5K Complete!",
      "description": "You ran 5 kilometers. You're a runner now!",
      "icon": "🏆"
    }
  ],
  "tips": [
    "Invest in proper running shoes - they make a huge difference",
    "Run at a pace where you can hold a conversation",
    "Hydrate well throughout the day, not just before runs",
    "If something hurts, take an extra rest day - consistency beats intensity",
    "Stretch for 5 minutes after every run"
  ]
}
```

---

#### Example 2: Learning Goal (Learn Spanish)

**Request:**
```json
{
  "goal_input": "I want to learn 500 Spanish words",
  "category": "learning",
  "duration_days": 60,
  "start_date": "2026-03-01",
  "difficulty": "moderate"
}
```

**Response:**
```json
{
  "success": true,
  "goal": {
    "title": "Learn 500 Spanish Words",
    "title_short": "Learn Spanish",
    "category": "learning",
    "duration_days": 60,
    "difficulty": "moderate",
    "description": "Learn 500 high-frequency Spanish words using spaced repetition, building practical vocabulary.",
    "icon_suggestion": "🇪🇸"
  },
  "tasks": [
    {
      "day": 1,
      "task": "Learn 10 basic greetings: hola, adiós, buenos días, etc.",
      "task_short": "10 greetings",
      "estimated_minutes": 15,
      "is_rest_day": false,
      "notes": "Practice saying each word out loud 3 times.",
      "intensity": "light"
    },
    {
      "day": 2,
      "task": "Learn 10 common nouns: casa, agua, comida, etc. Review Day 1 words.",
      "task_short": "10 nouns + review",
      "estimated_minutes": 20,
      "is_rest_day": false,
      "notes": "Spaced repetition: review yesterday's words before new ones.",
      "intensity": "moderate"
    },
    {
      "day": 7,
      "task": "Review day - no new words. Quiz yourself on all 60 words learned.",
      "task_short": "Review week 1",
      "estimated_minutes": 20,
      "is_rest_day": false,
      "notes": "Use flashcards or a quiz app. Note which words are hardest.",
      "intensity": "light"
    },
    {
      "day": 30,
      "task": "Learn 8 new words + comprehensive review of first 250 words",
      "task_short": "8 new + big review",
      "estimated_minutes": 30,
      "is_rest_day": false,
      "notes": "Halfway point! You know 250 words now.",
      "intensity": "moderate"
    },
    {
      "day": 60,
      "task": "Final review - test yourself on all 500 words!",
      "task_short": "Final test 🎓",
      "estimated_minutes": 45,
      "is_rest_day": false,
      "notes": "Celebrate! You've built a solid Spanish vocabulary foundation.",
      "intensity": "moderate"
    }
  ],
  "milestones": [
    {
      "day": 10,
      "title": "First 100 Words",
      "description": "You know 100 Spanish words! That's enough for basic phrases.",
      "icon": "📚"
    },
    {
      "day": 30,
      "title": "250 Words - Halfway!",
      "description": "You can understand simple conversations now.",
      "icon": "⭐"
    },
    {
      "day": 45,
      "title": "400 Words",
      "description": "You're in the top tier of beginner vocabulary!",
      "icon": "🔥"
    },
    {
      "day": 60,
      "title": "500 Words Complete!",
      "description": "Incredible! You've learned 500 Spanish words.",
      "icon": "🏆"
    }
  ],
  "tips": [
    "Use a spaced repetition app like Anki for better retention",
    "Label objects in your house with Spanish sticky notes",
    "Listen to Spanish music or podcasts during commute",
    "Practice speaking out loud - pronunciation matters",
    "Focus on high-frequency words first - they're most useful"
  ]
}
```

---

#### Example 3: Financial Goal (Save $1000)

**Request:**
```json
{
  "goal_input": "I want to save $1000",
  "category": "financial",
  "duration_days": 30,
  "start_date": "2026-02-01",
  "difficulty": "challenging"
}
```

**Response:**
```json
{
  "success": true,
  "goal": {
    "title": "Save $1,000 in 30 Days",
    "title_short": "Save $1K",
    "category": "financial",
    "duration_days": 30,
    "difficulty": "challenging",
    "description": "Save $1,000 through daily micro-savings and spending awareness.",
    "icon_suggestion": "💰"
  },
  "tasks": [
    {
      "day": 1,
      "task": "Set up a dedicated savings account. Transfer $33 to start.",
      "task_short": "Setup + save $33",
      "estimated_minutes": 15,
      "is_rest_day": false,
      "notes": "Separate account makes tracking easier.",
      "intensity": "moderate"
    },
    {
      "day": 2,
      "task": "Review last month's spending. Identify 3 areas to cut. Save $33.",
      "task_short": "Audit spending + $33",
      "estimated_minutes": 20,
      "is_rest_day": false,
      "notes": "Common cuts: subscriptions, dining out, impulse buys.",
      "intensity": "moderate"
    },
    {
      "day": 7,
      "task": "No-spend day challenge. Transfer $35 to savings.",
      "task_short": "No-spend day + $35",
      "estimated_minutes": 5,
      "is_rest_day": false,
      "notes": "Prep meals in advance. Avoid stores.",
      "intensity": "moderate"
    },
    {
      "day": 15,
      "task": "Halfway check: you should have ~$500 saved. Adjust if behind.",
      "task_short": "Halfway review + $33",
      "estimated_minutes": 15,
      "is_rest_day": false,
      "notes": "On track? Great! Behind? Increase daily amount.",
      "intensity": "light"
    },
    {
      "day": 30,
      "task": "Final transfer to hit $1,000! Review what worked.",
      "task_short": "Complete $1K! 🎉",
      "estimated_minutes": 10,
      "is_rest_day": false,
      "notes": "You did it! Consider keeping this habit going.",
      "intensity": "light"
    }
  ],
  "milestones": [
    {
      "day": 7,
      "title": "First $250 Saved",
      "description": "25% of your goal - great start!",
      "icon": "💵"
    },
    {
      "day": 15,
      "title": "Halfway - $500",
      "description": "Half of $1,000 is in your account!",
      "icon": "⭐"
    },
    {
      "day": 23,
      "title": "$750 Milestone",
      "description": "Just one more week to go!",
      "icon": "🔥"
    },
    {
      "day": 30,
      "title": "$1,000 Saved!",
      "description": "You saved $1,000 in one month!",
      "icon": "🏆"
    }
  ],
  "tips": [
    "Automate transfers - set up daily $33 auto-transfer",
    "Use the 24-hour rule: wait a day before non-essential purchases",
    "Pack lunch instead of buying - saves ~$10/day",
    "Cancel unused subscriptions - check bank statements",
    "Sell items you don't use for extra savings boost"
  ]
}
```

---

#### Example 4: Ramadan Goal (Special Mode)

**Request:**
```json
{
  "goal_input": "I want to complete reading the Quran during Ramadan",
  "category": "ramadan",
  "duration_days": 30,
  "start_date": "2026-02-28",
  "difficulty": "moderate",
  "special_mode": "ramadan",
  "ramadan_context": {
    "hijri_start": "1447-09-01",
    "laylatul_qadr_nights": [21, 23, 25, 27, 29]
  }
}
```

**Response:**
```json
{
  "success": true,
  "goal": {
    "title": "Complete Reading the Quran",
    "title_short": "Read Quran",
    "category": "ramadan",
    "duration_days": 30,
    "difficulty": "moderate",
    "description": "Read one Juz (20 pages) each day to complete the entire Quran during Ramadan.",
    "icon_suggestion": "📖"
  },
  "tasks": [
    {
      "day": 1,
      "task": "Read Juz 1: Surah Al-Fatiha and Al-Baqarah (verses 1-141)",
      "task_short": "Read Juz 1",
      "estimated_minutes": 35,
      "is_rest_day": false,
      "notes": "Start your journey with intention. Best read after Fajr.",
      "intensity": "moderate",
      "ramadan_phase": "mercy",
      "is_laylatul_qadr_night": false
    },
    {
      "day": 21,
      "task": "Read Juz 21 + Extended Dua session",
      "task_short": "Juz 21 + Dua",
      "estimated_minutes": 50,
      "is_rest_day": false,
      "notes": "⭐ Potential Laylatul Qadr! Increase worship tonight.",
      "intensity": "intense",
      "ramadan_phase": "salvation",
      "is_laylatul_qadr_night": true
    },
    {
      "day": 30,
      "task": "Read Juz 30: An-Naba to An-Nas - Complete the Quran!",
      "task_short": "Complete Juz 30 🎉",
      "estimated_minutes": 30,
      "is_rest_day": false,
      "notes": "Alhamdulillah! Make dua for acceptance.",
      "intensity": "moderate",
      "ramadan_phase": "salvation",
      "is_laylatul_qadr_night": false
    }
  ],
  "milestones": [
    { "day": 10, "title": "First 10 Juz", "description": "Days of mercy complete!", "icon": "🌙" },
    { "day": 20, "title": "Two-Thirds Done", "description": "Entering the final 10 nights.", "icon": "⭐" },
    { "day": 30, "title": "Khatm Al-Quran", "description": "You completed the Quran!", "icon": "🏆" }
  ],
  "tips": [
    "Read after Fajr when your mind is fresh",
    "Use a Quran app with translation if helpful",
    "If you miss a day, combine two Juz the next day",
    "Make dua before and after each session"
  ],
  "ramadan_data": {
    "phases": {
      "mercy": { "start": 1, "end": 10 },
      "forgiveness": { "start": 11, "end": 20 },
      "salvation": { "start": 21, "end": 30 }
    },
    "laylatul_qadr_nights": [21, 23, 25, 27, 29],
    "special_nights_message": "Seek Laylatul Qadr in the odd nights of the last ten days"
  }
}
```

---

#### Example 5: Spanish Language Goal (Fitness)

**Request:**
```json
{
  "goal_input": "Quiero correr 5 kilómetros",
  "language": "es",
  "category": "fitness",
  "duration_days": 30,
  "start_date": "2026-02-01",
  "difficulty": "moderate"
}
```

**Response (all content in Spanish):**
```json
{
  "success": true,
  "goal": {
    "title": "Correr 5 Kilómetros",
    "title_short": "Correr 5K",
    "category": "fitness",
    "duration_days": 30,
    "difficulty": "moderate",
    "description": "Progresa de caminar a correr 5K en 30 días con un enfoque gradual.",
    "icon_suggestion": "🏃"
  },
  "tasks": [
    {
      "day": 1,
      "task": "Caminar a paso rápido durante 20 minutos",
      "task_short": "Caminar 20 min",
      "estimated_minutes": 20,
      "is_rest_day": false,
      "notes": "Enfócate en buena postura. Esta es tu línea base.",
      "intensity": "light"
    },
    {
      "day": 15,
      "task": "Correr 2K sin parar, caminar 1K, correr 1K",
      "task_short": "Correr 2K + intervalos",
      "estimated_minutes": 30,
      "is_rest_day": false,
      "notes": "¡Ya estás a mitad de camino! Tu resistencia está mejorando.",
      "intensity": "moderate"
    },
    {
      "day": 30,
      "task": "¡Corre tus primeros 5K! 🎉",
      "task_short": "¡Correr 5K! 🎉",
      "estimated_minutes": 35,
      "is_rest_day": false,
      "notes": "¡Lo lograste! Celebra este logro.",
      "intensity": "intense"
    }
  ],
  "milestones": [
    { "day": 7, "title": "Primera Semana Completa", "description": "¡Has creado el hábito de moverte diariamente!", "icon": "✅" },
    { "day": 14, "title": "1 Milla Sin Parar", "description": "¡Un gran logro - tu primera milla continua!", "icon": "🏅" },
    { "day": 30, "title": "¡5K Completado!", "description": "Corriste 5 kilómetros. ¡Ahora eres un corredor!", "icon": "🏆" }
  ],
  "tips": [
    "Invierte en zapatos adecuados para correr",
    "Corre a un ritmo donde puedas mantener una conversación",
    "Hidrátate bien durante todo el día",
    "Si algo duele, toma un día extra de descanso",
    "Estira durante 5 minutos después de cada carrera"
  ]
}
```

---

#### Example 6: Arabic Language Goal (Ramadan)

**Request:**
```json
{
  "goal_input": "أريد أن أختم القرآن في رمضان",
  "language": "ar",
  "category": "ramadan",
  "duration_days": 30,
  "start_date": "2026-02-28",
  "difficulty": "moderate",
  "special_mode": "ramadan"
}
```

**Response (all content in Arabic):**
```json
{
  "success": true,
  "goal": {
    "title": "ختم القرآن الكريم",
    "title_short": "ختم القرآن",
    "category": "ramadan",
    "duration_days": 30,
    "difficulty": "moderate",
    "description": "قراءة جزء واحد يومياً لختم القرآن الكريم خلال شهر رمضان المبارك.",
    "icon_suggestion": "📖"
  },
  "tasks": [
    {
      "day": 1,
      "task": "قراءة الجزء الأول: سورة الفاتحة وبداية سورة البقرة",
      "task_short": "الجزء الأول",
      "estimated_minutes": 35,
      "is_rest_day": false,
      "notes": "ابدأ رحلتك بنية صادقة. أفضل وقت للقراءة بعد صلاة الفجر.",
      "intensity": "moderate",
      "ramadan_phase": "mercy",
      "is_laylatul_qadr_night": false
    },
    {
      "day": 27,
      "task": "قراءة الجزء السابع والعشرين + قيام الليل والدعاء",
      "task_short": "الجزء ٢٧ + دعاء",
      "estimated_minutes": 60,
      "is_rest_day": false,
      "notes": "⭐ ليلة القدر المحتملة! أكثر من العبادة والدعاء.",
      "intensity": "intense",
      "ramadan_phase": "salvation",
      "is_laylatul_qadr_night": true
    },
    {
      "day": 30,
      "task": "قراءة الجزء الثلاثين: جزء عم - ختم القرآن!",
      "task_short": "ختم القرآن 🎉",
      "estimated_minutes": 30,
      "is_rest_day": false,
      "notes": "الحمد لله! ادع الله أن يتقبل منك.",
      "intensity": "moderate",
      "ramadan_phase": "salvation",
      "is_laylatul_qadr_night": false
    }
  ],
  "milestones": [
    { "day": 10, "title": "أول عشرة أجزاء", "description": "أتممت ثلث القرآن! انتهت أيام الرحمة.", "icon": "🌙" },
    { "day": 20, "title": "عشرون جزءاً", "description": "ثلثا القرآن. تدخل العشر الأواخر المباركة.", "icon": "⭐" },
    { "day": 30, "title": "ختم القرآن", "description": "ختمت القرآن الكريم! بارك الله فيك.", "icon": "🏆" }
  ],
  "tips": [
    "اقرأ بعد صلاة الفجر حين يكون الذهن صافياً",
    "استخدم تطبيق قرآن مع الترجمة إذا احتجت",
    "إذا فاتك يوم، اقرأ جزأين في اليوم التالي",
    "ادع قبل وبعد كل جلسة قراءة"
  ],
  "ramadan_data": {
    "phases": {
      "mercy": { "start": 1, "end": 10 },
      "forgiveness": { "start": 11, "end": 20 },
      "salvation": { "start": 21, "end": 30 }
    },
    "laylatul_qadr_nights": [21, 23, 25, 27, 29],
    "special_nights_message": "تحروا ليلة القدر في الليالي الوترية من العشر الأواخر"
  }
}
```

---

### Local Data Model (Stored on Device)

After parsing the AI response, data is transformed into this local model:

```typescript
// Stored in SQLite / Hive / AsyncStorage

interface StoredGoal {
  id: string;                          // UUID generated locally
  title: string;                       // In user's selected language
  title_short: string;                 // In user's selected language
  category: CategoryType;
  icon: string;
  description: string;                 // In user's selected language
  language: LanguageCode;              // Language this goal was generated in

  duration_days: number;
  start_date: string;                  // ISO date
  end_date: string;                    // Calculated: start + duration

  difficulty: string;
  special_mode: string | null;

  // Aggregated stats (updated as user progresses)
  stats: {
    tasks_completed: number;
    tasks_total: number;
    current_streak: number;
    best_streak: number;
    completion_percentage: number;
  };

  created_at: string;
  updated_at: string;
}

// User preferences stored separately
interface UserPreferences {
  language: LanguageCode;              // User's selected language
  notifications_enabled: boolean;
  reminder_time: string | null;        // e.g., "09:00"
  theme: "light" | "dark" | "system";
  haptics_enabled: boolean;
  sound_enabled: boolean;
}

interface StoredTask {
  id: string;                          // UUID generated locally
  goal_id: string;                     // Foreign key

  day: number;
  date: string;                        // Calculated from start_date + day

  task: string;
  task_short: string;
  estimated_minutes: number;
  notes: string | null;
  intensity: string;
  is_rest_day: boolean;

  // Ramadan-specific
  ramadan_phase: string | null;
  is_laylatul_qadr_night: boolean;

  // User progress
  completed: boolean;
  completed_at: string | null;
}

interface StoredMilestone {
  id: string;                          // UUID generated locally
  goal_id: string;                     // Foreign key

  day: number;
  title: string;
  description: string;
  icon: string;

  achieved: boolean;
  achieved_at: string | null;
}

interface StoredTip {
  id: string;
  goal_id: string;
  text: string;
  order: number;
}
```

---

### Response Validation Rules

Before storing, the app validates the AI response:

| Rule | Validation | Action if Invalid |
|------|------------|-------------------|
| JSON parseable | `JSON.parse()` succeeds | Retry AI call once |
| success = true | `response.success === true` | Show error_message to user |
| Task count matches | `tasks.length === duration_days` | Retry with explicit instruction |
| Days are sequential | Days 1, 2, 3... with no gaps | Retry or auto-fix |
| Required fields present | All non-optional fields exist | Retry AI call |
| Estimated time reasonable | 5 ≤ minutes ≤ 180 | Cap at bounds |
| Category matches | Response category matches input | Override with input |
| No empty tasks | `task.length > 0` | Retry AI call |

**Validation Code (pseudocode):**
```typescript
function validateTaskTrakrResponse(response: any, input: GoalContext): ValidationResult {
  const errors: string[] = [];

  // 1. Check structure
  if (!response.success) {
    return { valid: false, error: response.error_message || "AI returned failure" };
  }

  // 2. Check task count
  if (response.tasks?.length !== input.duration_days) {
    errors.push(`Expected ${input.duration_days} tasks, got ${response.tasks?.length}`);
  }

  // 3. Check sequential days
  response.tasks?.forEach((task, index) => {
    if (task.day !== index + 1) {
      errors.push(`Task day mismatch at index ${index}`);
    }
  });

  // 4. Check required fields
  const requiredTaskFields = ['day', 'task', 'task_short', 'estimated_minutes'];
  response.tasks?.forEach((task, index) => {
    requiredTaskFields.forEach(field => {
      if (task[field] === undefined || task[field] === null) {
        errors.push(`Task ${index + 1} missing required field: ${field}`);
      }
    });
  });

  // 5. Ramadan-specific validation
  if (input.special_mode === 'ramadan') {
    if (!response.ramadan_data) {
      errors.push("Ramadan mode requires ramadan_data");
    }
    response.tasks?.forEach((task, index) => {
      if (!task.ramadan_phase) {
        errors.push(`Task ${index + 1} missing ramadan_phase`);
      }
    });
  }

  return {
    valid: errors.length === 0,
    errors
  };
}
```

---

### Data Transformation Pipeline

```typescript
function transformAIResponseToLocalData(
  response: TaskTrakrPlanResponse,
  input: GoalContext
): { goal: StoredGoal, tasks: StoredTask[], milestones: StoredMilestone[], tips: StoredTip[] } {

  const goalId = generateUUID();
  const now = new Date().toISOString();

  // 1. Create Goal
  const goal: StoredGoal = {
    id: goalId,
    title: response.goal.title,
    title_short: response.goal.title_short,
    category: response.goal.category,
    icon: response.goal.icon_suggestion,
    description: response.goal.description,
    duration_days: response.goal.duration_days,
    start_date: input.start_date,
    end_date: addDays(input.start_date, response.goal.duration_days - 1),
    difficulty: response.goal.difficulty,
    special_mode: input.special_mode || null,
    stats: {
      tasks_completed: 0,
      tasks_total: response.tasks.length,
      current_streak: 0,
      best_streak: 0,
      completion_percentage: 0
    },
    created_at: now,
    updated_at: now
  };

  // 2. Create Tasks
  const tasks: StoredTask[] = response.tasks.map(task => ({
    id: generateUUID(),
    goal_id: goalId,
    day: task.day,
    date: addDays(input.start_date, task.day - 1),
    task: task.task,
    task_short: task.task_short,
    estimated_minutes: task.estimated_minutes,
    notes: task.notes || null,
    intensity: task.intensity,
    is_rest_day: task.is_rest_day,
    ramadan_phase: task.ramadan_phase || null,
    is_laylatul_qadr_night: task.is_laylatul_qadr_night || false,
    completed: false,
    completed_at: null
  }));

  // 3. Create Milestones
  const milestones: StoredMilestone[] = response.milestones.map(m => ({
    id: generateUUID(),
    goal_id: goalId,
    day: m.day,
    title: m.title,
    description: m.description,
    icon: m.icon,
    achieved: false,
    achieved_at: null
  }));

  // 4. Create Tips
  const tips: StoredTip[] = response.tips.map((text, index) => ({
    id: generateUUID(),
    goal_id: goalId,
    text,
    order: index
  }));

  return { goal, tasks, milestones, tips };
}
```

---

### UX Field Mapping

How the stored data maps to UI elements:

| UI Element | Data Source |
|------------|-------------|
| Goal card title | `goal.title_short` |
| Goal card icon | `goal.icon` |
| Goal progress ring | `goal.stats.completion_percentage` |
| Goal streak badge | `goal.stats.current_streak` |
| Today's task card | `task.task_short` |
| Task detail view | `task.task` + `task.notes` |
| Time estimate | `task.estimated_minutes` formatted as "30 min" |
| Checkbox state | `task.completed` |
| Calendar heatmap | Aggregated `task.completed` by date |
| Milestone celebration | `milestone.title` when `milestone.day === today` |
| Tips carousel | `tips[].text` |
| Ramadan phase indicator | `task.ramadan_phase` |
| Laylatul Qadr badge | `task.is_laylatul_qadr_night` |

---

### Error Handling & Retry Strategy

```typescript
async function generateGoalPlan(input: GoalContext): Promise<Result<StoredData>> {
  const MAX_RETRIES = 2;

  for (let attempt = 1; attempt <= MAX_RETRIES; attempt++) {
    try {
      // 1. Build prompt
      const prompt = buildPrompt(input);

      // 2. Call AI
      const response = await callAI(prompt);

      // 3. Parse JSON
      const parsed = JSON.parse(response);

      // 4. Validate
      const validation = validateTaskTrakrResponse(parsed, input);

      if (!validation.valid) {
        if (attempt < MAX_RETRIES) {
          // Add validation errors to next prompt for self-correction
          continue;
        }
        return { success: false, error: "AI response validation failed" };
      }

      // 5. Transform & store
      const data = transformAIResponseToLocalData(parsed, input);
      await storeLocally(data);

      return { success: true, data };

    } catch (error) {
      if (error instanceof NetworkError) {
        return { success: false, error: "offline", retryable: true };
      }
      if (attempt < MAX_RETRIES) {
        continue;
      }
      return { success: false, error: "Failed to generate plan" };
    }
  }
}
```

---

### API Cost Optimization

| Strategy | Implementation |
|----------|----------------|
| Prompt caching | Cache system prompts (they don't change) |
| Response caching | Cache common goal plans (e.g., "Read Quran in Ramadan") |
| Token efficiency | Use `task_short` in prompts, not full descriptions |
| Batch generation | Generate full 30-day plan in one call, not daily |
| Model selection | Use smaller/faster model for simple goals |

**Estimated tokens per request:**
- System prompt: ~500 tokens
- User context: ~100 tokens
- Response (30 days): ~2000 tokens
- **Total: ~2600 tokens per goal creation**

---

#### F3: Daily Task Dashboard
**Description:** Main screen showing today's tasks with checkbox completion

**Requirements:**
- Clear list of today's tasks across all goals
- Checkbox to mark tasks complete
- Visual progress indicator per goal
- Swipe gestures for quick actions
- Color coding by goal category
- "Today's Focus" highlight
- Motivational streak counter

**UI Elements:**
- Header: Current date (+ Hijri date in Ramadan mode)
- Task cards with:
  - Goal name & category icon
  - Specific task for today
  - Checkbox
  - Time estimate (optional)
  - Notes/tips expandable
- Progress ring/bar per goal
- Overall daily completion percentage
- Current streak display

**Acceptance Criteria:**
- [ ] All today's tasks visible on one screen
- [ ] One-tap task completion
- [ ] Visual feedback on completion (animation/sound)
- [ ] Tasks persist across app sessions
- [ ] Streak counter updates correctly

---

#### F4: Progress Tracking & History
**Description:** View historical progress and overall goal completion

**Requirements:**
- Calendar view showing completed/incomplete days
- Goal-by-goal progress breakdown
- Streak tracking (consecutive days completed)
- Statistics dashboard:
  - Total tasks completed
  - Current streak
  - Best streak
  - Completion percentage per goal
  - Days remaining per goal
- Milestone achievements display

**Acceptance Criteria:**
- [ ] Calendar shows color-coded daily completion
- [ ] Tap on date shows that day's tasks
- [ ] Progress persists across app updates
- [ ] Export progress data option
- [ ] Milestones celebrated when achieved

---

#### F5: Notifications & Reminders
**Description:** Configurable reminders to complete daily tasks

**Requirements:**
- Daily reminder at user-preferred time
- Per-goal custom reminder times (optional)
- Motivational notifications
- Incomplete task reminders (evening)
- Streak-at-risk warnings
- Milestone achievement celebrations

**Acceptance Criteria:**
- [ ] User can set reminder times
- [ ] User can disable notifications
- [ ] Notifications are respectful and not spammy
- [ ] Deep link to specific task from notification

---

### 5.2 Secondary Features (Post-MVP)

#### F6: Goal Templates Library
- Curated templates for popular goals
- Community-submitted templates
- One-tap goal creation from template

#### F7: Sharing & Accountability
- Share progress with friends/family
- Accountability partners
- Export progress as image for social media

#### F8: Gamification
- Badges and achievements
- Milestone celebrations
- Streak rewards
- Level progression

#### F9: Smart Adjustments
- AI suggests adjustments if falling behind
- Reschedule missed tasks
- Difficulty adjustment mid-goal

#### F10: Widget Support
- iOS home screen widget
- Android widget
- Quick task completion from widget

#### F11: Calendar Integration (Only External Integration)
**This is the ONLY external app/service integration we will support.**

- Export tasks to device calendar (iOS Calendar, Google Calendar)
- One-time export or sync option
- Creates calendar events for each daily task
- User controls which goals to export
- No other app integrations (no health apps, no social apps, no third-party services)

**Why Calendar Only?**
- Universal: Everyone has a calendar app
- Simple: No authentication or API complexity
- Useful: Helps users see tasks alongside other commitments
- Privacy-preserving: Uses native OS calendar APIs

#### F12: Additional Special Modes (Future)
- Dhul Hijjah mode (first 10 days)
- Muharram mode
- Lent mode (Christian fasting)
- New Year resolution mode
- Academic semester mode

---

## 6. Technical Requirements

### 6.1 Platform
- **iOS:** iOS 15.0+, iPhone and iPad
- **Android:** Android 8.0 (API 26)+
- **Framework:** **Flutter 3.x** (Dart) - DECIDED

### 6.2 Flutter Tech Stack (MVP)

| Component | Choice | Rationale |
|-----------|--------|-----------|
| **Framework** | Flutter 3.x | Cross-platform, excellent RTL support |
| **Language** | Dart | Type-safe, fast compilation |
| **State Management** | Riverpod | Simple, testable, scalable |
| **Local Database** | Hive | NoSQL, fast, no native dependencies |
| **HTTP Client** | Dio | Interceptors, error handling |
| **Localization** | flutter_localizations + intl | Built-in RTL support |
| **Hijri Calendar** | hijri package | Islamic date conversion |
| **Icons** | flutter_launcher_icons | App icon generation |

### 6.3 Backend & Services
- **Database:** None (all data stored locally via Hive)
- **AI Integration:** Gemini API via Cloudflare Worker proxy
- **Authentication:** None required (no user accounts)
- **Push Notifications:** Local notifications only (flutter_local_notifications)

### 6.4 Data Storage Architecture

**All data is stored locally on the user's device. No external server or cloud database is used.**

| Data Type | Storage Method |
|-----------|----------------|
| User goals | Hive box: `goals` |
| Generated tasks | Hive box: `tasks` |
| Progress/checkboxes | Hive box: `tasks` (completed field) |
| User preferences | Hive box: `preferences` |
| AI responses | Parsed locally, only task data stored |

**Implications:**
- No user accounts or authentication required
- No sync across devices (single-device experience)
- Data lost if app is uninstalled (optional: local backup/export)
- Maximum privacy - user data never leaves their device
- No server costs for data storage

**Optional Features:**
- Export data as JSON/PDF for personal backup
- Import from backup file on new device

### 6.4 Data & Privacy
- All user data stored exclusively on device
- No external database or cloud storage
- No user tracking or analytics that leave the device
- GDPR/privacy compliant by design (no data collection)
- Clear in-app disclosure: "Your data stays on your device"

### 6.5 Performance Requirements
| Metric | Requirement |
|--------|-------------|
| App Launch Time | < 2 seconds |
| AI Task Generation | < 5 seconds |
| Offline Capability | Core features work offline (except AI generation) |
| Battery Usage | Minimal background drain |

---

### 6.6 AI Integration Strategy (Zero-Cost Architecture)

This section defines how TaskTrakr integrates with AI services while keeping the app **completely free** for users with **zero ongoing AI costs** for the developer.

---

#### 6.6.1 RECOMMENDED APPROACH (START HERE)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    🎯 IMPLEMENTATION ROADMAP                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  PHASE 1: MVP (Launch)                          Cost: $0             │
│  ─────────────────────────────────────────────────────────────────   │
│  ✅ Smart Templates (20-30 pre-built goals)     → 80% of users       │
│  ✅ Gemini API Free Tier (1M tokens/month)      → 20% of users       │
│  ✅ Cloudflare Worker proxy (secure API calls)  → Free tier          │
│                                                                       │
│  PHASE 2: Growth (50K-200K users)               Cost: $20-100/mo     │
│  ─────────────────────────────────────────────────────────────────   │
│  ⬜ Expand template library (50+ goals)         → 90% of users       │
│  ⬜ Gemini Paid Tier (if needed)                → 10% of users       │
│  ⬜ Add donation system                         → Cover costs        │
│                                                                       │
│  PHASE 3: Scale (200K-500K users)               Cost: $100-300/mo    │
│  ─────────────────────────────────────────────────────────────────   │
│  ⬜ Evaluate serverless GPU (Modal/Replicate)   → May be cheaper     │
│  ⬜ BYOK support for power users                → Zero cost to us    │
│  ⬜ On-device AI for newer phones               → Reduces API calls  │
│                                                                       │
│  PHASE 4: High Scale (500K+ users)              Cost: $250-500/mo    │
│  ─────────────────────────────────────────────────────────────────   │
│  ⬜ Self-host Llama 3 on GCP (if cost-effective)                     │
│  ⬜ Multiple GPU servers with load balancing                         │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
```

**For MVP, you only need:**
1. **~25 pre-built goal templates** (cover common goals)
2. **Gemini API key** (free from aistudio.google.com)
3. **Cloudflare Worker** (free tier, hides API key)

**Total MVP AI cost: $0**

---

#### 6.6.2 The Challenge

AI API costs can quickly become unsustainable for a free app:
- OpenAI GPT-4: ~$0.03-0.06 per goal generation
- Claude: ~$0.015-0.075 per goal generation
- At 100,000 users generating 2 goals each = $3,000-$15,000/month

**Solution:** A tiered approach that eliminates or minimizes API costs.

---

#### 6.6.3 Architecture: Tiered AI Strategy

```
┌─────────────────────────────────────────────────────────────────┐
│                     AI INTEGRATION TIERS                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  TIER 1: SMART TEMPLATES (No AI Required)                        │
│  ├── Pre-built goal templates with pre-generated task schedules  │
│  ├── Covers 80% of common goals                                  │
│  ├── Instant, offline, zero cost                                 │
│  └── User selects template → App customizes dates                │
│                                                                   │
│  TIER 2: FREE AI APIs (Gemini API Free Tier)                     │
│  ├── Google Gemini API: 15 RPM, 1M tokens/month FREE             │
│  ├── Sufficient for ~30,000 goal generations/month               │
│  ├── High quality output                                         │
│  └── Fallback if templates don't match                           │
│                                                                   │
│  TIER 3: ON-DEVICE AI (Future Enhancement)                       │
│  ├── Apple Intelligence / Gemini Nano                            │
│  ├── Runs locally on device                                      │
│  ├── Works offline, zero API cost                                │
│  └── Limited to newer devices                                    │
│                                                                   │
│  TIER 4: BRING YOUR OWN KEY (Power Users)                        │
│  ├── Users enter their own OpenAI/Claude/Gemini API key          │
│  ├── Unlocks premium models (GPT-4, Claude Opus)                 │
│  ├── Zero cost to developer                                      │
│  └── Optional, for users who want maximum quality                │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 6.6.4 Tier 1: Smart Template System (MVP Priority)

Pre-generate task schedules for common goals. The AI runs once during development, not at runtime.

**How It Works:**

```typescript
interface GoalTemplate {
  id: string;
  category: CategoryType;

  // Matching
  keywords: string[];              // ["quran", "khatam", "juz"]
  match_phrases: string[];         // ["read quran", "finish quran"]

  // Pre-generated content (by AI during development)
  title: LocalizedString;          // { en: "Complete the Quran", ar: "ختم القرآن" }
  description: LocalizedString;

  // Task schedule (parameterized)
  duration_options: number[];      // [30, 60, 90]
  tasks: TemplateTask[];           // Pre-generated for each duration
  milestones: TemplateMilestone[];
  tips: LocalizedString[];
}

interface TemplateTask {
  day_offset: number;              // Day 1, Day 2, etc.
  title: LocalizedString;
  description: LocalizedString;
  duration_minutes: number;
  is_rest_day: boolean;
}

// Template matching at runtime
function findMatchingTemplate(userInput: string): GoalTemplate | null {
  const normalized = userInput.toLowerCase();
  for (const template of templates) {
    if (template.keywords.some(k => normalized.includes(k))) {
      return template;
    }
    if (template.match_phrases.some(p => normalized.includes(p))) {
      return template;
    }
  }
  return null; // No match, escalate to Tier 2
}
```

**Pre-Built Template Categories (MVP):**

| Category | Example Templates |
|----------|-------------------|
| **Ramadan** | Complete Quran (30 days), Daily Prayers + Taraweeh, Charity Goal |
| **Fitness** | Couch to 5K, 100 Pushups Challenge, Daily Stretching, 30-Day Yoga |
| **Learning** | Read 1 Book/Month, Learn 500 Vocab Words, Daily Language Practice |
| **Wellness** | Daily Meditation, 8 Hours Sleep, Drink 8 Glasses Water |
| **Financial** | Save $1000 in 30 Days, No-Spend Challenge, Daily Budget Tracking |
| **Creative** | Write 500 Words Daily, Learn Guitar Basics, 30-Day Drawing Challenge |

**Advantages:**
- Instant response (no API call)
- Works offline
- Zero cost
- Consistent quality
- Pre-localized in all 12 languages

**Template Coverage Goal:** 80% of user goals should match a template.

---

#### 6.6.5 Tier 2: Gemini API Free Tier (Primary AI Backend)

For custom goals that don't match templates, use Google's Gemini API free tier.

**Gemini API Free Tier (as of 2026):**

| Limit | Value |
|-------|-------|
| Requests per minute | 15 RPM |
| Tokens per month | 1,000,000 |
| Cost | **$0** |

**Estimated Capacity:**
- Average goal generation: ~800 tokens (prompt) + ~2000 tokens (response)
- ~333 goal generations per day
- ~10,000 goal generations per month
- With template matching (80%): Supports **50,000 monthly active users**

**Can ChatGPT API be used for free?** No. OpenAI does not offer a free tier. Every API call costs money. Use Gemini for the free tier.

---

##### API Security: Why You Need a Proxy

**The Problem:** Embedding API keys directly in a mobile app is insecure.

```
❌ INSECURE: App contains API key
   ↓
   Attacker decompiles APK/IPA → Extracts key → Abuses your quota
```

**The Solution:** Use a lightweight serverless proxy to hide your API key.

```
✅ SECURE ARCHITECTURE:

┌─────────────┐      ┌─────────────────────┐      ┌─────────────┐
│   Mobile    │ ───→ │   Proxy Function    │ ───→ │  Gemini API │
│     App     │      │ (Cloudflare/Firebase)│      │             │
└─────────────┘      └─────────────────────┘      └─────────────┘
                              │
                              ├── Hides API key
                              ├── Rate limits by device
                              ├── Blocks abuse
                              └── Logs usage (optional)
```

**Free Proxy Options:**

| Service | Free Tier | Setup Complexity |
|---------|-----------|------------------|
| **Cloudflare Workers** | 100K requests/day | Low |
| **Firebase Functions** | 2M invocations/month | Low |
| **Vercel Edge Functions** | 100K executions/month | Low |
| **Supabase Edge Functions** | 500K invocations/month | Low |

**Recommended: Cloudflare Workers** (simplest, most generous free tier)

**Example Cloudflare Worker Proxy:**

```javascript
// Cloudflare Worker - Secure AI Proxy
// Deploy at: https://tasktrakr-ai.your-domain.workers.dev

export default {
  async fetch(request, env) {
    // Only allow POST requests
    if (request.method !== "POST") {
      return new Response("Method not allowed", { status: 405 });
    }

    // Get device ID for rate limiting
    const deviceId = request.headers.get("X-Device-Id");
    if (!deviceId) {
      return new Response("Missing device ID", { status: 400 });
    }

    // Rate limit: 5 requests per device per day
    const rateLimitKey = `rate:${deviceId}:${new Date().toDateString()}`;
    const currentCount = await env.KV.get(rateLimitKey) || 0;

    if (parseInt(currentCount) >= 5) {
      return new Response(JSON.stringify({
        error: true,
        message: "Daily limit reached. Try using a template or wait until tomorrow."
      }), {
        status: 429,
        headers: { "Content-Type": "application/json" }
      });
    }

    // Increment rate limit counter
    await env.KV.put(rateLimitKey, String(parseInt(currentCount) + 1), {
      expirationTtl: 86400  // Expires in 24 hours
    });

    // Forward request to Gemini API (key is hidden in env)
    const geminiResponse = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${env.GEMINI_API_KEY}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: request.body
      }
    );

    return geminiResponse;
  }
};
```

**App calls the proxy, not Gemini directly:**

```typescript
// In your React Native / Flutter app
const PROXY_URL = "https://tasktrakr-ai.your-domain.workers.dev";

async function callAI(prompt: string, deviceId: string): Promise<AIResponse> {
  const response = await fetch(PROXY_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-Device-Id": deviceId  // For rate limiting
    },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }]
    })
  });

  if (response.status === 429) {
    throw new Error("RATE_LIMITED");
  }

  return response.json();
}
```

---

##### Direct API Calls (Without Proxy)

If you want to skip the proxy for MVP simplicity, you can call Gemini directly from the app. This is **less secure** but acceptable for early testing.

**Risk Mitigation for Direct Calls:**
- Use API key restrictions in Google Cloud Console (restrict to your app's bundle ID)
- Monitor usage closely
- Set billing alerts
- Be prepared to rotate keys if abuse is detected

**Implementation (Direct Call):**

```typescript
interface AIProvider {
  name: "gemini" | "openai" | "claude" | "groq";
  endpoint: string;
  model: string;
  apiKey: string;
  isUserProvided: boolean;
}

// Default to Gemini free tier
const defaultProvider: AIProvider = {
  name: "gemini",
  endpoint: "https://generativelanguage.googleapis.com/v1beta/models",
  model: "gemini-1.5-flash",  // Fast, capable, free tier eligible
  apiKey: process.env.GEMINI_API_KEY,  // Developer's key (use proxy in production!)
  isUserProvided: false
};

async function generatePlan(
  context: GoalContext,
  provider: AIProvider = defaultProvider
): Promise<TaskTrakrPlanResponse> {

  // Try template first (no API call)
  const template = findMatchingTemplate(context.raw_input);
  if (template) {
    return templateToResponse(template, context);
  }

  // Fall back to AI
  return callAIProvider(context, provider);
}
```

---

##### MVP vs Production Recommendation

| Phase | Approach | Security | Cost |
|-------|----------|----------|------|
| **MVP/Testing** | Direct Gemini API calls with key restrictions | Moderate | $0 |
| **Production** | Cloudflare Worker proxy | High | $0 (free tier) |

**Bottom Line:**
- ✅ **Gemini API free tier** - Yes, use it. 1M tokens/month free.
- ❌ **ChatGPT/OpenAI API free** - No, it doesn't exist. Always costs money.
- ⚠️ **Direct API calls from app** - Works but risky. Use proxy for production.
- ✅ **Cloudflare Workers proxy** - Free, secure, recommended for production.

**Rate Limiting Strategy:**

```typescript
interface RateLimiter {
  // Per-device limits (stored locally)
  daily_generations: number;      // Max 5 per device per day
  monthly_generations: number;    // Max 20 per device per month

  // Global limits (if using shared key)
  requests_this_minute: number;
  cooldown_until?: Date;
}

// Soft limits encourage template usage
function checkRateLimit(limiter: RateLimiter): RateLimitResult {
  if (limiter.daily_generations >= 5) {
    return {
      allowed: false,
      message: "You've created 5 goals today. Try again tomorrow, or choose from our templates.",
      show_templates: true
    };
  }
  return { allowed: true };
}
```

---

#### 6.6.6 Tier 3: On-Device AI (Post-MVP)

Future enhancement for offline AI generation on capable devices.

**Options:**

| Platform | Technology | Availability |
|----------|------------|--------------|
| iOS 18+ | Apple Intelligence APIs | Limited, Apple controls |
| Android 14+ | Gemini Nano (on-device) | Pixel 8+, expanding |
| Cross-platform | ONNX Runtime + Small LLM | Works on most devices |

**On-Device Model Requirements:**
- Model size: < 500MB (acceptable) or < 2GB (with download prompt)
- Inference time: < 10 seconds per generation
- Quality: Acceptable for simple goals, may need cloud fallback for complex ones

**Implementation Approach (Post-MVP):**

```typescript
interface OnDeviceAI {
  isAvailable(): Promise<boolean>;
  generate(prompt: string): Promise<string>;
  getCapabilities(): AICapabilities;
}

// Check device capability
async function selectAITier(context: GoalContext): Promise<AITier> {
  // 1. Try template
  if (findMatchingTemplate(context.raw_input)) {
    return "template";
  }

  // 2. Try on-device (if available and suitable)
  const onDevice = await OnDeviceAI.isAvailable();
  if (onDevice && isSimpleGoal(context)) {
    return "on_device";
  }

  // 3. Use cloud API
  return "cloud_api";
}
```

---

#### 6.6.7 Tier 4: Bring Your Own Key (BYOK)

Power users can connect their own API keys for unlimited, premium AI access.

**Supported Providers:**

| Provider | Models | API Key Source |
|----------|--------|----------------|
| OpenAI | GPT-4, GPT-4o | platform.openai.com |
| Anthropic | Claude 3.5 Sonnet, Opus | console.anthropic.com |
| Google | Gemini 1.5 Pro | aistudio.google.com |
| Groq | Llama 3, Mixtral | console.groq.com |

**User Flow:**

```
Settings → AI Provider → "Use your own API key"
                              ↓
         ┌────────────────────┴────────────────────┐
         │                                          │
         │   Select Provider: [OpenAI ▼]            │
         │                                          │
         │   API Key: [sk-...] (securely stored)   │
         │                                          │
         │   [Test Connection]  [Save]              │
         │                                          │
         │   ℹ️ Your key is stored only on your     │
         │      device and never sent to our        │
         │      servers.                            │
         │                                          │
         └─────────────────────────────────────────┘
```

**Security Requirements:**
- API keys stored in secure device storage (Keychain/Keystore)
- Keys never leave the device
- Keys never sent to any server except the AI provider
- Clear disclosure to users about key usage

**Implementation:**

```typescript
interface UserAPIConfig {
  provider: "openai" | "anthropic" | "google" | "groq";
  api_key: string;  // Stored in secure storage
  model_preference?: string;
  enabled: boolean;
}

// Secure storage
async function saveUserAPIKey(config: UserAPIConfig): Promise<void> {
  // iOS: Keychain
  // Android: EncryptedSharedPreferences or Keystore
  await SecureStorage.set("user_api_config", encrypt(config));
}

// Use user's key if configured
async function getAIProvider(): Promise<AIProvider> {
  const userConfig = await SecureStorage.get("user_api_config");
  if (userConfig?.enabled && userConfig?.api_key) {
    return {
      name: userConfig.provider,
      apiKey: userConfig.api_key,
      isUserProvided: true,
      // ... provider-specific config
    };
  }
  return defaultProvider;  // Fall back to Gemini free tier
}
```

---

#### 6.6.8 Cost Analysis

**Scenario: 100,000 Monthly Active Users**

| Component | Without Strategy | With Tiered Strategy |
|-----------|------------------|----------------------|
| Goals created/month | 200,000 | 200,000 |
| Template matches (80%) | - | 160,000 (FREE) |
| BYOK users (5%) | - | 10,000 (FREE to us) |
| Cloud API calls needed | 200,000 | 30,000 |
| Gemini free tier covers | - | 10,000 |
| Overflow needing paid API | 200,000 | 20,000 |
| **Estimated monthly cost** | **$6,000-$12,000** | **$60-$120** |

**Key Insight:** With good templates and the Gemini free tier, you can serve 100,000 users for under $200/month, compared to $10,000+ without this strategy.

---

#### 6.6.9 Decision Tree for AI Calls

```
User enters goal
       ↓
┌──────┴──────┐
│ Check BYOK  │
└──────┬──────┘
       ↓
  User has key? ──YES──→ Use user's provider (Tier 4)
       │
      NO
       ↓
┌──────┴──────┐
│ Match       │
│ Template?   │
└──────┬──────┘
       ↓
     YES ──→ Use template (Tier 1) ──→ Instant response
       │
      NO
       ↓
┌──────┴──────┐
│ On-device   │
│ AI avail?   │ (Post-MVP)
└──────┬──────┘
       ↓
     YES ──→ Use on-device AI (Tier 3)
       │
      NO
       ↓
┌──────┴──────┐
│ Rate limit  │
│ OK?         │
└──────┬──────┘
       ↓
     YES ──→ Use Gemini API (Tier 2)
       │
      NO
       ↓
Show message: "Try a template goal or wait until tomorrow"
```

---

#### 6.6.10 Implementation Priority

**MVP (Must Have):**
1. ✅ Smart Template System (Tier 1) - Cover 20+ common goals
2. ✅ Gemini API Integration (Tier 2) - Free tier with rate limiting
3. ✅ Graceful fallbacks and clear messaging

**Post-MVP (Nice to Have):**
4. ⬜ BYOK Support (Tier 4) - OpenAI, Claude, Groq
5. ⬜ On-Device AI (Tier 3) - Apple Intelligence, Gemini Nano
6. ⬜ Additional template library expansion
7. ⬜ Community-contributed templates

---

#### 6.6.11 Alternative Free/Cheap AI Providers

If Gemini free tier becomes unavailable or insufficient:

| Provider | Free Tier | Paid Rate | Notes |
|----------|-----------|-----------|-------|
| **Groq** | Yes (limited) | Very cheap | Extremely fast inference |
| **Mistral** | Yes (small models) | Cheap | Good quality, EU-based |
| **Together.ai** | $5 credit | Pay-as-you-go | Many model options |
| **OpenRouter** | No | Aggregator | Route to cheapest model |
| **Cloudflare Workers AI** | 10K neurons/day free | Cheap | Edge-based |

**Fallback Chain:**
```
Gemini Free → Groq Free → Mistral Free → Show Templates Only
```

---

#### 6.6.12 Self-Hosted Open Source LLMs (Post-MVP, High Scale)

At very high scale (500K+ users), self-hosting open source models may become cost-effective.

##### When Does Self-Hosting Make Sense?

```
Cost Comparison at Different Scales:

┌────────────────────────────────────────────────────────────────────┐
│  USERS    │ AI CALLS/MO │ GEMINI API  │ SERVERLESS GPU │ DEDICATED │
├───────────┼─────────────┼─────────────┼────────────────┼───────────┤
│  10K      │  2K         │  $2         │  $6            │  $250     │
│  50K      │  10K        │  $10        │  $30           │  $250     │
│  100K     │  20K        │  $20        │  $60           │  $250     │
│  500K     │  100K       │  $100       │  $300          │  $250  ✓  │
│  1M       │  200K       │  $200       │  $600          │  $250  ✓  │
│  5M       │  1M         │  $1,000     │  $3,000        │  $500  ✓  │
└────────────────────────────────────────────────────────────────────┘

Break-even: ~250K AI generations/month (dedicated server wins)
With 90% template coverage: ~2.5M total users
```

**Verdict:** Self-hosting only makes sense at **500K+ monthly active users** with dedicated servers.

---

##### Option A: Dedicated GPU Server (GCP/AWS/Azure)

**GCP GPU Pricing:**

| GPU | VRAM | Hourly | Monthly (24/7) | Best Model |
|-----|------|--------|----------------|------------|
| T4 | 16GB | $0.35 | ~$250 | Llama 3 8B, Mistral 7B |
| L4 | 24GB | $0.70 | ~$500 | Llama 3 8B (faster) |
| A100 40GB | 40GB | $3.00 | ~$2,160 | Llama 3 70B |

**Recommended Setup (High Scale):**

```
┌─────────────────────────────────────────────────────────────────┐
│                    SELF-HOSTED ARCHITECTURE                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────┐    ┌─────────────────┐    ┌──────────────────┐     │
│  │  Mobile │───→│  Load Balancer  │───→│  GPU Server(s)   │     │
│  │   App   │    │  (Cloud Run)    │    │  (GCE with T4)   │     │
│  └─────────┘    └─────────────────┘    └──────────────────┘     │
│                          │                       │               │
│                          │              ┌────────┴────────┐      │
│                          │              │  vLLM / TGI     │      │
│                          │              │  Llama 3 8B     │      │
│                          │              └─────────────────┘      │
│                          │                                       │
│                    Rate Limiting                                 │
│                    Request Queue                                 │
│                    Health Checks                                 │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

**Open Source Models for Goal Generation:**

| Model | Size | Quality | Speed | Recommended? |
|-------|------|---------|-------|--------------|
| **Llama 3.1 8B** | 16GB | Good | Fast | ✅ Best balance |
| **Mistral 7B** | 14GB | Good | Fast | ✅ Good alternative |
| **Llama 3.1 70B** | 140GB | Excellent | Slow | ❌ Overkill |
| **Mixtral 8x7B** | 90GB | Very Good | Medium | ⚠️ Needs A100 |
| **Phi-3 Mini** | 4GB | Decent | Very Fast | ⚠️ May lack quality |

**Recommended: Llama 3.1 8B Instruct** - Best quality-to-cost ratio for structured task generation.

---

##### Option B: Serverless GPU (Pay-Per-Second)

For bursty workloads, serverless GPU platforms charge only when processing:

| Platform | GPU | Price/sec | Cold Start | Setup |
|----------|-----|-----------|------------|-------|
| **Modal** | T4/A10G | $0.0003-0.001 | 10-30s | Easy |
| **Replicate** | Various | $0.0005 | 5-15s | Very Easy |
| **RunPod Serverless** | T4/A100 | $0.0002-0.002 | 30-60s | Medium |
| **Banana.dev** | Various | $0.0004 | 10-20s | Easy |
| **Beam** | T4/A10G | $0.0003 | 15-30s | Easy |

**Cost Calculation (Serverless):**

```
Average generation time: ~3 seconds
Cost per generation: 3s × $0.0003 = $0.0009

At 100K users (20K generations/month):
20,000 × $0.0009 = $18/month  ← Very cheap!

At 1M users (200K generations/month):
200,000 × $0.0009 = $180/month  ← Still cheaper than Gemini API
```

**Serverless Pros:**
- No server management
- Pay only for actual usage
- Auto-scales with demand
- No idle costs

**Serverless Cons:**
- Cold starts (10-60 seconds for first request)
- Less control over model/config
- Vendor lock-in

---

##### Option C: Cloudflare Workers AI (Edge-Based)

Cloudflare offers AI inference at the edge with a free tier:

**Pricing:**
- Free: 10,000 neurons/day (~100-500 generations)
- Paid: $0.011 per 1,000 neurons

**Supported Models:**
- Llama 2 7B, 13B
- Mistral 7B
- Code Llama

**Pros:**
- Runs at edge (low latency)
- Integrated with Cloudflare Workers
- Simple setup

**Cons:**
- Limited model selection
- Smaller models only
- May not match Gemini quality

---

##### Implementation: vLLM Server on GCP

For dedicated hosting, use vLLM for high-throughput inference:

```python
# deploy.py - vLLM server on GCP

# 1. Create GCE instance with T4 GPU
# gcloud compute instances create tasktrakr-llm \
#   --machine-type=n1-standard-4 \
#   --accelerator=type=nvidia-tesla-t4,count=1 \
#   --image-family=pytorch-latest-gpu \
#   --boot-disk-size=100GB

# 2. Install vLLM
# pip install vllm

# 3. Run server
from vllm import LLM, SamplingParams

# Load model (downloads on first run)
llm = LLM(model="meta-llama/Meta-Llama-3.1-8B-Instruct")

# Serve via FastAPI
from fastapi import FastAPI
app = FastAPI()

@app.post("/generate")
async def generate(prompt: str, max_tokens: int = 2000):
    sampling_params = SamplingParams(
        temperature=0.7,
        max_tokens=max_tokens,
    )
    outputs = llm.generate([prompt], sampling_params)
    return {"text": outputs[0].outputs[0].text}
```

**Throughput:** vLLM on T4 can handle ~10-20 requests/second for Llama 3 8B.

---

##### Cost Summary: All Options

| Scale | Best Option | Monthly Cost |
|-------|-------------|--------------|
| **0-50K users** | Gemini Free Tier | $0 |
| **50K-200K users** | Gemini Paid or Serverless GPU | $20-100 |
| **200K-500K users** | Serverless GPU (Modal/Replicate) | $100-300 |
| **500K-1M users** | Dedicated T4 Server | $250-300 |
| **1M+ users** | Multiple T4 Servers + Load Balancer | $500-1000 |

---

##### Recommendation by Phase

| Phase | Strategy | Why |
|-------|----------|-----|
| **MVP** | Gemini Free Tier | Zero cost, fast setup |
| **Growth (50K-200K)** | Gemini Paid | Simple, reliable |
| **Scale (200K-500K)** | Evaluate serverless GPU | May be cheaper |
| **High Scale (500K+)** | Self-host Llama 3 on GCP T4 | Fixed cost, full control |

**Key Insight:** Don't over-engineer early. Start with Gemini free tier. Only consider self-hosting when you've validated product-market fit AND have 500K+ users. The complexity of managing GPU servers isn't worth it at small scale.

---

## 7. Safety & Security Guardrails

This section defines content moderation policies, input/output filtering, and safety mechanisms to ensure TaskTrakr remains a positive, inclusive, and safe environment for all users.

### 7.1 Content Policy Overview

TaskTrakr is a goal and habit tracking app designed to help users achieve **positive personal growth**. The app will actively filter and reject content that promotes harm, hate, or illegal activities.

#### Prohibited Content Categories

| Category | Description | Examples |
|----------|-------------|----------|
| **Hate Speech** | Content promoting hatred against individuals or groups based on protected characteristics | Racial slurs, ethnic discrimination, gender-based hate |
| **Religious Intolerance** | Content attacking, mocking, or promoting violence against any religion or religious group | Anti-Muslim, anti-Christian, anti-Semitic, anti-Hindu content |
| **Violence & Harm** | Content promoting violence, terrorism, or physical harm to self or others | Assault plans, terrorism, murder, torture |
| **Self-Harm & Suicide** | Content promoting, glorifying, or providing instructions for self-harm or suicide | Suicide methods, self-injury, eating disorder promotion |
| **Sexual Content** | Pornographic, sexually explicit, or sexually exploitative content | Pornography, sexual services, exploitation |
| **Child Safety** | Any content that sexualizes, exploits, or endangers minors | CSAM, grooming, child exploitation |
| **Illegal Activities** | Content promoting illegal activities or providing instructions for crimes | Drug manufacturing, weapons trafficking, fraud |
| **Harassment & Bullying** | Content designed to harass, stalk, or bully specific individuals | Doxxing, targeted harassment, cyberbullying |
| **Dangerous Activities** | Content promoting dangerous challenges or reckless behavior | Dangerous challenges, reckless stunts |
| **Misinformation** | Health misinformation that could cause harm | Anti-vaccine content, dangerous medical advice |

---

### 7.2 Input Filtering (Pre-AI)

Before sending user input to the AI, the app applies client-side filtering:

#### Keyword Detection

```typescript
interface ContentFilter {
  // Categories of blocked terms
  blocked_patterns: {
    hate_speech: RegExp[];
    violence: RegExp[];
    self_harm: RegExp[];
    sexual: RegExp[];
    illegal: RegExp[];
  };

  // Sensitivity levels
  sensitivity: "strict" | "moderate";

  // Languages to check (user's selected language + common)
  check_languages: LanguageCode[];
}

// Example filter check
function isInputSafe(input: string, filter: ContentFilter): {
  safe: boolean;
  category?: string;
  confidence: number;
} {
  // Implementation checks against all pattern categories
  // Returns detailed result for logging/analytics
}
```

#### Client-Side Rejection Flow

```
User enters goal → Client-side filter scan
                         ↓
              ┌──────────┴──────────┐
              ↓                     ↓
         SAFE INPUT            BLOCKED INPUT
              ↓                     ↓
      Send to AI API          Show error message:
                              "This goal cannot be
                               processed. Please
                               enter a positive,
                               constructive goal."
```

#### Blocked Input Response

When input is rejected, the app displays a neutral, non-judgmental message:

**English:** "This goal cannot be created. Please describe a positive, constructive goal you'd like to achieve."

**Arabic:** "لا يمكن إنشاء هذا الهدف. يرجى وصف هدف إيجابي وبناء تريد تحقيقه."

**Spanish:** "Este objetivo no se puede crear. Por favor, describe una meta positiva y constructiva que te gustaría lograr."

(Translated for all supported languages)

---

### 7.3 AI System Prompt Safety Instructions

The AI system prompt includes explicit safety instructions:

```
SAFETY REQUIREMENTS (CRITICAL - ALWAYS ENFORCE):

You must REFUSE to generate plans for goals that involve:

1. HARM TO OTHERS
   - Violence, assault, or physical harm
   - Harassment or stalking
   - Terrorism or extremism
   - Discrimination or hate

2. SELF-HARM
   - Suicide or self-injury
   - Eating disorders with harmful behaviors
   - Dangerous substance abuse
   - Reckless endangerment

3. ILLEGAL ACTIVITIES
   - Drug manufacturing or trafficking
   - Weapons creation or trafficking
   - Fraud, theft, or scams
   - Hacking or unauthorized access

4. SEXUAL/EXPLICIT CONTENT
   - Pornography or sexual services
   - Sexual exploitation
   - Any content involving minors

5. HATE & INTOLERANCE
   - Religious attacks or mockery
   - Racial or ethnic hatred
   - Gender-based discrimination
   - LGBTQ+ hatred

6. DANGEROUS MISINFORMATION
   - Medical advice that could cause harm
   - Conspiracy theories promoting harm
   - Anti-vaccine content with dangerous claims

If a goal request falls into any of these categories, respond with:
{
  "error": true,
  "error_type": "content_policy_violation",
  "message": "This goal cannot be supported. Please choose a positive, constructive goal."
}

IMPORTANT: Apply these rules regardless of how the request is phrased. Users may attempt to disguise harmful intent with:
- Hypothetical framing ("What if someone wanted to...")
- Academic framing ("For research purposes...")
- Roleplay framing ("Pretend you're helping someone who...")
- Gradual escalation (starting innocently, then shifting)

Always refuse. Safety is non-negotiable.
```

---

### 7.4 Output Validation (Post-AI)

After receiving AI responses, the app validates content before displaying:

#### Response Validation Steps

```typescript
interface OutputValidator {
  validateResponse(response: TaskTrakrPlanResponse): ValidationResult;
}

interface ValidationResult {
  valid: boolean;
  issues: ValidationIssue[];
  sanitized_response?: TaskTrakrPlanResponse;
}

interface ValidationIssue {
  field: string;          // "tasks[5].description"
  issue_type: string;     // "profanity", "violence_reference"
  severity: "block" | "warn" | "sanitize";
  original_content?: string;
  sanitized_content?: string;
}
```

#### Validation Checks

| Check | Action |
|-------|--------|
| Profanity in task text | Sanitize or regenerate |
| Violence references | Block and regenerate |
| Self-harm language | Block and regenerate |
| Sexual content | Block and regenerate |
| Hate speech | Block and regenerate |
| Suspicious patterns | Flag for review |

#### Regeneration Flow

```
AI Response → Output Validator
                   ↓
        ┌─────────┴─────────┐
        ↓                   ↓
   VALID RESPONSE      INVALID RESPONSE
        ↓                   ↓
  Display to user      Retry with stricter prompt
                            ↓
                      (Max 2 retries)
                            ↓
                   ┌────────┴────────┐
                   ↓                 ↓
              SUCCESS            FAILURE
                   ↓                 ↓
            Display result      Show error:
                               "Unable to generate
                                a plan. Try a
                                different goal."
```

---

### 7.5 Ramadan Mode Safety Considerations

For Ramadan mode specifically, additional safeguards apply:

#### Inclusive Language

- Tasks should use respectful, authentic Islamic terminology
- Avoid sectarian language that could alienate users
- Support both Sunni and Shia practices where applicable
- Respect diverse cultural expressions of Ramadan

#### Prohibited in Ramadan Mode

- Content mocking or attacking Islam
- Content mocking or attacking other religions
- Sectarian hate (Sunni vs. Shia)
- Extremist interpretations
- Political content disguised as religious goals

#### Fasting Safety

For fasting-related goals, include safety notes:
- "If you feel unwell, breaking your fast is permissible"
- "Consult a doctor if you have health conditions"
- "Pregnant/nursing women should consult medical advice"

---

### 7.6 Multi-Language Safety

Safety filtering must work across all 12 supported languages:

#### Language-Specific Considerations

| Language | Special Considerations |
|----------|----------------------|
| Arabic | Right-to-left text, religious terminology nuances |
| Urdu | Similar script to Arabic, distinct cultural context |
| Hindi | Shared vocabulary with Urdu, different script |
| Indonesian/Malay | Largest Muslim populations, cultural sensitivity |
| Turkish | Secular/religious balance in terminology |
| Bengali | Regional cultural expressions |

#### Cross-Language Attacks

Be aware of users attempting to bypass filters by:
- Mixing languages in a single input
- Using transliteration to obscure blocked terms
- Code-switching between scripts
- Using emojis or special characters to bypass filters

Mitigation: Normalize and check all inputs across multiple language models.

---

### 7.7 Error Handling & User Communication

When content is blocked, communication should be:

#### Principles

1. **Non-judgmental:** Don't accuse the user of wrongdoing
2. **Helpful:** Guide toward acceptable alternatives
3. **Private:** Don't log or transmit the specific blocked content
4. **Consistent:** Same messaging across all languages

#### Error Message Templates

**Generic Block:**
> "This goal cannot be created. Try describing what positive outcome you'd like to achieve."

**Suggestive Redirect:**
> "We couldn't process that request. Here are some goal ideas:
> • Build a healthy habit
> • Learn a new skill
> • Improve your wellness"

**Persistent Attempts:**
> "We're unable to help with this type of goal. TaskTrakr is designed for positive personal growth."

---

### 7.8 Logging & Monitoring (Privacy-Preserving)

While the app stores data locally, we implement privacy-preserving analytics:

#### What We Track (Aggregated, Anonymous)

- Count of content policy violations (by category)
- Language of blocked attempts
- Success rate of AI regeneration
- No PII, no specific content stored

#### What We Never Track

- The actual text of blocked content
- User identifiers linked to violations
- Device identifiers linked to violations
- Location data

---

### 7.9 Edge Cases & Nuanced Goals

Some goals require nuanced handling:

#### Weight Loss Goals

**Acceptable:** "I want to lose 10 pounds in a healthy way"
**Concerning:** "I want to stop eating completely"

For weight-related goals, AI should:
- Promote healthy, sustainable approaches
- Include rest days and balanced nutrition
- Add safety notes about consulting healthcare providers
- Avoid extreme restriction or dangerous methods

#### Mental Health Goals

**Acceptable:** "I want to practice daily meditation for stress relief"
**Concerning:** "I want to stop feeling anything"

For mental health goals:
- Promote positive coping mechanisms
- Suggest professional resources when appropriate
- Avoid reinforcing harmful thought patterns
- Include encouraging, supportive language

#### Religious Goals (Non-Ramadan)

Users may enter goals from any faith tradition:
- **Acceptable:** Prayer routines, scripture reading, charitable giving
- **Block:** Anything promoting religious intolerance
- **Approach:** Treat all religions with equal respect

---

### 7.10 Compliance & Legal

#### Age Restrictions

- App is rated for ages 4+ (general audience)
- No age verification required (content is appropriate for all ages)
- All generated content must be appropriate for minors

#### Regional Compliance

| Region | Consideration |
|--------|--------------|
| EU (GDPR) | No personal data collected, compliant by design |
| US (COPPA) | No child data collected, compliant by design |
| Middle East | Respect local sensitivities, no blasphemous content |
| Global | Avoid politically sensitive content |

#### App Store Guidelines

- Comply with Apple App Store Review Guidelines
- Comply with Google Play Developer Policy
- No objectionable content
- No hate speech
- User-generated content (goals) is filtered and moderated

---

### 7.11 Implementation Checklist

#### MVP Safety Requirements

- [ ] Client-side keyword filter (basic blocked terms)
- [ ] AI system prompt with safety instructions
- [ ] Output validation for profanity/explicit content
- [ ] Generic error messaging in all languages
- [ ] Basic retry logic for failed generations

#### Post-MVP Enhancements

- [ ] Advanced ML-based content classification
- [ ] Multi-language filter expansion
- [ ] Behavioral pattern detection (gradual escalation)
- [ ] Anonymous abuse analytics dashboard
- [ ] Regular filter updates based on new patterns

---

## 8. User Flows

### 8.1 First-Time User Flow
```
1. Download & Open App
2. Language Selection Screen
   - Display: "Choose your language" (shown in all supported languages)
   - Grid of language options with native names:
     * English
     * Español
     * العربية (Arabic)
     * Français
     * Deutsch
     * Português
     * Bahasa Indonesia
     * Türkçe
     * اردو (Urdu)
     * हिन्दी (Hindi)
     * বাংলা (Bengali)
     * Bahasa Melayu
   - Selection saves to local preferences
   - All subsequent screens in selected language
3. Welcome Screen → "What do you want to achieve?" (in selected language)
4. Goal Setting Screen
   - Type custom goal in any language (AI understands it)
   - Browse templates (shown in selected language)
   - Select duration (30 days default)
   - Optionally select category
   - Add additional goals (optional)
5. AI Processing Screen (loading animation)
6. Review Generated Tasks (displayed in selected language)
   - See overview of the plan
   - Accept OR Regenerate
7. Dashboard (Today's Tasks)
8. Optional: Set notification preferences
```

**Language Selection Screen Mockup:**
```
┌─────────────────────────────────┐
│                                 │
│         🌍                      │
│                                 │
│   Choose your language          │
│   اختر لغتك · Elige tu idioma   │
│                                 │
│  ┌─────────┐  ┌─────────┐      │
│  │ English │  │ Español │      │
│  └─────────┘  └─────────┘      │
│  ┌─────────┐  ┌─────────┐      │
│  │ العربية │  │ Français│      │
│  └─────────┘  └─────────┘      │
│  ┌─────────┐  ┌─────────┐      │
│  │ Deutsch │  │Português│      │
│  └─────────┘  └─────────┘      │
│  ┌─────────┐  ┌─────────┐      │
│  │Indonesia│  │ Türkçe  │      │
│  └─────────┘  └─────────┘      │
│  ┌─────────┐  ┌─────────┐      │
│  │  اردو   │  │ हिन्दी   │      │
│  └─────────┘  └─────────┘      │
│  ┌─────────┐  ┌─────────┐      │
│  │  বাংলা  │  │ Melayu  │      │
│  └─────────┘  └─────────┘      │
│                                 │
└─────────────────────────────────┘
```

### 7.2 Daily User Flow
```
1. Open App (or tap notification)
2. View Today's Dashboard
3. Complete tasks → Check boxes
4. View progress update
5. Celebrate streak / milestone if applicable
6. (Optional) View calendar/stats
7. Close app
```

### 7.3 Goal Management Flow
```
1. Navigate to Goals tab
2. View all active goals
3. Tap goal to see details/schedule
4. Edit/Delete/Add new goal
5. Return to dashboard
```

### 7.4 Ramadan Mode Flow
```
1. Select "Ramadan / Islamic" category OR mention Ramadan in goal
2. App activates Ramadan mode
3. Hijri date displayed
4. AI generates Ramadan-aware schedule
5. Special emphasis on last 10 nights
6. Laylatul Qadr reminders activated
```

---

## 9. Design Guidelines

### 8.1 Visual Design Principles
- **Clean & Minimal:** Focus on tasks, reduce clutter
- **Adaptable Themes:** Colors adapt to goal category
- **Encouraging:** Celebrate progress, not just completion
- **Dark Mode:** Full dark mode support

### 8.2 Color Palette (Default)
| Color | Hex | Usage |
|-------|-----|-------|
| Primary Blue | #2196F3 | Primary actions |
| Success Green | #4CAF50 | Completion, streaks |
| Warm Orange | #FF9800 | Warnings, streaks at risk |
| Soft Gray | #9E9E9E | Secondary text |
| Background Light | #FAFAFA | Light mode background |
| Background Dark | #121212 | Dark mode background |

### 8.3 Category-Specific Theming
| Category | Accent Color | Icon |
|----------|--------------|------|
| Fitness | #E91E63 (Pink) | 🏃 |
| Learning | #9C27B0 (Purple) | 📚 |
| Creative | #FF5722 (Deep Orange) | 🎨 |
| Wellness | #00BCD4 (Cyan) | 🧘 |
| Financial | #8BC34A (Light Green) | 💰 |
| Ramadan | #1B5E20 (Islamic Green) | 🌙 |

### 8.4 Typography
- **Headers:** Clean, modern sans-serif (Inter, SF Pro)
- **Body:** Readable sans-serif
- **Arabic Text:** Noto Sans Arabic (for Ramadan mode)

---

## 10. Gamification Strategy

### 9.1 Core Philosophy
Gamification should **motivate without overwhelming**. The goal is to make progress feel rewarding, not to turn the app into a game that distracts from actual goal achievement.

**Principles:**
- Celebrate progress, not perfection
- Intrinsic motivation over extrinsic rewards
- Simple, meaningful feedback loops
- No punishment for missed days (encouragement instead)

### 9.2 Gamification Elements

#### Streaks (Goal-Specific)
**Streaks are tracked per goal, not globally.** Each goal has its own independent streak counter. This keeps motivation tied to specific commitments and prevents one missed task from breaking everything.

| Element | Description |
|---------|-------------|
| Goal Streak | Consecutive days the task for THIS goal was completed |
| Display | Flame icon on each goal card (🔥 7) |
| Independence | Missing "Run 5K" task doesn't break "Read Books" streak |
| Streak Freeze | 1 grace day per goal per week (configurable) |
| Recovery | "Welcome back to [Goal Name]! Let's rebuild" |

**Example:**
```
🏃 Run a 5K        🔥 12 days
📚 Read 4 books    🔥 7 days
💰 Save $1000      🔥 3 days   ← Each goal has its own streak
```

**Why Goal-Specific Streaks?**
- One bad day doesn't destroy all progress
- Users stay motivated on goals they're succeeding at
- Reduces all-or-nothing thinking
- More forgiving, less anxiety

**Streak Milestones (per goal):**
- 3 days: "Building momentum on [Goal]!"
- 7 days: "One week strong! 🔥"
- 14 days: "Two weeks - habit forming!"
- 21 days: "21 days - they say this makes a habit!"
- 30 days: "One month of [Goal]! Unstoppable!"

#### Progress Visualization
| Element | Description |
|---------|-------------|
| Progress Ring | Circular progress indicator per goal (0-100%) |
| Daily Completion Bar | Simple bar showing today's tasks done |
| Calendar Heatmap | Month view with color intensity = completion % |
| Milestone Markers | Visual checkpoints on the journey |

**Example Progress Ring States:**
```
○ 0% - Empty ring (just started)
◔ 25% - Quarter filled
◑ 50% - Half filled
◕ 75% - Almost there
● 100% - Complete (with celebration animation)
```

#### Achievements & Badges
Keep badges **minimal and meaningful** - not collectibles for the sake of collecting.

| Badge | Criteria | Icon |
|-------|----------|------|
| First Step | Complete your first task | 👣 |
| Week Warrior | 7-day streak | 🔥 |
| Halfway There | Reach 50% of any goal | ⛰️ |
| Goal Crusher | Complete any goal 100% | 🏆 |
| Multi-Tasker | Active in 3+ goals simultaneously | 🎯 |
| Comeback Kid | Return after 3+ days away | 💪 |
| Early Bird | Complete tasks before 9am (7 times) | 🌅 |
| Night Owl | Complete tasks after 9pm (7 times) | 🌙 |
| Ramadan Champion | Complete a Ramadan goal | ☪️ |

**Badge Display:**
- Show earned badges on profile (max 6 displayed)
- Subtle unlock animation (not intrusive)
- No "locked badge" gallery (reduces anxiety)

#### Celebrations & Feedback
| Moment | Feedback |
|--------|----------|
| Task Completed | Satisfying checkmark animation + subtle haptic |
| All Daily Tasks Done | Confetti burst + "Day complete!" |
| Streak Milestone | Full-screen celebration (dismissible) |
| Goal Completed | Major celebration + shareable card |
| Milestone Reached | Badge unlock + encouraging message |

**Micro-interactions:**
- Checkbox: Smooth fill animation (0.3s)
- Haptic: Light tap on completion
- Sound: Optional subtle "ding" (off by default)
- Progress ring: Animated fill when updating

#### Motivational Messages
Rotate encouraging messages based on context:

**Morning (before noon):**
- "New day, new opportunity!"
- "What will you achieve today?"
- "Small steps lead to big results"

**After completing a task:**
- "Nice work! Keep it going"
- "One step closer to your goal"
- "Progress is progress"

**Streak milestones:**
- "🔥 You're on fire!"
- "Consistency is your superpower"
- "Look at you go!"

**After a missed day (no guilt):**
- "Welcome back! Ready to continue?"
- "Every day is a fresh start"
- "Pick up where you left off"

**Ramadan-specific:**
- "Blessed effort! Keep going"
- "Your consistency is worship"
- "The last 10 nights are near - push through!"

### 9.3 What We Avoid (Anti-Patterns)

| Anti-Pattern | Why We Avoid It |
|--------------|-----------------|
| Punishment for missed days | Creates guilt and abandonment |
| Complex point systems | Confusing, distracts from goals |
| Leaderboards | Comparison breeds anxiety |
| Daily login rewards | Feels manipulative |
| Limited-time events | Creates FOMO, pressure |
| Too many badges | Dilutes meaning |
| Notifications for gamification | Annoying, feels like a game not a tool |

---

## 11. Simple UX Principles

### 10.1 Core UX Philosophy
**"One screen, one purpose."** Every screen should have a clear, singular focus. Users should never feel lost or overwhelmed.

**Guiding Principles:**
1. **Minimal taps to complete tasks** - Primary action always visible
2. **Progressive disclosure** - Show basics first, details on demand
3. **Forgiving design** - Easy to undo, hard to make mistakes
4. **Calm interface** - No visual noise, ample whitespace
5. **Accessible by default** - Large touch targets, readable text

### 10.2 Screen-by-Screen Simplicity

#### Home/Dashboard (Primary Screen)
**Purpose:** Complete today's tasks

```
┌─────────────────────────────────┐
│  Today, Feb 1          🔥 7    │  ← Date + Streak
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────┐   │
│  │ ☐ Run 20 minutes        │   │  ← Tap anywhere to complete
│  │   🏃 Run a 5K   ·  20m  │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ ☑ Read 25 pages         │   │  ← Completed state
│  │   📚 Read 4 books · 30m │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ ☐ Save $33              │   │
│  │   💰 Save $1000  ·  5m  │   │
│  └─────────────────────────┘   │
│                                 │
├─────────────────────────────────┤
│  ◐ 1 of 3 done                 │  ← Daily progress
└─────────────────────────────────┘
│  🏠    📊    ➕    ⚙️           │  ← Bottom nav (4 items max)
└─────────────────────────────────┘
```

**Key Decisions:**
- Tasks are full-width cards (easy to tap)
- Checkbox is large and obvious
- Category icon + color for quick recognition
- Time estimate shown but not prominent
- Progress bar at bottom (not competing for attention)

#### Goal Creation (2-Step Process)
**Step 1: What's your goal?**
```
┌─────────────────────────────────┐
│  ← New Goal                     │
├─────────────────────────────────┤
│                                 │
│  What do you want to achieve?   │
│                                 │
│  ┌─────────────────��───────┐   │
│  │ I want to...            │   │  ← Large text input
│  │ run a 5K                │   │
│  └─────────────────────────┘   │
│                                 │
│  Or pick a template:            │
│  ┌─────┐ ┌─────┐ ┌─────┐       │
│  │ 🏃  │ │ 📚  │ │ 🧘  │ ...   │  ← Category chips
│  └─────┘ └─────┘ └─────┘       │
│                                 │
│  ┌─────────────────────────┐   │
│  │      Next →              │   │  ← Primary CTA
│  └─────────────────────────┘   │
└─────────────────────────────────┘
```

**Step 2: How long?**
```
┌─────────────────────────────────┐
│  ← Back                         │
├─────────────────────────────────┤
│                                 │
│  "Run a 5K"                     │
│                                 │
│  How many days?                 │
│                                 │
│  ┌─────┐ ┌─────┐ ┌─────┐       │
│  │ 7   │ │ 14  │ │ 30  │       │  ← Preset options
│  └─────┘ └─────┘ └─────┘       │
│  ┌─────┐ ┌─────┐ ┌─────┐       │
│  │ 60  │ │ 90  │ │ ··· │       │  ← Custom option
│  └─────┘ └─────┘ └─────┘       │
│                                 │
│  ┌─────────────────────────┐   │
│  │   Create My Plan ✨      │   │  ← Generates with AI
│  └─────────────────────────┘   │
└─────────────────────────────────┘
```

**Why 2 steps?**
- Reduces cognitive load
- Each step has one decision
- User feels progress
- Easy to go back

#### Progress View
**Purpose:** See how far you've come

```
┌─────────────────────────────────┐
│  Progress                       │
├─────────────────────────────────┤
│                                 │
│  🏃 Run a 5K                    │
│  ████████░░░░░░░░  Day 12/30    │
│  40% complete                   │
│                                 │
│  📚 Read 4 books                │
│  ██████████████░░  Day 12/30    │
│  75% complete · 1 book done     │
│                                 │
├─────────────────────────────────┤
│  February 2026                  │
│  ┌─┬─┬─┬─┬─┬─┬─┐               │
│  │ │●│●│●│◐│ │ │  ← Calendar   │
│  ├─┼─┼─┼─┼─┼─┼─┤     ● = 100%  │
│  │●│●│◐│○│ │ │ │     ◐ = 50%+  │
│  └─┴─┴─┴─┴─┴─┴─┘     ○ = <50%  │
│                                 │
└─────────────────────────────────┘
```

### 10.3 Interaction Patterns

#### One-Tap Completion
The most important action (completing a task) should be ONE TAP:
- Tap anywhere on task card = complete
- No confirmation dialog needed
- Instant visual feedback
- Easy undo (shake or undo button appears briefly)

#### Swipe Gestures (Optional, Power Users)
| Gesture | Action |
|---------|--------|
| Swipe right | Complete task |
| Swipe left | Skip today (reschedule) |
| Long press | View task details |

#### Navigation
**Bottom Tab Bar (4 items max):**
| Icon | Label | Purpose |
|------|-------|---------|
| 🏠 | Today | Daily dashboard (home) |
| 📊 | Progress | Calendar + stats |
| ➕ | Add | Create new goal |
| ⚙️ | Settings | Preferences |

**Why 4 tabs?**
- Easy thumb reach on any phone size
- No cognitive overload
- Clear mental model

### 10.4 Accessibility

| Requirement | Implementation |
|-------------|----------------|
| Touch targets | Minimum 44x44pt (iOS) / 48x48dp (Android) |
| Text size | Support system font scaling |
| Color contrast | WCAG AA minimum (4.5:1) |
| Screen readers | Full VoiceOver/TalkBack support |
| Reduced motion | Respect system setting, skip animations |
| Color blindness | Never rely on color alone (use icons + labels) |

### 10.5 Empty States & Onboarding

**First Launch (No Goals Yet):**
```
┌─────────────────────────────────┐
│                                 │
│         🎯                      │
│                                 │
│   What will you achieve?        │
│                                 │
│   Tell us your goal and we'll   │
│   create a daily plan for you.  │
│                                 │
│  ┌─────────────────────────┐   │
│  │   Set My First Goal →    │   │
│  └─────────────────────────┘   │
│                                 │
│   Or explore ideas:             │
│   🏃 Fitness  📚 Learning  🌙   │
│                                 │
└─────────────────────────────────┘
```

**No Tasks Today (Rest Day):**
```
┌─────────────────────────────────┐
│                                 │
│         😌                      │
│                                 │
│   Rest day!                     │
│                                 │
│   No tasks scheduled today.     │
│   Enjoy your break.             │
│                                 │
│   Your streak is safe: 🔥 7     │
│                                 │
└─────────────────────────────────┘
```

**Goal Completed:**
```
┌─────────────────────────────────┐
│                                 │
│         🏆                      │
│                                 │
│   Goal Complete!                │
│                                 │
│   You finished "Run a 5K"       │
│   in 30 days!                   │
│                                 │
│   28/30 tasks completed (93%)   │
│                                 │
│  ┌─────────────────────────┐   │
│  │     Share My Win 📤      │   │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │   Start Another Goal     │   │
│  └─────────────────────────┘   │
│                                 │
└─────────────────────────────────┘
```

### 10.6 Error States & Edge Cases

| Scenario | Handling |
|----------|----------|
| No internet (AI generation) | "You're offline. Connect to create your plan." + Retry button |
| AI takes too long | Loading animation + "Creating your personalized plan..." |
| AI fails | "Something went wrong. Try again?" + Retry button |
| Goal too vague | "Tell us more! How about: 'Run 5K in 30 days'" |
| App crash recovery | Restore exact state, no data loss |

### 10.7 Performance Feel

| Action | Expected Response |
|--------|-------------------|
| App launch | < 1 second to usable state |
| Task completion | Instant (< 100ms) |
| Screen transitions | 300ms or less |
| AI generation | Show progress, feel fast |

**Perceived Performance Tricks:**
- Show skeleton screens during load
- Optimistic UI updates (mark done before saving)
- Preload likely next screens
- Cache AI responses for similar goals

---

## 12. Monetization Strategy

### 12.1 Completely Free App (MVP)
This app is **100% free** with no paywalls, subscriptions, or ads.

**Why Free?**
- Goal achievement tools should be accessible to everyone
- Removes barriers to entry worldwide
- Maximizes impact and user adoption
- Aligns with the spirit of helping others improve

### 12.2 Sustainability Model
| Option | Description |
|--------|-------------|
| Open Source | Community-contributed development |
| Donations | Optional "support the app" in-app or website |
| Sponsorships | Ethical partnerships with wellness/productivity brands |
| Grants | Apply for grants from health/wellness foundations |

### 12.3 Cost Management
- Optimize AI API usage (caching, efficient prompts)
- Use free-tier cloud services where possible
- Local-first architecture minimizes server costs

---

### 12.4 Donation System (Post-MVP)

A voluntary donation system to sustain the app without compromising the free experience.

#### 12.4.1 Design Philosophy

- **Never block features** - All features remain 100% free
- **Non-intrusive** - Never interrupt the user experience with donation prompts
- **Transparent** - Show exactly what donations support (AI costs, development)
- **Gratitude, not guilt** - Frame as "support if you can" not "we need money"
- **No perks that affect functionality** - Avoid creating "second-class" free users

#### 12.4.2 Donation Entry Points

```
┌─────────────────────────────────────────────────────────────────────┐
│                    DONATION TOUCHPOINTS                              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                       │
│  1. SETTINGS PAGE (Always Available)                                 │
│     └── "Support TaskTrakr" option with heart icon                      │
│                                                                       │
│  2. ABOUT PAGE                                                        │
│     └── "This app is free thanks to generous supporters"             │
│     └── "Support the project" button                                 │
│                                                                       │
│  3. GOAL COMPLETION CELEBRATION (Subtle)                             │
│     └── After completing a major goal/milestone                      │
│     └── "TaskTrakr helped you achieve this! Support the mission?"       │
│     └── Small, dismissible prompt (show max once per month)          │
│                                                                       │
│  4. APP ANNIVERSARY (Once per year)                                  │
│     └── "You've been using TaskTrakr for 1 year!"                       │
│     └── "Consider supporting continued development"                  │
│                                                                       │
└─────────────────────────────────────────────────────────────────────┘
```

#### 12.4.3 Donation Tiers

| Tier | Amount | Name | Thank You |
|------|--------|------|-----------|
| ☕ | $2-5 | "Buy us a coffee" | Thank you message |
| 🌙 | $10 | "Supporter" | Thank you + name in supporters list (optional) |
| ⭐ | $25 | "Champion" | Above + supporter badge in app (optional) |
| 💎 | $50+ | "Patron" | Above + early access to new features |

**Important:** Badges/recognition are purely cosmetic and optional. Users can donate anonymously.

#### 12.4.4 Donation UI Mockup

**Settings > Support TaskTrakr:**

```
┌─────────────────────────────────────────────────┐
│  ❤️  Support TaskTrakr                             │
├─────────────────────────────────────────────────┤
│                                                  │
│  TaskTrakr is free for everyone, forever.          │
│                                                  │
│  Your support helps us:                         │
│  • Keep the app ad-free                         │
│  • Pay for AI services                          │
│  • Add new features                             │
│  • Support more languages                       │
│                                                  │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐            │
│  │   $3    │ │   $10   │ │   $25   │            │
│  │  ☕     │ │   🌙    │ │   ⭐    │            │
│  │ Coffee  │ │Supporter│ │Champion │            │
│  └─────────┘ └─────────┘ └─────────┘            │
│                                                  │
│  ┌─────────────────────────────────────┐        │
│  │  Custom Amount: $[____]             │        │
│  └─────────────────────────────────────┘        │
│                                                  │
│  ┌─────────────────────────────────────┐        │
│  │        💚 Support TaskTrakr            │        │
│  └─────────────────────────────────────┘        │
│                                                  │
│  Payment secured by Apple/Google                │
│                                                  │
└─────────────────────────────────────────────────┘
```

**Post-Goal Completion (Subtle Prompt):**

```
┌─────────────────────────────────────────────────┐
│                                                  │
│            🎉 Goal Completed!                   │
│                                                  │
│     "Complete the Quran in 30 Days"             │
│                                                  │
│           ████████████████ 100%                 │
│                                                  │
│  ─────────────────────────────────────────────  │
│                                                  │
│  TaskTrakr helped you achieve this goal!           │
│  Support our mission to help others? (optional) │
│                                                  │
│  ┌──────────────┐    ┌──────────────┐           │
│  │  ❤️ Support  │    │   Maybe Later │           │
│  └──────────────┘    └──────────────┘           │
│                                                  │
└─────────────────────────────────────────────────┘
```

#### 12.4.5 Payment Integration

| Platform | Method | Fee |
|----------|--------|-----|
| **iOS** | Apple In-App Purchase (consumable) | 15-30% |
| **Android** | Google Play Billing | 15-30% |
| **Alternative** | Link to Ko-fi / Buy Me a Coffee / GitHub Sponsors | 0-5% |

**Recommendation:** Use platform-native payments (IAP) for simplicity and trust, despite higher fees. Alternatively, link to external donation page to avoid platform fees.

```typescript
interface DonationConfig {
  // Platform payments
  apple_iap_enabled: boolean;
  google_play_enabled: boolean;

  // External options (to avoid 30% fee)
  external_links: {
    kofi?: string;           // "https://ko-fi.com/tasktrakr"
    buymeacoffee?: string;   // "https://buymeacoffee.com/tasktrakr"
    github_sponsors?: string; // "https://github.com/sponsors/tasktrakr"
    paypal?: string;
  };

  // Tiers
  tiers: DonationTier[];
}

interface DonationTier {
  id: string;
  amount_usd: number;
  name: LocalizedString;
  emoji: string;
  description: LocalizedString;
  badge_id?: string;  // Optional cosmetic badge
}
```

#### 12.4.6 Transparency Dashboard (Optional)

Build trust by showing how donations are used:

```
┌─────────────────────────────────────────────────┐
│  📊 How Your Support Helps                      │
├─────────────────────────────────────────────────┤
│                                                  │
│  This Month:                                    │
│  • 12,450 goals generated with AI               │
│  • 89,230 tasks completed by users              │
│  • 3 new languages added                        │
│                                                  │
│  Costs Covered by Donations:                    │
│  ├── AI API Costs      ████████░░  78%          │
│  ├── Development       ██░░░░░░░░  15%          │
│  └── Infrastructure    █░░░░░░░░░   7%          │
│                                                  │
│  Thank you to 234 supporters this month! 💚     │
│                                                  │
└─────────────────────────────────────────────────┘
```

#### 12.4.7 Supporter Recognition (Optional, Opt-In)

Users who donate can optionally:
- Display a small supporter badge on their profile
- Be listed on a "Supporters" page (first name or anonymous)
- Get early access to beta features

**Never:**
- Show different UI for free vs. paying users
- Limit features based on donation status
- Make non-donors feel inferior

#### 12.4.8 Donation Prompt Rules

To keep the experience positive, enforce strict limits:

```typescript
interface DonationPromptRules {
  // Never show prompts if...
  suppress_if: {
    user_already_donated: boolean;        // true
    app_used_less_than_days: number;      // 7
    goals_completed_less_than: number;    // 1
    last_prompt_days_ago: number;         // 30
  };

  // Maximum frequency
  max_prompts_per_month: number;          // 1
  max_prompts_per_year: number;           // 6

  // User can permanently dismiss
  allow_permanent_dismiss: boolean;       // true
}
```

#### 12.4.9 Projected Revenue

Conservative estimates based on industry benchmarks (1-3% of users donate):

| Monthly Active Users | Donation Rate | Avg Donation | Monthly Revenue |
|---------------------|---------------|--------------|-----------------|
| 10,000 | 1% | $5 | $500 |
| 50,000 | 1.5% | $5 | $3,750 |
| 100,000 | 2% | $5 | $10,000 |
| 500,000 | 2% | $5 | $50,000 |
| 1,000,000 | 2% | $5 | $100,000 |

**At 100K users with 2% donation rate:** ~$10,000/month, far exceeding the ~$500/month AI costs.

#### 12.4.10 Implementation Timeline

| Phase | Milestone | Priority |
|-------|-----------|----------|
| MVP | No donations (focus on product) | - |
| Post-MVP 1 | "Support" page in Settings | Medium |
| Post-MVP 2 | In-app purchase integration | Medium |
| Post-MVP 3 | Subtle post-goal prompts | Low |
| Post-MVP 4 | Transparency dashboard | Low |
| Post-MVP 5 | Supporter badges | Low |

---

## 13. Launch Strategy

### 10.1 Timeline
| Phase | Timeframe | Deliverables |
|-------|-----------|--------------|
| Design & Planning | 4 weeks | Wireframes, UI design, technical architecture |
| MVP Development | 8 weeks | Core features (F1-F5) |
| Testing & QA | 2 weeks | Beta testing, bug fixes |
| Soft Launch | 2 weeks | Limited release, gather feedback |
| Full Launch | Target: Before Ramadan 2026 | App Store & Play Store release |

### 10.2 Marketing Channels
- Product Hunt launch
- Reddit communities (r/productivity, r/getdisciplined, r/islam for Ramadan mode)
- Social media (Twitter/X, Instagram)
- App Store Optimization (ASO)
- Islamic content creators (for Ramadan mode)
- Fitness/productivity influencers

---

## 14. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| AI generates unrealistic tasks | Medium | High | Validate AI outputs, allow regeneration, user feedback loop |
| AI generates inappropriate content | Low | High | Content filtering, clear system prompts |
| Users abandon goals mid-way | High | Medium | Streak incentives, milestone celebrations, smart reminders |
| Technical issues during peak usage | Low | Medium | AI calls are only bottleneck; local storage eliminates server concerns |
| Data loss on device | Medium | Medium | Provide export/backup feature, clear warning on uninstall |
| Competition from existing apps | High | Medium | Focus on AI differentiation, specialized modes (Ramadan) |

---

## 15. Success Criteria for MVP

The MVP is considered successful if:
1. ✅ Users can input any goal in natural language
2. ✅ AI generates reasonable task schedules for various goal types
3. ✅ Users can track daily progress via checkboxes
4. ✅ Ramadan mode works correctly with Islamic context
5. ✅ App functions reliably with local-only storage
6. ✅ >1,000 users complete at least one goal

---

## 16. Future Vision

### Phase 2 (Post-Launch)
- Goal templates library
- Smart adjustments for falling behind
- Sharing & accountability features
- Calendar integration (export tasks to iOS/Google Calendar)
- Additional special modes (Dhul Hijjah, Lent, etc.)

### Phase 3 (6+ months)
- AI-powered coaching/encouragement
- Habit analytics and insights
- Community challenges
- Widgets for iOS and Android

### Phase 4 (12+ months)
- Team/family goals

### Integration Philosophy
**We intentionally limit external integrations.** The only integration we will support is exporting to the device calendar. We will NOT integrate with:
- Health/fitness apps (Apple Health, Google Fit)
- Social media platforms
- Third-party productivity tools
- Cloud sync services

**Rationale:** Simplicity, privacy, and focus. Every integration adds complexity, potential points of failure, and privacy concerns. Calendar export covers the primary use case (seeing tasks in context) without compromising our principles.

---

## 17. Appendix

### A. Competitor Analysis
| App | Strengths | Weaknesses |
|-----|-----------|------------|
| Habitica | Gamification, community | Complex, no AI planning |
| Streaks | Beautiful UI, Apple integration | Manual setup, limited goals |
| Todoist | Powerful task management | Not goal-focused, no AI |
| Muslim Pro | Islamic features, prayer times | No AI, generic goal tracking |
| Fabulous | Guided journeys, science-backed | Subscription model, limited customization |

**Our Differentiation:**
- AI generates the entire plan from a simple sentence
- Specialized modes (Ramadan) with domain expertise
- 100% free, no ads
- Privacy-first (all data on device)

### B. Sample AI Prompts by Category

**Fitness:**
```
System: Create a {duration}-day fitness plan that progressively
builds toward the goal. Apply progressive overload principles.
Include rest days every 3-4 days for recovery.

User Goal: "I want to run a 5K"
Duration: 30 days
```

**Learning:**
```
System: Create a {duration}-day learning plan using spaced
repetition. Balance new material with review. Include active
practice, not just passive reading.

User Goal: "I want to learn 500 Spanish words"
Duration: 60 days
```

**Financial:**
```
System: Create a {duration}-day savings plan breaking the goal
into daily actions. Include both saving and spending awareness tasks.

User Goal: "I want to save $1000"
Duration: 30 days
```

**Creative:**
```
System: Create a {duration}-day creative practice schedule.
Balance skill-building with creative expression. Include
rest days to prevent burnout.

User Goal: "I want to learn to play 10 songs on guitar"
Duration: 60 days
```

**Wellness:**
```
System: Create a {duration}-day wellness habit schedule.
Start with small, achievable steps and gradually build.
Focus on consistency over intensity.

User Goal: "I want to meditate for 20 minutes daily"
Duration: 30 days
```

**Ramadan (Special Mode):**
```
System: Create a 30-day Ramadan schedule that accounts for
the three phases (mercy, forgiveness, salvation). Emphasize
increased worship during the last 10 nights, especially odd nights.

User Goal: "I want to complete reading the Quran during Ramadan"
Duration: 30 days
```

### C. Glossary

**General Terms:**
- **Streak:** Consecutive days of completing a specific goal's task
- **Milestone:** Significant checkpoint within a goal
- **Progressive Overload:** Gradually increasing difficulty (fitness)
- **Spaced Repetition:** Review pattern for learning retention
- **Rest Day:** Scheduled recovery day (counts toward streak)
- **Intensity:** Task difficulty level (light, moderate, intense)

**Category-Specific Terms:**

*Fitness:*
- **Warm-up/Cool-down:** Pre/post exercise preparation
- **Interval Training:** Alternating high/low intensity
- **Taper:** Reducing intensity before a big event

*Learning:*
- **Active Recall:** Testing yourself rather than re-reading
- **Flashcards:** Spaced repetition study tool
- **Immersion:** Surrounding yourself with the subject

*Financial:*
- **No-Spend Day:** Challenge to avoid all non-essential purchases
- **Micro-Saving:** Small daily savings that add up

**Islamic Terms (Ramadan Mode):**
- **Juz:** 1/30th portion of the Quran
- **Taraweeh:** Special night prayers during Ramadan
- **Tahajjud:** Late night voluntary prayers
- **Laylatul Qadr:** Night of Power (one of the last 10 odd nights)
- **Sadaqah:** Voluntary charity
- **Zakat:** Obligatory charity (2.5% of savings)
- **Hijri:** Islamic lunar calendar
- **Fajr/Iftar:** Dawn prayer / Breaking the fast

---

**Document Status:** Draft
**Next Review:** [TBD]
**Stakeholders:** Product, Engineering, Design, Marketing
