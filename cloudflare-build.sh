#!/bin/bash
# Local build script for Cloudflare Pages deployment
# Run this locally before deploying

set -e

echo "=== TaskTrakr PWA Build for Cloudflare Pages ==="

# Build web release
echo "Building web release with PWA support..."
flutter clean
flutter pub get
flutter build web --release --pwa-strategy offline-first

echo ""
echo "Build complete! Output in build/web/"
echo ""
echo "To deploy to Cloudflare Pages:"
echo "1. Go to your Cloudflare Pages project settings"
echo "2. Change build configuration:"
echo "   - Build command: (leave empty)"
echo "   - Build output directory: build/web"
echo "3. Or use 'npx wrangler pages deploy build/web --project-name=tasktrakr'"
echo ""

ls -la build/web/
