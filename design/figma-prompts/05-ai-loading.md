# Screen 5: AI Loading Screen

## AI Design Prompt

```
Mobile app loading screen shown while AI generates a goal plan. Engaging animation-focused design.

LAYOUT (centered, full screen):

NO HEADER (immersive loading experience)

BODY (centered content, 32px horizontal padding):

1. ANIMATED LOADING INDICATOR (center of screen, upper area):
- Container: 160x160px
- Outer rotating ring:
  - 140px diameter
  - 3px stroke
  - Sweep gradient: transparent → blue 50% → blue 100% → blue 50% → transparent
  - Continuous rotation animation (8 seconds per revolution)

- Inner pulsing circle:
  - 100px diameter
  - Light blue fill (#2196F3 at 10%)
  - Pulse animation: scale 0.95 → 1.05 (1.5s, ease-in-out, repeat)
  - Center content:
    - Emoji 🌙 (40px) for Ramadan category
    - OR ✨ (40px) for other categories

2. LOADING MESSAGE (48px below indicator):
- Animated text that cycles through messages:
  - "Analyzing your goal..."
  - "Creating your personalized plan..."
  - "Distributing tasks across 30 days..."
  - "Adding rest days..."
  - "Final touches..."
- Text style: 20px, semibold, centered
- Crossfade animation between messages (500ms)

3. PROGRESS BAR (16px below message):
- Width: 200px, centered
- Height: 6px
- Background: Blue at 15%
- Fill: Blue (#2196F3), animated width based on message index (20%, 40%, 60%, 80%, 95%)
- Rounded ends (3px radius)

4. TASK COUNT (8px below progress bar):
- "Creating 30 daily tasks" (14px, gray, centered)

5. GOAL SUMMARY CARD (24px below, near bottom):
- White background, 12px rounded corners, gray border
- Padding: 16px
- Label: "Your goal:" (12px, gray)
- 4px spacing
- Goal text: User's input (16px, semibold, max 2 lines, ellipsis overflow)
- Example: "Complete reading the Quran this Ramadan"

6. CANCEL BUTTON (bottom area):
- Text button style (no background)
- "Cancel" (16px, gray)
- 32px bottom padding

COLORS:
- Background: #FAFAFA (light) or #121212 (dark)
- Primary: #2196F3
- Ramadan: #1B5E20 (use for indicator when Ramadan category)
- Text primary: #212121
- Text secondary: #757575
- Progress track: #2196F3 at 15%

ANIMATIONS (describe for developer):
1. Outer ring: Continuous clockwise rotation, 8s duration, linear
2. Inner circle: Scale pulse 0.95→1.05, 1.5s duration, ease-in-out, infinite
3. Message text: Crossfade every 2 seconds, cycle through 5 messages
4. Progress bar: Smooth width transition (300ms) when message changes

STYLE:
- Calming, reassuring
- Shows progress to reduce perceived wait time
- Engaging enough to watch for 3-5 seconds
- Ramadan version uses green accent instead of blue
```

## Arabic Version Notes
```
RTL layout:
- All text right-aligned (or centered, which works for both)
- Messages in Arabic:
  - "نحلل هدفك..."
  - "ننشئ خطتك المخصصة..."
  - "نوزع المهام على 30 يوم..."
  - "نضيف أيام الراحة..."
  - "اللمسات الأخيرة..."
- Task count: "إنشاء 30 مهمة يومية"
- Goal label: "هدفك:"
- Cancel: "إلغاء"
```

## Screen Purpose
Displayed while the app calls Gemini API to generate the goal plan. Manages user expectations and provides feedback.

## User Flow
Goal Creation (tap Generate) → **AI Loading** → Goal Detail (success) or Error state (failure)

## Timing
- Typical AI response: 2-5 seconds
- Messages cycle every 2 seconds
- Screen auto-navigates when API returns success

## Edge Cases
1. **API Timeout (>10s)**: Show "Taking longer than usual..." message
2. **API Failure**: Show error state with "Try Again" button
3. **User Cancels**: Return to Goal Creation with form data preserved
4. **Offline**: Skip to fallback template selection
