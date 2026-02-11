# Visily Short Prompts (Under 4000 tokens each)

Copy each prompt separately. Generate in order 1-7.

---

## 1. Language Selection

```
Mobile app language selection screen. Light gray background #FAFAFA.

Top: Blue gradient square logo (100px, 24px radius) with sparkle ✨ emoji centered.

Title: "Choose your language" (20px bold).

Scrollable list of 12 language cards (full width, 56px height, 12px radius, white):
- 🇺🇸 English
- 🇸🇦 العربية (Arabic)
- 🇮🇳 हिन्दी (Hindi)
- 🇵🇰 اردو (Urdu)
- 🇧🇩 বাংলা (Bengali)
- 🇮🇩 Bahasa Indonesia
- 🇲🇾 Bahasa Melayu
- 🇹🇷 Türkçe
- 🇺🇿 O'zbek
- 🇫🇷 Français
- 🇪🇸 Español
- 🇩🇪 Deutsch

Each card: Flag emoji left + language name. Selected card: light blue tint, blue border (#2196F3), blue checkmark circle on right.

Bottom (sticky): Blue button "Continue" (56px height, 16px radius, #2196F3).

Style: Clean, minimal. Cards have subtle shadow, 8px gap between cards.
```

---

## 2. Welcome Screen

```
Mobile app welcome/intro screen. Light background #FAFAFA.

Top: Large circle (200px) with sparkle ✨ emoji + "TaskTrakr" text in blue #2196F3.

"Welcome" headline (32px bold) + subtitle "Turn your goals into achievable daily tasks with AI".

Four feature rows with emoji icons in blue-tinted squares (44px):
- 🎯 Set goals in your own words
- 🤖 AI creates your daily plan
- ✅ Track progress every day
- 🌍 Available in 12 languages

Bottom: Blue button "Get Started" with arrow (56px, #2196F3).

Style: Inspiring, clean whitespace, centered content.
```

---

## 3. Dashboard

```
Mobile app home dashboard for goal tracking.

Header: Sparkle ✨ + "TaskTrakr" title left, gear icon right.

"Today's Tasks" section with "1/2" green badge:

Task card 1 (white, 16px radius, shadow):
- Empty checkbox (28px, gray border)
- "Read chapters 3-4" title
- Blue pill "📚 Read 4 Books" + "30 min" + orange "🔥 4" streak badge

Task card 2 (light green tint, green border):
- Green filled checkbox with checkmark
- "Run 2K" strikethrough text
- "🏃 Run 5K" pill + "🔥 12"

"My Goals" section - 2x2 grid:
- Card 1: 📚 icon, "Read 4 Books", 60% blue progress bar
- Card 2: 🏃 icon, "Run 5K", 80% progress bar
- Add card: Dashed border, + icon, "Add Goal"

Blue FAB bottom-right: "+ New Goal"

Colors: Primary #2196F3, Success #4CAF50, Orange #FF9800, Background #FAFAFA.
```

---

## 4. Goal Creation

```
Mobile app goal creation form.

Header: Back arrow + "New Goal" title.

"What do you want to achieve?" label.
Large text input (white, 16px radius, 4 lines): Placeholder "Example: I want to read 4 books this month..."

"Duration" label.
Chip row: 7d, 14d, 30d (selected/blue), 60d, 90d. Selected chip is blue with white text.

"Category (optional)" label.
Emoji chips in 2 rows:
🏃 Fitness, 📚 Learning, 🌙 Ramadan, 🧘 Wellness
🎨 Creative, 💰 Financial, 💼 Career, ✨ Other

Bottom: Blue button "✨ Generate Plan" (56px, #2196F3). Disabled state at 30% opacity.

Helper text: "AI will create a personalized daily plan for you"

Style: Clean form, 20px padding, white input cards with shadow.
```

---

## 5. AI Loading

```
Mobile app loading screen, centered layout.

Center: Animated loading indicator
- Outer ring (140px) with blue gradient sweep
- Inner circle (100px) with sparkle ✨ emoji

Below: "Creating your personalized plan..." text (20px).

Progress bar (200px wide, 6px height, blue fill at 60%).

"Creating 30 daily tasks" subtitle in gray.

Card at bottom: "Your goal:" label + goal text preview.

"Cancel" text button at very bottom.

Colors: Primary #2196F3, Background #FAFAFA.
Style: Calming, centered, minimal.
```

---

## 6. Goal Detail

```
Mobile app goal detail screen.

Header: Back arrow + 📚 emoji + "Read 4 Books" + 3-dot menu.

Circular progress ring (120px, 10px stroke):
- 60% filled in blue #2196F3
- Center: "60%" bold + "Complete"
Below: "18 of 30 days"

Stats row:
- 🔥 "4" orange + "Current Streak"
- Divider
- 🏆 "7" green + "Best Streak"

"Today - Day 19" section:
Task tile with blue border (today indicator):
- Day badge "19" (blue bg, white text)
- "Read chapters 7-8" + "30 min"
- Empty checkbox

"Upcoming" section:
- Day 20: "Read chapters 9-10"
- Day 21: "Finish Book 2" + ⭐ milestone badge
- Day 22: "😴 Rest Day" (gray)

"Completed" section with "18/30" green badge:
- Day 17, 18 tiles with green checkmarks

Colors: #2196F3 blue, #4CAF50 green, #FF9800 orange.
```

---

## 7. Settings

```
Mobile app settings screen.

Header: Back arrow + "Settings" title.

"Language" section:
Tile (white, 12px radius): Globe icon (blue bg) + "Language" + "English" value + chevron

"Appearance" section:
Tile: Palette icon (orange bg) + "Theme" + "System" + chevron

"About" section:
- Tile: Info icon (purple bg) + "About TaskTrakr" + chevron
- Tile: Shield icon (green bg) + "Privacy Policy" + chevron
- Tile: Help icon (green bg) + "Help & Support" + chevron

Green card (16px radius, green tint):
Lock icon + "Your data stays private" title
"All your data is stored locally. We don't collect personal information."

Bottom center: "TaskTrakr v1.0.0" gray text.

Style: Standard settings pattern, 20px padding, tiles have subtle shadow.
```

---

## Style Reference (Apply to All)

```
Colors:
- Primary: #2196F3
- Success: #4CAF50
- Warning: #FF9800
- Background: #FAFAFA
- Cards: #FFFFFF
- Text: #212121 / #757575

Dimensions:
- Screen padding: 20px
- Card radius: 16px
- Card padding: 16px
- Button height: 56px
- Checkbox: 28x28px
- Icon containers: 44-48px square
```
