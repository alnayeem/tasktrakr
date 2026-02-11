/**
 * TaskTrakr AI Cloudflare Worker
 *
 * Proxies requests to Gemini API with:
 * - API key protection (stored in env)
 * - Rate limiting (5 requests/day per device)
 * - CORS handling
 *
 * Deploy: wrangler deploy
 *
 * Required environment variables (set in Cloudflare dashboard):
 * - GEMINI_API_KEY: Your Gemini API key
 *
 * Required KV namespace binding:
 * - RATE_LIMIT: For storing rate limit counters
 */

const GEMINI_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

// Rate limiting configuration
const RATE_LIMIT_PER_DAY = 5;           // Max requests per device per day
const GLOBAL_RATE_LIMIT_PER_MINUTE = 10; // Max requests globally per minute (protect billing)
const MAX_REQUEST_SIZE = 50000;          // Max request body size in bytes

export default {
  async fetch(request, env, ctx) {
    // Handle CORS preflight
    if (request.method === 'OPTIONS') {
      return handleCORS();
    }

    // Only allow POST requests
    if (request.method !== 'POST') {
      return jsonResponse({ error: true, message: 'Method not allowed' }, 405);
    }

    try {
      // Check request size
      const contentLength = request.headers.get('Content-Length');
      if (contentLength && parseInt(contentLength, 10) > MAX_REQUEST_SIZE) {
        return jsonResponse({ error: true, message: 'Request too large' }, 413);
      }

      // Get device ID for rate limiting
      const deviceId = request.headers.get('X-Device-Id');
      if (!deviceId) {
        return jsonResponse({ error: true, message: 'Device ID required' }, 400);
      }

      // Validate device ID format (should be UUID-like)
      if (deviceId.length < 8 || deviceId.length > 64) {
        return jsonResponse({ error: true, message: 'Invalid device ID' }, 400);
      }

      // Check global rate limit (protect billing)
      const globalLimitResult = await checkGlobalRateLimit(env);
      if (globalLimitResult.limited) {
        return jsonResponse({
          error: true,
          message: 'Service is busy. Please try again in a moment.',
        }, 503);
      }

      // Check per-device rate limit
      const rateLimitResult = await checkRateLimit(deviceId, env);
      if (rateLimitResult.limited) {
        return jsonResponse({
          error: true,
          message: 'Daily limit reached. Try again tomorrow.',
          remaining: 0,
        }, 429);
      }

      // Get request body
      const body = await request.json();

      // Call Gemini API
      const geminiResponse = await fetch(`${GEMINI_URL}?key=${env.GEMINI_API_KEY}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(body),
      });

      // Get response data
      const responseData = await geminiResponse.json();

      // Increment rate limit counter on success
      if (geminiResponse.ok) {
        await incrementRateLimit(deviceId, env);
      }

      // Return response with CORS headers
      return jsonResponse(responseData, geminiResponse.status, {
        'X-RateLimit-Remaining': String(rateLimitResult.remaining - 1),
        'X-RateLimit-Limit': String(RATE_LIMIT_PER_DAY),
      });

    } catch (error) {
      console.error('Worker error:', error);
      return jsonResponse({
        error: true,
        message: 'Internal server error',
      }, 500);
    }
  },
};

/**
 * Check global rate limit (protect billing from abuse)
 */
async function checkGlobalRateLimit(env) {
  const now = new Date();
  const minuteKey = `global:${now.toISOString().slice(0, 16)}`; // YYYY-MM-DDTHH:MM

  try {
    const count = await env.RATE_LIMIT.get(minuteKey);
    const currentCount = count ? parseInt(count, 10) : 0;

    if (currentCount >= GLOBAL_RATE_LIMIT_PER_MINUTE) {
      return { limited: true };
    }

    // Increment global counter
    await env.RATE_LIMIT.put(minuteKey, String(currentCount + 1), {
      expirationTtl: 120, // 2 minutes TTL
    });

    return { limited: false };
  } catch (error) {
    console.error('Global rate limit error:', error);
    return { limited: false }; // Allow on error
  }
}

/**
 * Check if device has exceeded rate limit
 */
async function checkRateLimit(deviceId, env) {
  const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD
  const key = `rate:${deviceId}:${today}`;

  try {
    const count = await env.RATE_LIMIT.get(key);
    const currentCount = count ? parseInt(count, 10) : 0;

    return {
      limited: currentCount >= RATE_LIMIT_PER_DAY,
      remaining: Math.max(0, RATE_LIMIT_PER_DAY - currentCount),
      count: currentCount,
    };
  } catch (error) {
    console.error('Rate limit check error:', error);
    // On error, allow the request
    return { limited: false, remaining: RATE_LIMIT_PER_DAY, count: 0 };
  }
}

/**
 * Increment rate limit counter for device
 */
async function incrementRateLimit(deviceId, env) {
  const today = new Date().toISOString().split('T')[0];
  const key = `rate:${deviceId}:${today}`;

  try {
    const count = await env.RATE_LIMIT.get(key);
    const currentCount = count ? parseInt(count, 10) : 0;

    // Set with TTL of 24 hours (86400 seconds)
    await env.RATE_LIMIT.put(key, String(currentCount + 1), {
      expirationTtl: 86400,
    });
  } catch (error) {
    console.error('Rate limit increment error:', error);
  }
}

/**
 * Create JSON response with CORS headers
 */
function jsonResponse(data, status = 200, extraHeaders = {}) {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, X-Device-Id',
      ...extraHeaders,
    },
  });
}

/**
 * Handle CORS preflight request
 */
function handleCORS() {
  return new Response(null, {
    status: 204,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, X-Device-Id',
      'Access-Control-Max-Age': '86400',
    },
  });
}
