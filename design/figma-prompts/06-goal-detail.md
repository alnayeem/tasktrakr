# Screen 6: Goal Detail Screen

## AI Design Prompt

```
Mobile app goal detail screen showing progress, stats, and daily task list. Information-rich but scannable.

HEADER:
- Back arrow left
- Center: Goal emoji 📚 (24px) + "Read 4 Books" title (20px, semibold)
- Right: More options icon (3 dots vertical)

BODY (scrollable, 20px padding):

1. PROGRESS HEADER (centered):
- Circular progress ring:
  - 120px diameter
  - 10px stroke width
  - Track: Blue at 15%
  - Fill: Blue (#2196F3), 60% filled (216 degrees)
  - Center content:
    - "60%" (28px, bold, blue)
    - "Complete" (12px, gray)
- 16px below ring:
  - "18 of 30 days" (16px, regular)

2. STATS ROW (24px top margin):
- Two stats side by side, separated by vertical divider (1px, 40px height)
- Centered in row

- Stat 1 (Current Streak):
  - Fire emoji 🔥 (20px) + "4" (24px, bold, orange #FF9800)
  - Label below: "Current Streak" (12px, gray)

- Stat 2 (Best Streak):
  - Trophy emoji 🏆 (20px) + "7" (24px, bold, green #4CAF50)
  - Label below: "Best Streak" (12px, gray)

3. SPECIAL MODE CARD (24px top margin, OPTIONAL - only shown for Ramadan or other special mode goals):
- Full width, 12px rounded corners
- Gradient background: Green (#1B5E20) at 10% → 5%
- Green border at 20%
- Padding: 16px
- Left: Contextual emoji 🌙 (32px)
- Center:
  - Phase/milestone title (16px, semibold, green)
  - Progress info (12px, gray)
- Right: Optional milestone badge
  - Gold (#FFD700) at 20% background
  - Star emoji ⭐ + milestone text (11px, green)

4. TODAY SECTION (24px top margin):
- Section header: "Today - Day 19" (16px, semibold)
- 12px spacing

- Today's Task Tile (highlighted):
  - White background, 12px rounded
  - Blue border (2px, primary blue) - indicates "today"
  - Padding: 16px
  - Left: Day indicator box
    - 44x44px, blue background, 12px rounded
    - "19" (16px, bold, white)
    - "Today" (8px, white at 90%)
  - 16px gap
  - Center:
    - Task: "Read chapters 7-8" (16px, medium)
    - "Book 2: Atomic Habits" (14px, gray)
    - Bottom row: Clock icon + "30 min"
  - Right: Empty checkbox (28px, gray border, 8px rounded)

5. UPCOMING SECTION (24px top margin):
- Section header: "Upcoming" (16px, semibold)
- 12px spacing

- Day tiles (simpler, no highlight):

  Day 20 tile:
  - Light background, no border
  - Day indicator: "20" in blue-tinted box
  - Task: "Read chapters 9-10"
  - Duration: "30 min"

  Day 21 tile (with optional milestone):
  - Day indicator: "21"
  - Task: "Finish Book 2"
  - Duration: "35 min"
  - Optional: Milestone badge ⭐ "Halfway!" (gold background)

  Day 22 tile (Rest day):
  - Day indicator: "22" in gray-tinted box
  - "😴 Rest Day" (italic, gray)
  - No checkbox

6. COMPLETED SECTION (24px top margin):
- Section header row:
  - "Completed" (16px, semibold)
  - Right: Badge "18/30" (green background at 15%, green text, 8px rounded)
- 12px spacing

- Completed day tiles:
  - Light green background tint
  - Green checkmark (filled circle, white check)
  - Task text in gray, no strikethrough needed
  - Day 17: "Read chapters 3-4" ✓
  - Day 18: "Read chapters 5-6" ✓

COLORS:
- Background: #FAFAFA
- Cards: #FFFFFF
- Primary: #2196F3
- Success: #4CAF50
- Streak orange: #FF9800
- Accent green: #1B5E20 (for special modes like Ramadan)
- Milestone gold: #FFD700
- Rest day: #9E9E9E

STYLE:
- Clear information hierarchy
- Today prominently highlighted
- Progress feels rewarding
- Easy to scan upcoming tasks
- Special mode elements (if present) feel distinct but not dominant
```

## Arabic Version Notes
```
RTL layout:
- Back arrow points right
- All text right-aligned
- Stats labels: "السلسلة الحالية", "أفضل سلسلة"
- Section headers: "اليوم - يوم 19", "القادم", "المكتمل"
- Rest day: "يوم راحة 😴"
```

## Screen Purpose
Detailed view of a single goal showing all progress, stats, and the complete task schedule.

## User Flow
Dashboard (tap goal) → **Goal Detail**
- Tap checkbox → Mark day complete
- Tap more options → Edit/Delete/Regenerate menu
- Swipe back → Return to Dashboard

## Bottom Sheet Menu (More Options):
1. ✏️ Edit Goal
2. 🔄 Regenerate Plan
3. 🗑️ Delete Goal (red, destructive)

## Key States
1. **Active goal**: Shows today + upcoming + completed
2. **Completed goal**: 100% progress, celebration state
3. **Paused/abandoned**: Gray styling, option to resume
4. **Special mode goal**: Shows additional phase/milestone card (e.g., Ramadan)
