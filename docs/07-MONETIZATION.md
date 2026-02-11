# TaskTrakr Monetization Strategy

> Load when implementing donation system (Post-MVP)

## Core Principle

**100% Free Forever** - All features free, no paywalls, no ads.

---

## Sustainability Model

| Option | Description |
|--------|-------------|
| Donations | Optional in-app support |
| Sponsorships | Ethical brand partnerships |
| Grants | Health/wellness foundations |
| Open Source | Community contributions |

---

## Donation System (Post-MVP)

### Design Philosophy

- **Never block features**
- **Non-intrusive** - No aggressive popups
- **Transparent** - Show what donations support
- **Gratitude, not guilt**

### Donation Entry Points

1. **Settings Page** - Always available "Support TaskTrakr"
2. **About Page** - "Free thanks to supporters"
3. **Goal Completion** - Subtle prompt (max once/month)
4. **App Anniversary** - Once per year

### Donation Tiers

| Tier | Amount | Name |
|------|--------|------|
| ☕ | $3-5 | Coffee |
| 🌙 | $10 | Supporter |
| ⭐ | $25 | Champion |
| 💎 | $50+ | Patron |

### Payment Options

| Platform | Method | Fee |
|----------|--------|-----|
| iOS | In-App Purchase | 15-30% |
| Android | Google Play Billing | 15-30% |
| Alternative | Ko-fi, GitHub Sponsors | 0-5% |

### UI Mockup

```
┌─────────────────────────────────────┐
│  ❤️ Support TaskTrakr                  │
├─────────────────────────────────────┤
│                                     │
│  TaskTrakr is free for everyone.       │
│                                     │
│  Your support helps us:             │
│  • Keep the app ad-free             │
│  • Pay for AI services              │
│  • Add new features                 │
│                                     │
│  ┌───────┐ ┌───────┐ ┌───────┐     │
│  │  $3   │ │  $10  │ │  $25  │     │
│  │  ☕   │ │  🌙   │ │  ⭐   │     │
│  └───────┘ └───────┘ └───────┘     │
│                                     │
│  ┌───────────────────────────────┐ │
│  │       💚 Support TaskTrakr       │ │
│  └───────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

### Prompt Rules

```dart
class DonationPromptRules {
  // Never show if:
  static const int minDaysBeforePrompt = 7;
  static const int minGoalsCompleted = 1;
  static const int daysBetweenPrompts = 30;
  static const int maxPromptsPerYear = 6;
  static const bool allowPermanentDismiss = true;
}
```

### Projected Revenue

| MAU | Donation Rate | Avg | Monthly |
|-----|---------------|-----|---------|
| 10K | 1% | $5 | $500 |
| 50K | 1.5% | $5 | $3,750 |
| 100K | 2% | $5 | $10,000 |

---

## Implementation Timeline

| Phase | Feature |
|-------|---------|
| MVP | No donations |
| Month 2 | Settings page support link |
| Month 3 | In-app purchases |
| Month 4 | Post-goal prompts |
| Month 6 | Transparency dashboard |
