# Figma Setup Guide for TaskTrakr

How to ensure consistency when using AI-generated designs.

---

## Step 1: Create Color Styles in Figma

Before importing AI designs, create these color styles in Figma:

### Primary Colors
| Style Name | Hex | Usage |
|------------|-----|-------|
| `primary/default` | #2196F3 | Buttons, links, selected states |
| `primary/light` | #64B5F6 | Hover states, backgrounds |
| `primary/dark` | #1976D2 | Pressed states |

### Semantic Colors
| Style Name | Hex | Usage |
|------------|-----|-------|
| `success/default` | #4CAF50 | Completed, positive |
| `warning/default` | #FF9800 | Streaks, attention |
| `error/default` | #F44336 | Errors, destructive |
| `accent/green` | #1B5E20 | Ramadan mode / special modes |
| `accent/gold` | #FFD700 | Milestones, highlights |

### Neutral Colors
| Style Name | Hex | Usage |
|------------|-----|-------|
| `background/default` | #FAFAFA | Screen background |
| `surface/default` | #FFFFFF | Cards, inputs |
| `text/primary` | #212121 | Headlines, body |
| `text/secondary` | #757575 | Captions, hints |
| `divider/default` | #E0E0E0 | Borders, lines |

---

## Step 2: Create Text Styles

| Style Name | Size | Weight | Line Height |
|------------|------|--------|-------------|
| `heading/display` | 32px | Bold | 1.2 |
| `heading/h1` | 24px | SemiBold | 1.3 |
| `heading/h2` | 20px | SemiBold | 1.3 |
| `heading/h3` | 18px | SemiBold | 1.4 |
| `body/large` | 16px | Regular | 1.5 |
| `body/medium` | 14px | Regular | 1.5 |
| `body/small` | 12px | Regular | 1.4 |
| `label/default` | 14px | Medium | 1.4 |

---

## Step 3: Create Effect Styles

| Style Name | Properties |
|------------|------------|
| `shadow/subtle` | 0 2px 8px rgba(0,0,0,0.05) |
| `shadow/card` | 0 4px 12px rgba(0,0,0,0.08) |
| `shadow/elevated` | 0 8px 24px rgba(0,0,0,0.12) |

---

## Step 4: Create Base Components

Create these as Figma components before importing AI screens:

### Button Component
```
Frame: 335 x 56px (full width minus padding)
- Background: primary/default
- Border Radius: 16px
- Auto Layout: Center, 8px gap
- Children:
  - Text: "Button Label" (16px, SemiBold, White)

Variants:
- State: Default, Disabled
- Type: Primary, Secondary, Ramadan
```

### Card Component
```
Frame: Auto width/height
- Background: surface/default
- Border Radius: 16px
- Shadow: shadow/card
- Padding: 16px all sides
```

### Checkbox Component
```
Frame: 28 x 28px
- Border: 2px, divider/default
- Border Radius: 8px

Variants:
- State: Unchecked, Checked
- Checked shows: Fill primary/default, white checkmark icon
```

### Chip Component
```
Frame: Auto width
- Padding: 12px horizontal, 10px vertical
- Border Radius: 12px
- Border: 1.5px, divider/default

Variants:
- State: Unselected, Selected
- Selected: background primary/default @ 10%, border primary/default
```

---

## Step 5: Import AI Designs

1. Generate designs using prompts from `00-QUICK-PROMPTS.md`
2. Export from AI tool (Visily/Galileo → Figma export)
3. Import into your Figma file

---

## Step 6: Apply Consistent Styles

After importing, fix inconsistencies:

### Batch Replace Colors

1. Select a blue element that's wrong (e.g., #2095F2 instead of #2196F3)
2. Right-click → "Select all with same fill"
3. Apply your `primary/default` color style

### Batch Replace Text Styles

1. Select text that should be a heading
2. Right-click → "Select all with same font properties"
3. Apply your `heading/h2` text style

### Fix Border Radius

1. Select a card
2. In Properties panel, check border radius
3. If not 16px, fix and use "Select all with same" to batch update

---

## Step 7: Create Component Instances

Replace raw shapes with your components:

1. Select all buttons across screens
2. Delete them
3. Place instances of your Button component
4. Adjust text per screen

This ensures future changes update everywhere.

---

## Quick Fixes Checklist

| Issue | Fix |
|-------|-----|
| Colors slightly off | Batch replace with color styles |
| Shadows inconsistent | Apply effect styles |
| Button heights vary | Replace with Button component |
| Card radius varies | Select all, set to 16px |
| Fonts don't match | Apply text styles |
| Spacing inconsistent | Use Auto Layout with 8px increments |

---

## Figma Plugins That Help

| Plugin | Purpose |
|--------|---------|
| **Themer** | Batch swap colors across entire file |
| **Similayer** | Select similar layers across multiple frames |
| **Clean Document** | Remove unused styles |
| **Contrast** | Check accessibility of color combinations |
| **Stark** | Accessibility checker |

---

## Export for Development

When designs are finalized:

1. **Dev Mode**: Use Figma's Dev Mode to inspect values
2. **Export tokens**: Export colors/typography as JSON for Flutter
3. **Asset export**: Export icons at 1x, 2x, 3x for mobile

Your Flutter code in `lib/core/theme/colors.dart` should match these Figma color styles exactly.
