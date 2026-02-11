# Screen 3: Dashboard (Home Screen)

## AI Design Prompt

```
Mobile app home dashboard for AI-powered goal and habit tracking app "TaskTrakr". Feature-rich but organized layout.

HEADER:
- Height: 56px
- Left: App logo row - sparkle emoji ✨ (24px) + "TaskTrakr" text (20px, bold)
- Right: Settings gear icon (24px, gray)
- Background matches scaffold (#FAFAFA)

BODY (scrollable, 20px horizontal padding):

1. SPECIAL MODE BANNER (conditional - shown when Ramadan mode or other special mode active):
- Full width card, 16px rounded corners
- Gradient background: Dark green (#1B5E20) to slightly lighter green
- Padding: 16px all sides
- Left: Contextual emoji 🌙 (32px) - moon for Ramadan, other icons for other modes
- Center content:
  - Title: Contextual greeting (18px, white, bold)
  - Subtitle: Date/phase info (14px, white at 90%)
- Right: Pill badge "Day 5" (white at 20% background, white text, 20px rounded)
- 24px bottom margin
- NOTE: This is optional - dashboard works without this banner for regular goals

2. TODAY'S TASKS SECTION:
- Section header row:
  - Left: "Today's Tasks" (18px, bold)
  - Right: Completion badge "1/2" (green background at 15%, green text, 12px rounded)
- 12px spacing

- Task Card 1 (incomplete):
  - White background, 16px rounded corners, subtle shadow
  - Padding: 16px
  - Left column: Custom checkbox (28x28px, gray 2px border, 8px rounded, empty)
  - 12px gap
  - Right column:
    - Task title: "Read chapters 3-4" (16px, semibold)
    - Task description: "Continue from page 45" (14px, gray)
    - 12px vertical spacing
    - Bottom row:
      - Goal pill: Light blue bg, "📚 Read 4 Books" (12px, blue text)
      - Duration: "30 min" (12px, gray)
      - Right side: Streak badge - orange bg at 15%, "🔥 4" (12px, orange)

- 12px spacing

- Task Card 2 (completed):
  - Light green background tint (#4CAF50 at 10%)
  - Green border (1.5px, green at 30%)
  - Checkbox: Green filled, white checkmark
  - Task title: Strikethrough style, gray color
  - "Run 2K + walk intervals"
  - Goal pill: "🏃 Run 5K"
  - Streak: "🔥 12"

3. MY GOALS SECTION (32px top margin):
- Section header: "My Goals" (18px, bold)
- 12px spacing

- 2x2 Grid of goal cards (12px gap):

  Goal Card 1:
  - Square-ish aspect ratio (1:1.1)
  - White background, 16px rounded, shadow
  - Padding: 16px
  - Top: Icon container (48x48px, blue at 10%, 12px rounded) with 📚 emoji (24px)
  - Middle: "Read 4 Books" title (16px, semibold)
  - Bottom:
    - Progress row: "60%" (12px, blue, semibold)
    - Progress bar: 6px height, blue fill at 60%, gray track

  Goal Card 2:
  - Same structure
  - 🏃 emoji, "Run 5K", 80% progress

  Add Goal Card (+ button):
  - Dashed blue border (2px, blue at 30%)
  - Centered content:
    - Circle with + icon (48px, blue at 10% bg, blue icon)
    - "Add Goal" text (14px, blue)

FLOATING ACTION BUTTON:
- Position: Bottom right, 20px from edges
- Extended FAB style
- Blue background (#2196F3)
- White icon (+ symbol) + White text "New Goal"
- 28px height, pill shape
- Shadow

COLORS:
- Background: #FAFAFA
- Cards: #FFFFFF
- Primary: #2196F3
- Success/Complete: #4CAF50
- Streak/Warning: #FF9800
- Ramadan green: #1B5E20
- Text primary: #212121
- Text secondary: #757575

STYLE:
- Information-dense but not cluttered
- Clear visual hierarchy
- Celebratory feel for completed items
- Islamic aesthetic for Ramadan elements
```

## Arabic Version Notes
```
RTL layout:
- Header: Settings icon left, logo right
- All text right-aligned
- Section titles: "مهام اليوم", "أهدافي"
- FAB text: "هدف جديد"
- Special mode banner (if shown): Contextual Arabic text
```

## Screen Purpose
Main screen users see daily. Shows today's tasks prominently and provides access to all goals.

## User Flow
- Tap task checkbox → Mark complete (animation)
- Tap task card → Go to Goal Detail
- Tap goal card → Go to Goal Detail
- Tap + / FAB → Go to Goal Creation
- Tap settings → Go to Settings

## Key States
1. **Empty state**: No goals yet, show illustration + "Create your first goal" CTA
2. **Normal state**: Tasks and goals displayed
3. **All complete**: Celebration state, all tasks checked
4. **Special mode active**: Green banner visible (e.g., during Ramadan for Ramadan goals)
