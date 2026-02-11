# TaskTrakr Design System Prompt

**Generate this FIRST before any screens. Use as reference for all subsequent designs.**

---

## Master Design System Prompt

```
Create a mobile app design system/component library for "TaskTrakr", an AI-powered goal and habit tracking app.

BRAND:
- App name: TaskTrakr (نية) - means "intention" in Arabic
- Logo: Sparkle emoji ✨ in a blue gradient rounded square
- Personality: Calm, motivating, focused, achievement-oriented
- Tagline: "Turn your goals into achievable daily tasks with AI"

COLOR TOKENS:
- primary: #2196F3 (blue)
- primary-light: #64B5F6
- primary-dark: #1976D2
- accent-green: #1B5E20 (dark green, used for Ramadan mode feature)
- accent-green-light: #4CAF50
- success: #4CAF50 (green)
- warning: #FF9800 (orange, for streaks)
- error: #F44336 (red)
- gold: #FFD700 (for special milestones and highlights)
- background: #FAFAFA
- surface: #FFFFFF
- text-primary: #212121
- text-secondary: #757575
- divider: #E0E0E0

TYPOGRAPHY (use system font or Inter):
- Display: 32px, Bold, line-height 1.2
- Headline: 24px, SemiBold, line-height 1.3
- Title Large: 20px, SemiBold
- Title Medium: 18px, SemiBold
- Title Small: 16px, SemiBold
- Body Large: 16px, Regular, line-height 1.5
- Body Medium: 14px, Regular
- Body Small: 12px, Regular
- Label: 14px, Medium
- Caption: 12px, Regular

SPACING SCALE:
- 4px, 8px, 12px, 16px, 20px, 24px, 32px, 48px

BORDER RADIUS:
- Small: 8px (checkboxes, small buttons)
- Medium: 12px (chips, inputs, tiles)
- Large: 16px (cards, modals)
- XLarge: 20px (pill buttons, badges)
- Full: 50% (circular avatars, icons)

SHADOWS:
- Subtle: 0 2px 8px rgba(0,0,0,0.05)
- Card: 0 4px 12px rgba(0,0,0,0.08)
- Elevated: 0 8px 24px rgba(0,0,0,0.12)

COMPONENTS TO CREATE:

1. BUTTONS:
   - Primary: Blue bg, white text, 56px height, 16px radius, full-width option
   - Secondary: White bg, blue border, blue text
   - Text: No background, blue text
   - Disabled: 30% opacity
   - Accent variant: Green (#1B5E20) for special modes (e.g., Ramadan)

2. CARDS:
   - Standard: White bg, 16px radius, subtle shadow, 16px padding
   - Task Card: Checkbox left, content center, badge right
   - Goal Card: Icon top, title middle, progress bar bottom
   - Banner Card: Gradient bg (for special mode banners like Ramadan)

3. INPUTS:
   - Text Field: White bg, gray border, 12px radius, 16px padding
   - Focused: Blue 2px border
   - Text Area: Multi-line, same styling

4. CHIPS:
   - Duration Chip: Unselected (white bg, gray border) / Selected (blue bg, white text)
   - Category Chip: Emoji + label, colored border when selected
   - Badge Chip: Small pill, colored background at 15%, colored text

5. CHECKBOXES:
   - Unchecked: 28x28px, gray 2px border, 8px radius
   - Checked: Blue or green fill, white checkmark icon
   - Task checkbox: Same but integrated into task card

6. PROGRESS INDICATORS:
   - Linear: 6px height, colored fill, gray track, rounded ends
   - Circular: 120px diameter for main, 10px stroke

7. NAVIGATION:
   - App Bar: 56px height, centered title, icon buttons
   - Back Arrow: Left for LTR, Right for RTL
   - Bottom Sheet: Handle bar, rounded top corners

8. LIST TILES:
   - Settings Tile: Icon container left, label center, value+chevron right
   - Day Plan Tile: Day number badge left, task content center, checkbox right

9. SPECIAL COMPONENTS:
   - Streak Badge: Fire emoji 🔥 + count, orange theme
   - Special Mode Banner: Gradient background, contextual icon, phase/progress info
   - Milestone Badge: Gold background, star emoji ⭐ (for achievements)

10. STATES:
    - Default, Hover, Pressed, Disabled, Selected, Completed

Create all components in both Light and Dark mode variants.
Show components at mobile width (375px).
```

---

## Component Reference Sheet

Use this exact specification when generating each screen:

### Buttons
| Type | Background | Text | Height | Radius |
|------|------------|------|--------|--------|
| Primary | #2196F3 | White | 56px | 16px |
| Accent (Ramadan mode) | #1B5E20 | White | 56px | 16px |
| Secondary | White | #2196F3 | 56px | 16px |
| Disabled | #2196F3 @ 30% | White @ 50% | 56px | 16px |

### Cards
| Type | Background | Radius | Padding | Shadow |
|------|------------|--------|---------|--------|
| Standard | White | 16px | 16px | 0 4px 12px 8% |
| Completed | #4CAF50 @ 10% | 16px | 16px | none |
| Today Highlight | White | 12px | 16px | + 2px blue border |

### Chips
| Type | Unselected | Selected |
|------|------------|----------|
| Duration | White bg, #E0E0E0 border | #2196F3 bg, white text |
| Category | White bg, #E0E0E0 border | Color @ 15% bg, color border, color text |

### Icons & Emojis (consistent sizing)
| Context | Size |
|---------|------|
| App bar | 24px |
| Card icon container | 48x48px container, 24px emoji |
| Inline emoji | 18-20px |
| Badge emoji | 12-14px |
| Logo emoji | 40-50px |

### Spacing Rules
| Element | Spacing |
|---------|---------|
| Screen horizontal padding | 20px |
| Card internal padding | 16px |
| Between cards | 12px |
| Section gap | 24-32px |
| Between chip/button and label | 8px |

---

## Consistency Checklist

Before finalizing any screen, verify:

- [ ] Colors match the token list exactly
- [ ] All cards use 16px radius
- [ ] All buttons are 56px height
- [ ] Checkboxes are 28x28px with 8px radius
- [ ] Screen padding is 20px horizontal
- [ ] Section headers are 16-18px semibold
- [ ] Emoji sizes are consistent (24px in containers, 18px inline)
- [ ] Shadows match the defined levels
- [ ] RTL layout mirrors correctly
- [ ] Ramadan mode elements use accent green (#1B5E20), not blue
