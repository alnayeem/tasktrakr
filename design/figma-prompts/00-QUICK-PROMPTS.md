# TaskTrakr - Quick Copy-Paste Prompts for AI Design Tools

Use these prompts with **Visily**, **Galileo AI**, **Uizard**, or similar tools.

---

## ⚠️ IMPORTANT: Generate in This Order

1. **FIRST**: Generate the Design System ([00-DESIGN-SYSTEM.md](00-DESIGN-SYSTEM.md))
2. **THEN**: Generate screens in order (1-7)
3. **ALWAYS**: Append the Style Anchor (below) to every screen prompt

---

## Style Anchor (APPEND TO EVERY PROMPT)

Copy this to the END of every screen prompt to ensure consistency:

```
STYLE REQUIREMENTS (must match exactly):
- Colors: Primary #2196F3, Accent Green #1B5E20 (special modes), Success #4CAF50, Warning #FF9800, Background #FAFAFA, Cards #FFFFFF, Text #212121/#757575
- Cards: 16px radius, 16px padding, shadow 0 4px 12px rgba(0,0,0,0.08)
- Buttons: 56px height, 16px radius, full-width
- Checkboxes: 28x28px, 8px radius, 2px gray border (unchecked) or filled blue/green (checked)
- Chips: 12px radius, 12px horizontal padding
- Screen padding: 20px horizontal
- Section gaps: 24px
- Typography: Titles 18px semibold, Body 14-16px regular
- Icon containers: 44-48px square, 12px radius, color at 10% background
```

---

## Screen 1: Language Selection

```
Mobile app onboarding screen for language selection. Clean minimal design with light gray background.

Centered blue gradient app logo (120px square, rounded corners) with sparkle emoji at top.

Title "Choose your language" with Arabic subtitle "اختر لغتك" below.

Two full-width selection cards:
1. US flag emoji + "English"
2. Saudi flag emoji + "العربية"

Selected card has light blue background, blue border, and circular blue checkmark on right.

Blue "Continue" button at bottom, disabled (50% opacity) until language selected.

Colors: Background #FAFAFA, Primary #2196F3, Cards white with subtle shadow.
```

---

## Screen 2: Welcome Screen

```
Mobile app welcome screen for goal tracking app "TaskTrakr".

Large circular illustration area at top with sparkle emoji and "TaskTrakr" text in blue.

"Welcome" headline with subtitle "Turn your goals into achievable daily tasks with AI".

Four feature rows with emoji icons in light blue rounded squares:
- 🎯 Set goals in your own words
- 🤖 AI creates your daily plan
- ✅ Track progress every day
- 🌙 Special Ramadan mode

Blue "Get Started" button with arrow icon at bottom.

Clean, inspiring design. Colors: Primary #2196F3, Background #FAFAFA.
```

---

## Screen 3: Dashboard

```
Mobile app home dashboard for AI-powered goal and habit tracking app.

Header with sparkle emoji + "TaskTrakr" title and settings gear icon.

Optional: Green special mode banner card (shown when Ramadan mode active) with moon emoji, contextual title, date info, and "Day 5" badge.

"Today's Tasks" section with completion badge "1/2":
- Task card 1: Checkbox, "Read 25 pages", goal pill "📚 Read 4 Books", "30 min", fire streak badge "🔥 4"
- Task card 2: Completed state with green checkmark, strikethrough text, "Run 2K", "🏃 Run 5K", "🔥 12"

"My Goals" section with 2x2 grid:
- Goal card: 📚 icon, "Read 4 Books", 60% progress bar
- Goal card: 🏃 icon, "Run 5K", 80% progress bar
- Add Goal card: Dashed border, + icon, "Add Goal" text

Blue floating action button "+ New Goal" at bottom right.

Colors: Primary #2196F3, Accent green #1B5E20 (for special modes), Success #4CAF50, Streak orange #FF9800.
```

---

## Screen 4: Goal Creation

```
Mobile app goal creation form screen.

Header with back arrow and "New Goal" title.

"What do you want to achieve?" label with large multi-line text input card. Placeholder: "Example: I want to complete reading the Quran this Ramadan..."

"Duration" section with selectable chips: 7d, 14d, 30d (selected, blue), 60d, 90d.

"Category (optional)" section with emoji chips:
🏃 Fitness, 📚 Learning, 🌙 Ramadan, 🧘 Wellness, 🎨 Creative, 💰 Financial, 💼 Career, ✨ Other

Selected category chip has colored border and tinted background.

Blue "✨ Generate Plan" button at bottom (green if Ramadan selected).

Helper text: "AI will create a personalized daily plan for you"

Clean form design. Colors: Primary #2196F3, Ramadan #1B5E20.
```

---

## Screen 5: AI Loading

```
Mobile app loading screen while AI generates a plan.

Centered animated loading indicator:
- Outer rotating ring with blue gradient
- Inner pulsing circle with moon emoji 🌙 (or sparkle for non-Ramadan)

Loading message that cycles: "Analyzing your goal...", "Creating your personalized plan...", "Distributing tasks across 30 days..."

Progress bar below message showing incremental progress.

"Creating 30 daily tasks" subtitle.

Card at bottom showing "Your goal:" with the user's goal text.

"Cancel" text button at very bottom.

Calming, reassuring design. Colors: Primary #2196F3 (or green #1B5E20 for Ramadan).
```

---

## Screen 6: Goal Detail

```
Mobile app goal detail screen with progress tracking.

Header with back arrow, goal emoji 📚 + "Read 4 Books" title, and more options (3 dots) icon.

Large circular progress ring showing 60% with "Complete" label. "18 of 30 days" below.

Stats row: 🔥 "4" Current Streak (orange) | 🏆 "7" Best Streak (green)

Optional: Special mode phase card (for Ramadan goals): Green gradient, moon emoji, phase info, milestone badge.

"Today - Day 19" section with highlighted task tile:
- Blue border indicating today
- Day "19" badge, "Read chapters 5-6", "35 min", empty checkbox

"Upcoming" section with day tiles:
- Day 20: "Read chapters 7-8"
- Day 21: "Read chapters 9-10" with ⭐ milestone badge (optional)
- Day 22: "😴 Rest Day" (gray, no checkbox)

"Completed" section with "18/30" badge:
- Day 17, Day 18 tiles with green checkmarks

Colors: Primary #2196F3, Success #4CAF50, Accent green #1B5E20 (special modes), Gold #FFD700 (milestones).
```

---

## Screen 7: Settings

```
Mobile app settings screen.

Header with back arrow and "Settings" title.

"Language" section with tile: Globe icon, "Language", current value "English", chevron.

"Appearance" section with tile: Palette icon, "Theme", current value "System", chevron.

"About" section with three tiles:
- Info icon, "About TaskTrakr", chevron
- Shield icon, "Privacy Policy", chevron
- Help icon, "Help & Support", chevron

Green privacy notice card with lock icon: "Your data stays private" title, "All your data is stored locally on your device. We don't collect any personal information." body text.

"TaskTrakr v1.0.0" version text at bottom center.

Standard settings pattern. Colors: Various icon colors, Privacy card uses green #4CAF50.
```

---

## Design System Reference

### Colors
| Name | Hex | Usage |
|------|-----|-------|
| Primary | #2196F3 | Buttons, links, selected states |
| Ramadan | #1B5E20 | Islamic/Ramadan themed elements |
| Success | #4CAF50 | Completed, checkmarks, positive |
| Warning | #FF9800 | Streaks, attention |
| Error | #F44336 | Errors, delete actions |
| Gold | #FFD700 | Laylatul Qadr special nights |
| Background | #FAFAFA | Light mode background |
| Card | #FFFFFF | Card surfaces |
| Text Primary | #212121 | Main text |
| Text Secondary | #757575 | Subtitles, hints |

### Typography
- Headlines: 24-32px, Bold
- Titles: 18-20px, SemiBold
- Body: 14-16px, Regular
- Captions: 12px, Regular

### Spacing
- Screen padding: 20px
- Card padding: 16px
- Section gaps: 24-32px
- Element gaps: 8-12px

### Border Radius
- Cards: 16px
- Buttons: 12-16px
- Chips: 12px (rectangular) or 20px (pill)
- Checkboxes: 8px
- Icons containers: 10-12px

---

## Workflow for Consistent Designs

### Option A: Single Tool (Recommended)

1. Use ONE tool (Visily, Galileo, or Uizard) for ALL screens
2. Generate Design System first
3. Generate screens in order, always appending Style Anchor
4. Export all to Figma together

### Option B: Fix in Figma After

1. Generate all screens (may be inconsistent)
2. Import all to Figma
3. Create a shared Figma styles library:
   - Color styles matching our tokens
   - Text styles matching our typography
   - Effect styles for shadows
4. Apply shared styles to all screens
5. Use Figma's "Select all with same..." to batch-update

### Option C: Use Figma Plugins

After importing AI-generated designs:
1. **Themer** plugin: Batch-apply color changes
2. **Similayer** plugin: Select similar layers across frames
3. **Design System Organizer**: Create components from selections

### Consistency Checklist

Before finalizing, verify ALL screens have:
- [ ] Same blue (#2196F3) for primary actions
- [ ] Same green (#1B5E20) for Ramadan mode / special mode elements
- [ ] Same card styling (16px radius, same shadow)
- [ ] Same button height (56px)
- [ ] Same checkbox size (28x28px)
- [ ] Same screen padding (20px)
- [ ] Same typography sizes
- [ ] Same emoji sizes in similar contexts
