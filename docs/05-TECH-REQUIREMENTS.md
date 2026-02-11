# TaskTrakr Technical Requirements

> Load after: [00-MVP-PLAN.md](./00-MVP-PLAN.md)

## Platform Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS | 15.0+ |
| Android | 8.0 (API 26)+ |

---

## Tech Stack

```
MOBILE APP
├── Framework: Flutter 3.x
├── Language: Dart
├── State Management: Riverpod
├── Local Database: Hive
├── HTTP Client: Dio
├── Localization: flutter_localizations + intl
├── Hijri Calendar: hijri package
├── UUID: uuid package
└── UI: Material 3

BACKEND
├── AI Proxy: Cloudflare Worker
├── AI Provider: Google Gemini 1.5 Flash
└── Crash Reporting: Sentry (optional)

CI/CD
├── GitHub Actions
├── Fastlane (optional)
└── Codemagic (alternative)
```

---

## Flutter Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # Networking
  dio: ^5.4.0

  # Utilities
  uuid: ^4.2.1
  intl: ^0.18.1
  hijri: ^3.0.0

  # UI
  flutter_animate: ^4.3.0
  shimmer: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  hive_generator: ^2.0.1
  riverpod_generator: ^2.3.9
  flutter_lints: ^3.0.1
```

---

## Project Structure

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── api_constants.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── colors.dart
│   └── utils/
│       ├── date_utils.dart
│       └── validators.dart
│
├── data/
│   ├── models/
│   │   ├── stored_goal.dart
│   │   ├── stored_task.dart
│   │   └── user_preferences.dart
│   ├── repositories/
│   │   ├── goal_repository.dart
│   │   └── preferences_repository.dart
│   └── services/
│       ├── ai_service.dart
│       └── hive_service.dart
│
├── features/
│   ├── onboarding/
│   │   ├── screens/
│   │   └── widgets/
│   ├── dashboard/
│   │   ├── screens/
│   │   └── widgets/
│   ├── goal_creation/
│   │   ├── screens/
│   │   └── widgets/
│   ├── goal_detail/
│   │   ├── screens/
│   │   └── widgets/
│   └── settings/
│       ├── screens/
│       └── widgets/
│
├── l10n/
│   ├── app_en.arb
│   └── app_ar.arb
│
└── providers/
    ├── goals_provider.dart
    ├── tasks_provider.dart
    └── preferences_provider.dart
```

---

## Cloudflare Worker Setup

### 1. Create Worker

```bash
npm create cloudflare@latest tasktrakr-ai-proxy
cd tasktrakr-ai-proxy
```

### 2. Worker Code (src/index.js)

```javascript
export default {
  async fetch(request, env) {
    // CORS headers
    const corsHeaders = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, X-Device-Id',
    };

    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
    }

    if (request.method !== 'POST') {
      return new Response('Method not allowed', { status: 405 });
    }

    // Rate limiting
    const deviceId = request.headers.get('X-Device-Id');
    if (!deviceId) {
      return new Response(JSON.stringify({ error: 'Missing device ID' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    const rateLimitKey = `rate:${deviceId}:${new Date().toDateString()}`;
    const count = parseInt(await env.KV.get(rateLimitKey) || '0');

    if (count >= 5) {
      return new Response(JSON.stringify({
        error: true,
        message: 'Daily limit reached. Try again tomorrow.'
      }), {
        status: 429,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    // Increment counter
    await env.KV.put(rateLimitKey, String(count + 1), { expirationTtl: 86400 });

    // Forward to Gemini
    try {
      const body = await request.json();

      const geminiResponse = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${env.GEMINI_API_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(body)
        }
      );

      const data = await geminiResponse.json();

      return new Response(JSON.stringify(data), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    } catch (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }
  }
};
```

### 3. Deploy

```bash
# Add secrets
npx wrangler secret put GEMINI_API_KEY

# Create KV namespace for rate limiting
npx wrangler kv:namespace create "RATE_LIMIT"

# Deploy
npx wrangler deploy
```

### 4. wrangler.toml

```toml
name = "tasktrakr-ai-proxy"
main = "src/index.js"

[[kv_namespaces]]
binding = "KV"
id = "your-kv-namespace-id"
```

---

## Performance Requirements

| Metric | Target |
|--------|--------|
| App launch | < 2 seconds |
| AI generation | < 5 seconds |
| Task completion | < 100ms |
| Offline capability | All tracking works offline |

---

## Data Storage

All data stored locally via Hive:
- No server database
- No user accounts
- Data lost on uninstall (warn users)
- Future: Export/import JSON backup

---

## Localization Setup

### l10n/app_en.arb
```json
{
  "appTitle": "TaskTrakr",
  "todaysTasks": "Today's Tasks",
  "createGoal": "Create Goal",
  "generatePlan": "Generate Plan",
  "streak": "{count} day streak",
  "@streak": {
    "placeholders": {
      "count": {"type": "int"}
    }
  }
}
```

### l10n/app_ar.arb
```json
{
  "appTitle": "نية",
  "todaysTasks": "مهام اليوم",
  "createGoal": "إنشاء هدف",
  "generatePlan": "إنشاء خطة",
  "streak": "سلسلة {count} يوم",
  "@streak": {
    "placeholders": {
      "count": {"type": "int"}
    }
  }
}
```

---

## Security Considerations

1. **API Key Protection**: Never embed Gemini key in app; use Cloudflare proxy
2. **Rate Limiting**: 5 generations per device per day
3. **Input Validation**: Sanitize user input before sending to AI
4. **Content Filtering**: Reject harmful content (see safety doc)
5. **Local Storage**: Data encrypted by OS (iOS Keychain, Android Keystore)
