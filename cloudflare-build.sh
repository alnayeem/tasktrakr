#!/bin/bash
# Cloudflare Pages Build Script for Flutter Web

set -e

echo "=== TaskTrakr PWA Build for Cloudflare Pages ==="

# Check if Flutter is already available
if command -v flutter &> /dev/null; then
    echo "Flutter found in PATH"
    FLUTTER_CMD="flutter"
else
    echo "Installing Flutter..."
    git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter-sdk
    export PATH="$PATH:$(pwd)/flutter-sdk/bin"
    FLUTTER_CMD="flutter"

    # Disable analytics
    $FLUTTER_CMD config --no-analytics
fi

echo "Flutter version:"
$FLUTTER_CMD --version

echo "Getting dependencies..."
$FLUTTER_CMD pub get

echo "Building web release with PWA support..."
$FLUTTER_CMD build web --release --pwa-strategy offline-first

echo "Build complete! Output in build/web/"
ls -la build/web/
