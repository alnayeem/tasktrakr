# Screen 2: Welcome Screen (Onboarding)

## AI Design Prompt

```
Mobile app welcome/intro screen for a goal tracking app called "TaskTrakr". Modern, inspiring design.

LAYOUT (top to bottom):
- 60px top padding
- Centered illustration area (200x200px):
  - Large circle with radial gradient (primary blue 20% opacity fading to 5%)
  - Inner decorative ring (160px diameter, 2px blue stroke at 30% opacity)
  - Center content: Sparkle emoji ✨ (48px) above app name "TaskTrakr" in blue (#2196F3), bold, 28px

- 48px spacing
- "Welcome" headline - 32px, bold, centered
- 16px spacing
- Subtitle: "Turn your goals into achievable daily tasks with AI" - 16px, gray (#757575), centered, line-height 1.5

- Flexible space (pushes features list to middle-lower area)

- Features list (left-aligned with 24px padding):
  Four feature rows, each with:
  - Icon container: 44x44px, light blue background (#2196F3 at 10%), 12px rounded corners
  - Icon inside: Emoji (22px)
  - 16px horizontal gap
  - Feature text: 16px, regular weight
  - 16px vertical spacing between rows

  Features:
  1. 🎯 "Set goals in your own words"
  2. 🤖 "AI creates your daily plan"
  3. ✅ "Track progress every day"
  4. 🌙 "Special Ramadan mode"

- Flexible space

- "Get Started" button:
  - Full width minus 48px padding
  - Height: 56px
  - Blue background (#2196F3)
  - White text "Get Started" (18px, semibold)
  - Right arrow icon after text
  - 16px rounded corners
  - Subtle shadow (0, 4px, 8px, blue at 30%)

- 32px bottom padding

COLORS:
- Background: #FAFAFA
- Primary: #2196F3
- Text dark: #212121
- Text gray: #757575
- Icon backgrounds: #2196F3 at 10% opacity

STYLE:
- Inspirational and motivating
- Clean whitespace
- Subtle animations implied (icon could pulse)
- Welcoming first impression
```

## Arabic Version Prompt Addition

```
For Arabic (RTL) version:
- All text right-aligned
- Feature list: icons on right, text on left
- "Get Started" button shows left arrow instead of right
- Text content:
  - Title: "مرحباً بك" (Welcome)
  - Subtitle: "حوّل أهدافك إلى مهام يومية قابلة للتحقيق باستخدام الذكاء الاصطناعي"
  - Features:
    1. 🎯 "حدد أهدافك بأي لغة"
    2. 🤖 "الذكاء الاصطناعي يخطط لك"
    3. ✅ "تتبع تقدمك يومياً"
    4. 🌙 "وضع رمضان الخاص"
  - Button: "ابدأ الآن"
```

## Screen Purpose
Introduces the app's value proposition after language selection. Builds excitement before user creates their first goal.

## User Flow
Language Selection → **Welcome Screen** → Goal Creation (first time) or Dashboard (returning)

## Key Elements
- App branding prominent
- Clear value props (4 features)
- Single clear CTA
- No distractions
