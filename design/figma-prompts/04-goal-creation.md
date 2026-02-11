# Screen 4: Goal Creation

## AI Design Prompt

```
Mobile app goal creation form for habit tracking app. Clean form design with good input UX.

HEADER:
- Back arrow left (or forward arrow for RTL)
- Title: "New Goal" (20px, semibold, centered)
- No right action

BODY (scrollable, 20px padding):

1. GOAL INPUT SECTION:
- Label: "What do you want to achieve?" (16px, semibold)
- 12px spacing
- Text input card:
  - White background, 16px rounded corners, subtle shadow
  - Multi-line textarea (4 lines visible, ~120px height)
  - Placeholder text (gray, 50% opacity): "Example: I want to complete reading the Quran this Ramadan..."
  - 20px internal padding
  - Character counter bottom right: "0/500" (12px, gray)
  - Focused state: Blue 2px border

2. DURATION SECTION (32px top margin):
- Label: "Duration" (16px, semibold)
- 12px spacing
- Horizontal chip row (wrapping allowed):
  - Chips: "7d", "14d", "30d", "60d", "90d"
  - Each chip:
    - Padding: 16px horizontal, 12px vertical
    - 12px rounded corners
    - Unselected: White bg, gray border (1.5px)
    - Selected: Blue bg (#2196F3), white text, blue shadow
  - 8px gap between chips
  - "30d" shown as selected in mockup

3. CATEGORY SECTION (32px top margin):
- Label: "Category (optional)" (16px, semibold)
- 12px spacing
- Chip grid (wrapping):
  - Chips with emoji + label:
    - 🏃 Fitness
    - 📚 Learning
    - 🌙 Ramadan (special - green color when selected)
    - 🧘 Wellness
    - 🎨 Creative
    - 💰 Financial
    - 💼 Career
    - ✨ Other
  - Each chip:
    - Emoji (18px) + 6px gap + Label (13px)
    - Padding: 12px horizontal, 10px vertical
    - 12px rounded corners
    - Unselected: White bg, gray border
    - Selected: Category color at 15% bg, category color border (2px), colored text
  - 8px gap between chips
  - Ramadan chip selected shows green (#1B5E20) theme

4. GENERATE BUTTON (48px top margin):
- Full width
- Height: 56px
- Background: Blue (#2196F3) or Green (#1B5E20) if Ramadan category selected
- Content: Sparkle emoji ✨ (20px) + 8px gap + "Generate Plan" (18px, white, semibold)
- 16px rounded corners
- Shadow when enabled
- Disabled state: 30% opacity, no shadow (when goal text empty OR no duration selected)

5. HELPER TEXT (16px top margin):
- Centered, gray text (14px)
- "AI will create a personalized daily plan for you"

COLORS:
- Background: #FAFAFA
- Input card: #FFFFFF
- Primary: #2196F3
- Ramadan: #1B5E20
- Category colors (for selected state):
  - Fitness: #E91E63
  - Learning: #9C27B0
  - Ramadan: #1B5E20
  - Wellness: #00BCD4
  - Creative: #FF5722
  - Financial: #8BC34A
  - Career: #2196F3
  - Other: #607D8B

STYLE:
- Form-focused, minimal distractions
- Clear affordances (what's tappable)
- Encouraging copy
- Smart defaults (30 days pre-selected for Ramadan)
```

## Arabic Version Notes
```
RTL layout adjustments:
- Back arrow points right (→)
- All labels right-aligned
- Text input: RTL text direction
- Placeholder: "مثال: أريد أن أختم القرآن في رمضان..."
- Labels:
  - "ماذا تريد أن تحقق؟"
  - "المدة"
  - "الفئة (اختياري)"
- Duration chips: "7 يوم", "14 يوم", "30 يوم", "60 يوم", "90 يوم"
- Category labels in Arabic
- Button: "إنشاء خطة"
- Helper: "سيقوم الذكاء الاصطناعي بإنشاء خطة يومية مخصصة لك"
```

## Screen Purpose
Where users describe their goal in natural language and set parameters before AI generates the plan.

## User Flow
Dashboard (+ button) → **Goal Creation** → AI Loading → Goal Detail

## Validation Rules
1. Goal text: Required, 1-500 characters
2. Duration: Required, must select one
3. Category: Optional

## Key Interactions
- Typing in goal field enables character counter
- Selecting duration chip deselects others
- Selecting category chip toggles (tap again to deselect)
- Generate button enables only when goal + duration set
- Tapping Generate shows loading state briefly, then navigates to AI Loading screen
