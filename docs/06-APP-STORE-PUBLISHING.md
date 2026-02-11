# App Store Publishing Guide

This guide covers the complete process for publishing TaskTrakr to Google Play Store and Apple App Store.

---

## Progress Summary

### Google Play Store
| Step | Description | Status |
|------|-------------|--------|
| 1 | Create Developer Account | ⬜ Pending |
| 2 | Generate Signing Key | ✅ Completed |
| 3 | Configure Gradle Signing | ✅ Completed |
| 4 | Update App Configuration | ✅ Completed |
| 5 | Build Release Bundle | ✅ Completed |
| 6-11 | Play Console Setup & Submission | ⬜ Pending |

### Apple App Store
| Step | Description | Status |
|------|-------------|--------|
| 1 | Enroll in Developer Program | ⬜ Pending |
| 2 | Configure Xcode Project | 🔶 Partial (Bundle ID done, signing pending) |
| 3 | Update App Information | ✅ Completed |
| 4 | Privacy Descriptions | ✅ Completed |
| 5-10 | App Store Connect & Submission | ⬜ Pending |

---

## Table of Contents

1. [Pre-Publishing Checklist](#pre-publishing-checklist)
2. [Google Play Store](#google-play-store)
3. [Apple App Store](#apple-app-store)
4. [Store Listing Assets](#store-listing-assets)
5. [Launch Timeline](#launch-timeline)

---

## Current Configuration

### Google Play Store (Android)

| Setting | Value |
|---------|-------|
| Application ID | `com.tasktrakr.app` |
| Version Name | `1.0.0` |
| Version Code | `1` |
| Min SDK | 21 (Android 5.0) |
| Target SDK | 34 (Android 14) |
| Keystore | `android/upload-keystore.jks` |
| App Bundle | `build/app/outputs/bundle/release/app-release.aab` |

### Apple App Store (iOS)

| Setting | Value |
|---------|-------|
| Bundle ID | `com.tasktrakr.app` |
| Display Name | `TaskTrakr` |
| Version | From `pubspec.yaml` (1.0.0) |
| Min iOS | 13.0 |

### Critical Files (Back these up!)

| File | Purpose | In .gitignore |
|------|---------|---------------|
| `android/upload-keystore.jks` | Android signing key - cannot update app without it | Yes |
| `android/key.properties` | Keystore passwords | Yes |

---

## Pre-Publishing Checklist

Before submitting to either store, ensure:

- [ ] App runs without crashes on release builds
- [ ] All features work as expected
- [ ] App icon is set correctly
- [x] App name and bundle ID are finalized (`com.tasktrakr.app`)
- [ ] Privacy policy is hosted on a public URL
- [ ] Support email is ready
- [ ] All test/debug code is removed
- [ ] Analytics and crash reporting are configured
- [ ] Localization is complete (English + Arabic)

### Flutter Release Checks

```bash
# Analyze code for issues
flutter analyze

# Run all tests
flutter test

# Check for outdated packages
flutter pub outdated
```

---

## Google Play Store

### Step 1: Create Developer Account

- [ ] Go to [Google Play Console](https://play.google.com/console)
- [ ] Sign in with a Google account
- [ ] Pay the one-time **$25 USD** registration fee
- [ ] Complete identity verification (24-48 hours for individuals)

### Step 2: Generate Signing Key - COMPLETED

The upload keystore has been generated at `android/upload-keystore.jks`.

```bash
# Already done - DO NOT run again (will overwrite existing key)
# keytool -genkey -v -keystore android/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### Step 3: Configure Signing in Gradle - COMPLETED

The signing configuration is set up in:
- `android/key.properties` - Contains keystore credentials
- `android/app/build.gradle.kts` - Configured for release signing

Both files are in `.gitignore` to prevent accidental commits.

### Step 4: Update App Configuration - COMPLETED

Current configuration in `android/app/build.gradle.kts`:

```kotlin
android {
    namespace = "com.tasktrakr.app"

    defaultConfig {
        applicationId = "com.tasktrakr.app"
        minSdk = 21
        targetSdk = 34
        versionCode = flutter.versionCode  // From pubspec.yaml
        versionName = flutter.versionName  // From pubspec.yaml
    }
}
```

### Step 5: Build Release Bundle - COMPLETED

The release App Bundle has been built:

```bash
# To rebuild:
flutter clean && flutter pub get && flutter build appbundle --release
```

**Output**: `build/app/outputs/bundle/release/app-release.aab` (43.7MB)

### Step 6: Create App in Play Console

- [ ] Click **"Create app"**
- [ ] Fill in:
  - App name: `TaskTrakr`
  - Default language: `English (United States)`
  - App or game: `App`
  - Free or paid: `Free`
- [ ] Accept Developer Program Policies

### Step 7: Complete Store Listing

Navigate to **Grow > Store presence > Main store listing**:

| Field | Content | Status |
|-------|---------|--------|
| App name | TaskTrakr | [ ] |
| Short description | AI-powered goal & habit tracking (max 80 chars) | [ ] |
| Full description | Detailed app description (max 4000 chars) | [ ] |
| App icon | 512x512 PNG | [ ] |
| Feature graphic | 1024x500 PNG | [ ] |
| Screenshots | Min 2 phone screenshots | [ ] |

Upload required graphics (see [Store Listing Assets](#store-listing-assets)).

### Step 8: Complete App Content

Navigate to **Policy > App content** and complete:

- [ ] **Privacy policy**: URL to your hosted privacy policy
- [ ] **Ads**: Declare if your app contains ads (TaskTrakr: No ads)
- [ ] **App access**: No login required for TaskTrakr
- [ ] **Content ratings**: Complete IARC questionnaire
- [ ] **Target audience**: Select age groups (13+ recommended)
- [ ] **News apps**: Not applicable
- [ ] **Data safety**: Declare data collection practices

#### Data Safety for TaskTrakr

Since TaskTrakr stores data locally only:
- Data collected: Minimal (user preferences, goals)
- Data shared: None
- Data encrypted: Yes (if using encrypted Hive boxes)
- Data deletion: Users can delete via app settings or uninstall

### Step 9: Set Up Testing Tracks

| Track | Purpose | Review Time | Max Testers |
|-------|---------|-------------|-------------|
| Internal | Quick testing | Instant | 100 |
| Closed | Beta testing | 1-3 days | Unlimited (invite) |
| Open | Public beta | 1-3 days | Unlimited |
| Production | Full release | 1-7 days | Everyone |

**Recommended flow**: Internal → Closed → Production

### Step 10: Upload and Submit

- [ ] Go to **Release > Testing > Internal testing**
- [ ] Click **"Create new release"**
- [ ] Upload `build/app/outputs/bundle/release/app-release.aab`
- [ ] Add release notes
- [ ] Click **"Review release"** → **"Start rollout"**

### Step 11: Production Release

After successful testing:

- [ ] Go to **Release > Production**
- [ ] Create new release
- [ ] Add the tested app bundle
- [ ] Choose rollout percentage (start with 20%)
- [ ] Submit for review

**Review timeline**: 1-3 days typical, up to 7 days for new apps.

---

## Updating the App

For future releases:

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # versionName+versionCode
   ```

2. Rebuild the App Bundle:
   ```bash
   flutter clean && flutter pub get && flutter build appbundle --release
   ```

3. Upload new bundle to Play Console and submit for review

---

## Apple App Store

### Current iOS Configuration

| Setting | Value |
|---------|-------|
| Bundle ID | `com.tasktrakr.app` |
| Display Name | `TaskTrakr` |
| Version | From `pubspec.yaml` (1.0.0) |
| Min iOS | 13.0 |
| CocoaPods | Installed (1.16.2) |

### Step 1: Enroll in Apple Developer Program

- [ ] Go to [Apple Developer](https://developer.apple.com/programs/)
- [ ] Click **"Enroll"**
- [ ] Sign in with Apple ID
- [ ] Pay **$99 USD/year** fee
- [ ] Complete enrollment (can take 24-48 hours)

### Step 2: Configure Xcode Project - PARTIALLY COMPLETED ✅

**Completed:**
- ✅ Bundle ID updated to `com.tasktrakr.app`
- ✅ CocoaPods installed (v1.16.2)

**Remaining (requires Apple Developer account):**

Open `ios/Runner.xcworkspace` in Xcode:

- [ ] Select **Runner** project in navigator
- [ ] Select **Runner** target
- [ ] Go to **Signing & Capabilities** tab
- [ ] Sign in with your Apple ID
- [ ] Select your Team from the dropdown
- [ ] Xcode will automatically create provisioning profiles

### Step 3: Update App Information - COMPLETED ✅

Current `ios/Runner/Info.plist` configuration:

```xml
<key>CFBundleName</key>
<string>TaskTrakr</string>

<key>CFBundleDisplayName</key>
<string>TaskTrakr</string>

<key>CFBundleVersion</key>
<string>$(FLUTTER_BUILD_NUMBER)</string>  <!-- From pubspec.yaml -->

<key>CFBundleShortVersionString</key>
<string>$(FLUTTER_BUILD_NAME)</string>  <!-- From pubspec.yaml -->
```

### Step 4: Privacy Descriptions - COMPLETED ✅

TaskTrakr uses notifications. The notification permission is handled by iOS system prompts.

**Not needed for TaskTrakr:**
- Camera access (not used)
- Photo library (not used)
- Location (not used)

### Step 5: Create App Store Connect Record

- [ ] Go to [App Store Connect](https://appstoreconnect.apple.com)
- [ ] Click **"My Apps"** → **"+"** → **"New App"**
- [ ] Fill in:
  - Platform: iOS
  - Name: TaskTrakr
  - Primary language: English (U.S.)
  - Bundle ID: `com.tasktrakr.app`
  - SKU: `tasktrakr-ios-001` (internal reference)
  - User Access: Full Access

### Step 6: Build and Archive

**Prerequisites:** Must have Apple Developer account and Xcode signing configured.

```bash
# Clean and get dependencies
flutter clean && flutter pub get

# Build iOS release
flutter build ios --release
```

Then in Xcode:

- [ ] Open `ios/Runner.xcworkspace`
- [ ] Select **Any iOS Device** as build target
- [ ] Go to **Product > Archive**
- [ ] Wait for archive to complete
- [ ] In Organizer, click **"Distribute App"**
- [ ] Select **"App Store Connect"**
- [ ] Follow prompts to upload

### Step 7: Complete App Store Listing

In App Store Connect, navigate to your app:

#### App Information
- Category: Productivity or Health & Fitness
- Content Rights: Declare if using third-party content
- Age Rating: Complete questionnaire

#### Pricing and Availability
- Price: Free
- Availability: Select countries

#### App Privacy
Answer questions about data collection:
- Data types collected
- Data linked to user
- Data used for tracking

For TaskTrakr (local-only storage):
- Most categories will be "No" since data stays on device

### Step 8: Prepare Version Information

| Field | Content |
|-------|---------|
| Screenshots | iPhone 6.7", 6.5", 5.5" (required) |
| iPad Screenshots | 12.9" (if supporting iPad) |
| App Preview | Optional video |
| Description | Full app description |
| Keywords | Comma-separated (max 100 chars total) |
| Support URL | Link to support page |
| Marketing URL | Optional website link |
| Version | 1.0.0 |
| Copyright | © 2026 Your Company |

### Step 9: Submit for Review

1. Select the build uploaded from Xcode
2. Answer export compliance questions
3. Answer content rights questions
4. Add review notes (login credentials if needed)
5. Click **"Submit for Review"**

**Review timeline**: 24-48 hours typical, can be faster or up to 7 days.

### Step 10: Handle Review Feedback

If rejected:
1. Read rejection reason in Resolution Center
2. Fix the issues
3. Upload new build
4. Resubmit

Common rejection reasons:
- Crashes or bugs
- Incomplete functionality
- Placeholder content
- Missing privacy policy
- Guideline violations

---

## Store Listing Assets

### Required Graphics

| Asset | Google Play | App Store |
|-------|-------------|-----------|
| App Icon | 512x512 PNG | 1024x1024 PNG |
| Feature Graphic | 1024x500 PNG | N/A |
| Phone Screenshots | Min 2, 16:9 or 9:16 | 6.7", 6.5", 5.5" sizes |
| Tablet Screenshots | Optional | 12.9" (if iPad) |

### Screenshot Specifications

#### Google Play
- JPEG or PNG (24-bit, no alpha)
- Min: 320px, Max: 3840px
- Aspect ratio: 16:9 or 9:16

#### App Store (Required sizes)
| Device | Size (Portrait) |
|--------|-----------------|
| iPhone 6.7" | 1290 x 2796 |
| iPhone 6.5" | 1284 x 2778 or 1242 x 2688 |
| iPhone 5.5" | 1242 x 2208 |
| iPad 12.9" | 2048 x 2732 |

### Screenshot Content Tips

1. **Show key features**: Dashboard, goal creation, AI planning
2. **Add captions**: Overlay text explaining features
3. **Localize**: Create Arabic versions for Arabic store listings
4. **Highlight Ramadan mode**: For Islamic audience appeal
5. **Use real content**: Avoid lorem ipsum or placeholder data

### Recommended Screenshots (6 screens)

1. Dashboard with today's tasks
2. Goal creation flow
3. AI-generated plan view
4. Progress tracking with streaks
5. Ramadan mode features
6. Settings/customization options

---

## Launch Timeline

### For Ramadan 2026 Launch (Feb 28)

| Date | Milestone |
|------|-----------|
| Feb 1 | Complete all development, begin testing |
| Feb 7 | Finalize store listing assets |
| Feb 10 | Submit to internal testing (both platforms) |
| Feb 14 | Submit to closed/TestFlight testing |
| Feb 18 | Fix any issues from beta feedback |
| Feb 21 | Submit to production review |
| Feb 25 | Expected approval (buffer for rejections) |
| Feb 28 | Ramadan begins - app live! |

### Post-Launch Tasks

- [ ] Monitor crash reports (Firebase Crashlytics / Xcode Organizer)
- [ ] Respond to user reviews within 24 hours
- [ ] Track key metrics (downloads, retention, engagement)
- [ ] Use staged rollout for updates
- [ ] Plan post-Ramadan update with user feedback

---

## Troubleshooting

### Google Play

| Issue | Solution |
|-------|----------|
| "App signing certificate mismatch" | Use Play App Signing, upload new key |
| "Target API level" warning | Update `targetSdkVersion` to 34+ |
| "64-bit requirement" | Flutter handles this by default |
| Rejection for metadata | Check for keyword stuffing, misleading info |

### App Store

| Issue | Solution |
|-------|----------|
| "Missing compliance" | Answer export compliance in submission |
| "Invalid binary" | Check Xcode build settings, re-archive |
| "Metadata rejected" | Update screenshots, description per feedback |
| "Guideline 4.3" (spam) | Ensure app has unique value proposition |

---

## Quick Commands Reference

### Android (Google Play)

```bash
# Build release App Bundle
flutter clean && flutter pub get && flutter build appbundle --release

# Output location
# build/app/outputs/bundle/release/app-release.aab
```

### iOS (App Store)

```bash
# Build iOS release (requires Apple Developer account + Xcode signing)
flutter clean && flutter pub get && flutter build ios --release

# Then open in Xcode for archiving
open ios/Runner.xcworkspace
# Product > Archive > Distribute App > App Store Connect
```

### Version Updates

Update `pubspec.yaml` before each release:
```yaml
version: 1.0.1+2  # Format: versionName+versionCode
```

---

## Resources

- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect/)
- [Flutter Deployment Docs](https://docs.flutter.dev/deployment)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Google Play Policy Center](https://play.google.com/about/developer-content-policy/)
