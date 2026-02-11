# Screen 1: Language Selection (Onboarding)

## AI Design Prompt

```
Mobile app onboarding screen for selecting language. Clean, minimal design.

LAYOUT (top to bottom):
- Centered app logo at top (100x100px): Blue gradient square with rounded corners (24px radius), containing a sparkle/star emoji icon
- 32px spacing
- Title text centered: "Choose your language" (20px, semibold)
- 24px spacing
- Scrollable list of 12 language selection cards, full width with 20px horizontal padding:

  Each card:
  - Height: 56px
  - White background, 12px rounded corners
  - Left: Flag emoji (24px)
  - Center: Language name (16px, medium weight)
  - Right: Circular checkmark (24px) when selected - blue background, white check icon
  - Selected state: Light blue background tint (#2196F3 at 10%), blue 2px border
  - Unselected state: White background, subtle shadow
  - 8px gap between cards

  Languages (in order):
  1. 🇺🇸 English
  2. 🇸🇦 العربية (Arabic)
  3. 🇮🇳 हिन्दी (Hindi)
  4. 🇵🇰 اردو (Urdu)
  5. 🇧🇩 বাংলা (Bengali)
  6. 🇮🇩 Bahasa Indonesia (Indonesian)
  7. 🇲🇾 Bahasa Melayu (Malay)
  8. 🇹🇷 Türkçe (Turkish)
  9. 🇺🇿 O'zbek (Uzbek)
  10. 🇫🇷 Français (French)
  11. 🇪🇸 Español (Spanish)
  12. 🇩🇪 Deutsch (German)

- Sticky bottom area:
  - 16px top padding with subtle top shadow
  - Continue button:
    - Full width minus 40px total padding
    - Height: 56px
    - Blue background (#2196F3)
    - White text "Continue" (18px, semibold)
    - 16px rounded corners
    - Disabled state: 30% opacity when no language selected
  - 32px bottom padding (safe area)

COLORS:
- Background: #FAFAFA (light gray)
- Primary blue: #2196F3
- Card background: #FFFFFF
- Text primary: #212121
- Text secondary: #757575

STYLE:
- Modern, clean aesthetic
- Subtle shadows on cards (0 2px 8px rgba(0,0,0,0.08))
- Scrollable list allows for all 10 languages
- Friendly and welcoming feel
```

## Screen Purpose
First screen users see when opening the app. Sets the language for the entire app experience. Must feel welcoming and simple.

## User Flow
Language Selection → Welcome Screen → Dashboard

## Supported Languages (12)

| Language | Native Name | Flag | RTL |
|----------|-------------|------|-----|
| English | English | 🇺🇸 | No |
| Arabic | العربية | 🇸🇦 | Yes |
| Hindi | हिन्दी | 🇮🇳 | No |
| Urdu | اردو | 🇵🇰 | Yes |
| Bengali | বাংলা | 🇧🇩 | No |
| Indonesian | Bahasa Indonesia | 🇮🇩 | No |
| Malay | Bahasa Melayu | 🇲🇾 | No |
| Turkish | Türkçe | 🇹🇷 | No |
| Uzbek | O'zbek | 🇺🇿 | No |
| French | Français | 🇫🇷 | No |
| Spanish | Español | 🇪🇸 | No |
| German | Deutsch | 🇩🇪 | No |

## Key States
1. **Initial**: No language selected, Continue button disabled (30% opacity)
2. **Language selected**: Selected card has blue border + checkmark, button enabled
3. **Scrolled**: Top cards scroll under sticky header area

## Button Text by Language
| Language | Button Text |
|----------|-------------|
| English | Continue |
| Arabic | متابعة |
| Hindi | जारी रखें |
| Urdu | جاری رکھیں |
| Bengali | চালিয়ে যান |
| Indonesian | Lanjutkan |
| Malay | Teruskan |
| Turkish | Devam |
| Uzbek | Davom etish |
| French | Continuer |
| Spanish | Continuar |
| German | Weiter |

## Assets Needed
- App logo (sparkle emoji ✨ as placeholder)
- 12 flag emojis
- Checkmark icon (white, for selected state)
