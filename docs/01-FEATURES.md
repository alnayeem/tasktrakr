# TaskTrakr Features & Requirements

> Load after: [00-MVP-PLAN.md](./00-MVP-PLAN.md)

## Core Features (MVP)

### F1: Onboarding & Goal Setting

**Description:** Users describe their goals in free-form natural language

**Requirements:**
- Text input field for free-form goal description
- Support for multiple goals (unlimited)
- Goal duration selector (7, 14, 30, 60, 90 days, custom)
- Goal category selection (optional):
  - 🏃 Fitness & Health
  - 📚 Learning & Education
  - 🎨 Creative & Hobbies
  - 💼 Career & Productivity
  - 🧘 Wellness & Mindfulness
  - 💰 Financial
  - 🌙 Ramadan / Islamic (special mode)
  - ✨ Other

**Sample Goals by Category:**

| Category | Examples |
|----------|----------|
| Fitness | "Run a 5K in 30 days", "Do 100 pushups daily" |
| Learning | "Learn 500 Spanish words", "Read 4 books" |
| Creative | "Write 50,000 words", "Draw daily for 30 days" |
| Wellness | "Meditate 10 mins daily", "Sleep by 10pm" |
| Financial | "Save $1000", "Track all expenses" |
| Ramadan | "Complete the Quran", "Pray 5 times daily" |

**Acceptance Criteria:**
- [ ] User can type goals in natural language
- [ ] User can select goal duration
- [ ] User can optionally select category
- [ ] User can add multiple goals
- [ ] Goals are saved and editable

---

### F2: AI Task Generation

**Description:** AI generates a structured task schedule for the goal duration

**Requirements:**
- Parse natural language to understand intent
- Generate realistic, achievable daily tasks
- Account for rest days where appropriate
- Allow regeneration if unsatisfied
- Support difficulty preferences (easy, moderate, challenging)

**Examples:**

| Input | Duration | Output |
|-------|----------|--------|
| "Run a 5K" | 30 days | Week 1: Walk 20 mins → Week 4: Run 5K |
| "Read 4 books" | 30 days | "Read 25 pages per day" |
| "Complete Quran" | 30 days | "Read 1 Juz per day (20 pages)" |

**Acceptance Criteria:**
- [ ] AI generates tasks within 5 seconds
- [ ] Tasks distributed across duration
- [ ] User can regenerate tasks
- [ ] Rest days included where appropriate

---

### F2.1: Ramadan Mode

**Description:** Specialized mode for Islamic spiritual goals

**When Activated:**
- User selects "Ramadan / Islamic" category, OR
- User mentions Ramadan in goal text

**Special Features:**
- Hijri calendar integration
- Ramadan phase awareness:
  - Days 1-10: Mercy (رحمة)
  - Days 11-20: Forgiveness (مغفرة)
  - Days 21-30: Salvation (عتق من النار)
- Laylatul Qadr emphasis (odd nights 21, 23, 25, 27, 29)
- Islamic terminology in tasks

**Ramadan Templates:**
1. "Complete reading the entire Quran"
2. "Pray all 5 daily prayers on time"
3. "Pray Taraweeh every night"
4. "Donate $X to charity"
5. "Memorize X Surahs"

**Acceptance Criteria:**
- [ ] Ramadan mode activates correctly
- [ ] Tasks reflect Islamic context
- [ ] Last 10 nights show increased emphasis
- [ ] Hijri date displayed

---

### F3: Daily Task Tracking

**Description:** Users check off tasks as they complete them

**Requirements:**
- One-tap checkbox to mark complete
- Visual feedback (animation, sound)
- Task state persists locally
- View tasks by day or week
- Mark tasks as skipped (optional)

**Acceptance Criteria:**
- [ ] Checkboxes work instantly (< 100ms)
- [ ] Completion persists across app restarts
- [ ] Today's tasks prominently displayed
- [ ] Can view past/future tasks

---

### F4: Progress & Streaks

**Description:** Visual progress tracking and streak counter

**Requirements:**
- Progress bar/ring per goal
- Goal-specific streak counter (not global)
- Current streak prominently displayed
- Streak doesn't break on rest days

**Acceptance Criteria:**
- [ ] Progress updates in real-time
- [ ] Streak increments on task completion
- [ ] Rest days don't break streak
- [ ] Visual celebration at milestones

---

### F5: Settings & Preferences

**Requirements:**
- Language selection (English/Arabic for MVP)
- Theme toggle (Light/Dark/System)
- Notification preferences
- About/Support page

---

## Post-MVP Features

| Feature | Priority | Notes |
|---------|----------|-------|
| Voice input | P2 | Nice-to-have |
| Milestones & Badges | P2 | Gamification |
| Tips system | P3 | Encouraging messages |
| 10+ languages | P1 | Post-launch |
| Export/Import | P3 | Backup data |
| Widgets | P3 | iOS/Android widgets |
| Notifications | P2 | Reminders |
