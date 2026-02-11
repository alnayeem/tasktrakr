# Screen 7: Settings Screen

## AI Design Prompt

```
Mobile app settings screen with organized preference sections. Clean, standard settings pattern.

HEADER:
- Back arrow left
- Title: "Settings" (20px, semibold, centered)

BODY (scrollable, 20px padding):

1. LANGUAGE SECTION:
- Section label: "Language" (16px, semibold)
- 12px spacing
- Settings tile:
  - White background, 12px rounded, subtle shadow
  - Padding: 16px
  - Left: Icon container (40x40px, blue at 10%, 10px rounded)
    - Globe icon 🌐 (22px, blue)
  - 16px gap
  - Center: "Language" (16px, medium)
  - Right: Current value "English" (14px, blue, medium) + chevron icon

2. APPEARANCE SECTION (32px top margin):
- Section label: "Appearance" (16px, semibold)
- 12px spacing
- Settings tile:
  - Same structure as language tile
  - Left: Palette icon 🎨 (orange #FF5722)
  - Center: "Theme"
  - Right: "System" + chevron

3. ABOUT SECTION (32px top margin):
- Section label: "About" (16px, semibold)
- 12px spacing

- Tile 1: About TaskTrakr
  - Info icon ℹ️ (purple #9C27B0)
  - "About TaskTrakr"
  - Chevron right

- 8px spacing

- Tile 2: Privacy Policy
  - Shield icon 🛡️ (green #1B5E20)
  - "Privacy Policy"
  - Chevron right

- 8px spacing

- Tile 3: Help & Support
  - Help icon ❓ (green #4CAF50)
  - "Help & Support"
  - Chevron right

4. PRIVACY NOTICE CARD (32px top margin):
- Full width, 12px rounded corners
- Green background (#4CAF50 at 10%)
- Green border (#4CAF50 at 20%)
- Padding: 16px
- Left: Lock icon 🔒 (24px, green)
- 12px gap
- Right content:
  - Title: "Your data stays private" (14px, semibold, green)
  - 4px spacing
  - Body: "All your data is stored locally on your device. We don't collect any personal information." (13px, gray, line-height 1.4)

5. VERSION (24px top margin, centered):
- "TaskTrakr v1.0.0" (12px, gray at 50%)

BOTTOM SHEETS:

Language Selection Sheet:
- Handle bar at top (40px wide, 4px height, gray, centered)
- 16px padding top
- Title: "Select Language" (16px, semibold, centered)
- 16px spacing
- List items:
  - 🇺🇸 + "English" + checkmark (if selected)
  - 🇸🇦 + "العربية" + checkmark (if selected)
- Item height: 56px
- Checkmark: Blue (#2196F3)

Theme Selection Sheet:
- Same structure as language sheet
- Title: "Select Theme"
- List items:
  - Phone icon + "System Default"
  - Sun icon + "Light"
  - Moon icon + "Dark"

COLORS:
- Background: #FAFAFA
- Tiles: #FFFFFF
- Primary: #2196F3
- Icon colors: Various per section (see above)
- Privacy card: #4CAF50 theme
- Text primary: #212121
- Text secondary: #757575
- Chevron: #9E9E9E

STYLE:
- Standard iOS/Android settings pattern
- Grouped sections with labels
- Clear tap targets
- Privacy message builds trust
```

## Arabic Version Notes
```
RTL layout:
- Back arrow points right
- All labels right-aligned
- Chevrons point left
- Section labels:
  - "اللغة"
  - "المظهر"
  - "حول التطبيق"
- Tile labels:
  - "اللغة" → "العربية"
  - "المظهر" → "تلقائي"
  - "عن نية"
  - "سياسة الخصوصية"
  - "المساعدة والدعم"
- Privacy card:
  - Title: "بياناتك محفوظة"
  - Body: "كل بياناتك مخزنة على جهازك فقط. لا نجمع أي معلومات شخصية."
- Theme options: "تلقائي (النظام)", "فاتح", "داكن"
```

## Screen Purpose
App preferences including language, theme, and informational pages.

## User Flow
Dashboard (settings icon) → **Settings**
- Tap Language tile → Language bottom sheet
- Tap Theme tile → Theme bottom sheet
- Tap About → About dialog
- Tap Privacy → Privacy policy (web view or screen)
- Tap Support → Email compose or help page

## Data Persistence
- Language: Stored in UserPreferences (Hive)
- Theme: Stored in UserPreferences
- Changes apply immediately (no save button)
