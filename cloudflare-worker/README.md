# TaskTrakr AI Cloudflare Worker

This Cloudflare Worker proxies requests to the Gemini API, providing:
- API key protection (key stored securely in Cloudflare)
- Rate limiting (5 requests per device per day)
- CORS handling for mobile app requests

## Prerequisites

1. [Cloudflare account](https://dash.cloudflare.com/sign-up)
2. [Node.js](https://nodejs.org/) installed
3. [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/)

## Setup

### 1. Install Wrangler

```bash
npm install -g wrangler
```

### 2. Login to Cloudflare

```bash
wrangler login
```

### 3. Create KV Namespace for Rate Limiting

```bash
wrangler kv:namespace create "RATE_LIMIT"
```

Copy the output ID and update `wrangler.toml`:

```toml
kv_namespaces = [
  { binding = "RATE_LIMIT", id = "YOUR_ACTUAL_ID_HERE" }
]
```

### 4. Set Gemini API Key

Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey).

```bash
wrangler secret put GEMINI_API_KEY
# Paste your API key when prompted
```

### 5. Deploy

```bash
wrangler deploy
```

Your worker will be available at: `https://tasktrakr-ai.<your-subdomain>.workers.dev`

## Usage

### Request

```bash
curl -X POST https://tasktrakr-ai.your-subdomain.workers.dev \
  -H "Content-Type: application/json" \
  -H "X-Device-Id: unique-device-id" \
  -d '{
    "contents": [{
      "parts": [{"text": "Your prompt here"}]
    }],
    "generationConfig": {
      "responseMimeType": "application/json",
      "temperature": 0.7,
      "maxOutputTokens": 8192
    }
  }'
```

### Response Headers

- `X-RateLimit-Remaining`: Requests remaining today
- `X-RateLimit-Limit`: Daily limit (5)

### Error Responses

| Status | Message |
|--------|---------|
| 400 | Device ID required |
| 405 | Method not allowed |
| 429 | Daily limit reached |
| 500 | Internal server error |

## Local Development

```bash
wrangler dev
```

This starts a local server for testing.

## Rate Limiting

- Each device gets 5 AI generations per day
- Limit resets at midnight UTC
- Device ID should be a persistent unique identifier (e.g., UUID stored in app)

## Cost

- Cloudflare Workers: Free tier includes 100,000 requests/day
- Gemini 1.5 Flash: Free tier includes 1M tokens/month
- KV Storage: Free tier includes 100,000 reads/day

For most apps, this will cost $0/month.
