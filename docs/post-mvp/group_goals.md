# Group Goals & Shared Plans - Post-MVP PRD

> **Post-MVP Feature:** Collaborative goal tracking for families and friends
> 
> **Status:** Planning Phase
> 
> **Dependencies:** MVP must be complete and stable before implementation

---

## Executive Summary

Transform TaskTrakr from a solo goal-tracking app into a collaborative platform where users can share their goals with others. This feature enables:

- **Share Any Goal:** Start with a regular individual goal, then share it with family/friends
- **Accept & Track:** Others can accept shared goals as their own
- **Aggregate Stats:** When multiple people have the same goal, see overall progress numbers (daily/weekly totals)
- **Easy Sharing:** Share via links, text, email, or in-app
- **Privacy First:** Users control what stats are visible to others

**Key Value Proposition:** "Start alone. Share when ready. See progress together."

**Core Philosophy:** Goals start as personal. Sharing is optional and organic. No upfront commitment to "group" vs "individual" - just share and accept.

---

## Table of Contents

1. [Overview & Goals](#overview--goals)
2. [User Stories](#user-stories)
3. [Core Features](#core-features)
4. [Technical Architecture](#technical-architecture)
5. [Authentication & User Accounts](#authentication--user-accounts)
6. [Data Models](#data-models)
7. [API Design](#api-design)
8. [Storage & Sync Strategy](#storage--sync-strategy)
9. [Sharing & Invitations](#sharing--invitations)
10. [Security & Privacy](#security--privacy)
11. [Implementation Phases](#implementation-phases)
12. [Success Metrics](#success-metrics)

---

## Overview & Goals

### Problem Statement

**Current MVP Limitation:**
- Users can only track personal goals
- No way to collaborate with family/friends
- No shared accountability or motivation
- Can't see if others are completing similar goals

**User Pain Points:**
- "I want to do Ramadan goals with my family, but we can't track together"
- "My friends and I are training for a 5K - we want to see each other's progress"
- "I want to create a reading challenge for my book club"
- "Can we have a shared fitness plan for our household?"

### Solution Vision

Enable users to:
1. **Create Goals Normally:** Start with regular individual goals (like current MVP)
2. **Share When Ready:** Add a "Share" button to any goal
3. **Others Accept:** People can accept shared goals as their own
4. **See Aggregate Stats:** When 2+ people have the same goal, see overall numbers (daily/weekly progress totals)
5. **Maintain Privacy:** Control what aggregate stats are visible (just numbers, not individual details)

### Success Criteria

| Metric | Target |
|--------|--------|
| % of users who share a goal | >25% within 3 months |
| Average shared goal participants | 2-4 people |
| Shared goal acceptance rate | >60% |
| Shared goal completion rate | 15% higher than solo goals |
| Daily active shared goals | >40% of shared goals |

---

## User Stories

### Primary User Stories

**US-1: Share Goal**
> As a user, I want to share my existing goal with others, so they can join me in working toward the same goal.

**US-2: Accept Shared Goal**
> As a user, I want to accept a shared goal from someone else, so I can track the same goal as them.

**US-3: See Aggregate Stats**
> As a user with a shared goal, I want to see overall progress numbers (daily/weekly totals) from all participants, so I know how the group is doing.

**US-4: Privacy Control**
> As a user, I want to control what aggregate stats others can see about my goal, so I maintain privacy while sharing progress.

**US-5: Share via Link**
> As a user, I want to generate a shareable link for my goal, so I can easily invite others via text, email, or social media.

**US-6: View Shared Goals**
> As a user, I want to see which of my goals are shared and who has accepted them, so I know who's tracking with me.

**US-7: Stop Sharing**
> As a user, I want to stop sharing a goal, so I can make it private again if needed.

### Secondary User Stories

**US-8: Participant List**
> As a user, I want to see who else has accepted my shared goal, so I know who's tracking with me.

**US-9: Leave Shared Goal**
> As a user, I want to stop tracking a goal I accepted from someone else, so I can remove it from my list.

**US-10: Weekly/Monthly Aggregates (Future)**
> As a user, I want to see weekly and monthly aggregate stats, so I can track longer-term group progress.

**US-11: Goal Comments (Future)**
> As a user, I want to comment on shared goals, so we can encourage each other.

**US-12: Goal Leaderboard (Future)**
> As a user, I want to see a leaderboard for shared goals, so we can have friendly competition.

---

## Core Features

### F1: Share Goal

**Description:** Users can share any existing goal with others.

**Features:**
- "Share" button on any goal detail screen
- Generate shareable link
- Copy link to clipboard
- Share via native share sheet (text, email, social)
- Set sharing visibility (who can see aggregate stats)
- Stop sharing (make goal private again)

**UI Flow:**
```
Goal Detail → "Share" button → Generate link → Copy/Share → Others receive link
```

**Acceptance Criteria:**
- [ ] User can share any goal (individual or already shared)
- [ ] Shareable link is generated instantly
- [ ] Link can be copied to clipboard
- [ ] Native share sheet works (iOS/Android)
- [ ] User can see sharing status on goal
- [ ] User can stop sharing at any time

---

### F2: Accept Shared Goal

**Description:** Users can accept a shared goal and add it to their own goals.

**Features:**
- Receive shared goal link (via text, email, app)
- Preview goal details (title, description, duration, tasks)
- Accept goal (creates own copy)
- Goal appears in user's goal list
- User tracks their own progress independently
- Original sharer sees new participant

**UI Flow:**
```
Receive link → Open in app/web → Preview goal → "Accept Goal" → Goal added to my list
```

**Acceptance Criteria:**
- [ ] User can preview shared goal before accepting
- [ ] Accepting creates independent copy of goal
- [ ] User's progress is tracked separately
- [ ] Original sharer is notified of new participant
- [ ] User can see who shared the goal
- [ ] Unregistered users can accept (prompts account creation)

---

### F3: Aggregate Stats Visibility

**Description:** When 2+ people have the same shared goal, they can see aggregate progress statistics.

**Aggregate Stats Shown:**

1. **Daily Totals**
   - Total tasks completed today (all participants)
   - Average completion rate today
   - Number of active participants today

2. **Weekly Totals**
   - Total tasks completed this week
   - Average completion rate this week
   - Weekly streak (consecutive days with completions)

3. **Overall Totals**
   - Total tasks completed (all time, all participants)
   - Average completion percentage
   - Number of participants
   - Days since goal started

**Privacy Levels:**

1. **Show My Stats** (Default)
   - Your stats are included in aggregates
   - Others can see overall numbers (not individual)

2. **Hide My Stats** (Privacy mode)
   - Your completions not included in aggregates
   - You can still see others' aggregate stats
   - Others won't know you're hiding

3. **Show Individual Counts** (Future - optional)
   - Show per-participant completion counts
   - Still no individual task details

**UI Components:**
- Aggregate stats card on shared goal detail screen
- Daily/weekly/overall tabs
- Participant count badge
- "X people tracking this goal" indicator

**Acceptance Criteria:**
- [ ] Aggregate stats appear when 2+ people have same goal
- [ ] Daily totals update in real-time (or near real-time)
- [ ] Weekly totals calculated correctly
- [ ] Overall totals show accurate numbers
- [ ] Privacy toggle works (show/hide my stats)
- [ ] Stats only show numbers, not individual task details

---

### F4: Participant Management

**Description:** View and manage who has accepted your shared goal.

**Features:**
- See list of participants (who accepted your shared goal)
- See participant count badge
- View participant profiles (display name, avatar)
- Remove participant (if needed - future)
- See who shared a goal you accepted

**UI Components:**
- Participant list on shared goal detail screen
- "X people tracking this goal" badge
- Participant avatars
- "Shared by [Name]" indicator

**Acceptance Criteria:**
- [ ] User can see all participants for shared goals
- [ ] Participant count updates when someone accepts
- [ ] User can see who originally shared a goal
- [ ] Participant list is scrollable (if many participants)

---

### F5: Shared Goals List

**Description:** View all goals that are shared (yours or accepted from others).

**Features:**
- Filter: "My Shared Goals" vs "Accepted Goals"
- See sharing status on goal cards
- Quick share button on goal cards
- See participant count on shared goals
- Aggregate stats preview on goal cards

**UI Components:**
- Shared goals section in dashboard
- Badge indicating "Shared" or "X participants"
- Filter tabs (All / My Shared / Accepted)

**Acceptance Criteria:**
- [ ] User can see all shared goals in one place
- [ ] Can filter by sharing status
- [ ] Goal cards show sharing indicators
- [ ] Quick actions available (share, view stats)

---

## Technical Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    CLIENT (Flutter App)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Solo Goals   │  │ Group Goals  │  │ Sync Service  │     │
│  │ (Local Only) │  │ (Cloud Sync)  │  │              │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                          ↕ HTTPS/REST API
┌─────────────────────────────────────────────────────────────┐
│                    BACKEND SERVER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Auth Service │  │ Group Service│  │ Sync Service │     │
│  │ (Firebase/   │  │ (Node.js/    │  │ (Real-time)  │     │
│  │  Supabase)   │  │  Go/Python)  │  │              │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────────┐
│                    DATABASE                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ PostgreSQL   │  │ Redis Cache  │  │ File Storage │     │
│  │ (Primary DB) │  │ (Sessions)   │  │ (Avatars)    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

### Technology Stack

**Backend Options:**

| Option | Cost (10K users) | Cost (100K users) | Setup | Best For |
|--------|------------------|-------------------|-------|----------|
| **Supabase** | $0 (free tier) | $25-100 | ⭐ Easy | **Recommended - MVP to Scale** |
| **Firebase** | $0 (free tier) | $300+ | ⭐ Easy | Rapid scaling (but expensive) |
| **AWS (RDS+Lambda)** | $0* (free tier) | $80-150 | ⭐⭐⭐ Complex | Enterprise scale |
| **Google Cloud** | $0* (free tier) | $50-100 | ⭐⭐ Medium | Google ecosystem |
| **Railway** | $5-20 | $50-100 | ⭐ Easy | Small-medium scale |

*First 12 months free tier

**Recommended: Supabase** (PostgreSQL + real-time + auth)

**Why Supabase:**
- ✅ **Cost-effective:** Free tier covers MVP, $25/month for growth
- ✅ Open source (can self-host if needed)
- ✅ PostgreSQL (familiar, powerful)
- ✅ Built-in real-time subscriptions
- ✅ Row-level security for privacy
- ✅ Generous free tier (500MB DB, 2GB bandwidth)
- ✅ Good Flutter SDK
- ✅ Easy setup (minutes, not days)

**Cost Progression:**
- 0-10K users: **$0/month** (Free tier)
- 10K-50K users: **$25/month** (Pro tier)
- 50K-200K users: **$100/month** (Team tier)
- 200K+ users: **$100-300/month** (Custom or migrate to AWS/GCP)

**When to Consider Alternatives:**
- **AWS/GCP:** When you have 200K+ users AND DevOps expertise
- **Firebase:** If you need rapid scaling AND budget allows
- **Railway:** If you want simplest setup AND small scale

---

## Authentication & User Accounts

### Account Requirements

**MVP Approach (Solo):**
- No accounts needed
- All data local
- No sync

**Post-MVP (Groups):**
- **Accounts required** for groups
- Email or phone number
- Optional: Social login (Google, Apple)

### Authentication Flow

**Option 1: Anonymous → Registered**
```
User creates solo goal (no account)
    ↓
User wants to join/create group
    ↓
Prompt: "Create account to use groups"
    ↓
Sign up with email/phone
    ↓
Account created, can now use groups
```

**Option 2: Guest Mode**
```
User can browse groups as guest
    ↓
Can view public groups
    ↓
Must sign up to join/participate
```

**Recommended: Option 1** - Seamless upgrade path

### Account Creation Methods

1. **Email/Password**
   - Traditional signup
   - Email verification required
   - Password reset via email

2. **Phone Number**
   - OTP verification
   - SMS code sent
   - No password needed

3. **Social Login** (Recommended)
   - Google Sign-In
   - Apple Sign-In (iOS/Android)
   - Facebook (optional, regional)
   - Twitter/X (optional, future)

4. **Magic Link** (Future)
   - Email link login
   - No password
   - Link expires in 15 minutes

### User Profile

**Minimal Profile (MVP):**
- Display name
- Email/phone
- Avatar (optional)
- Language preference

**Extended Profile (Future):**
- Bio
- Timezone
- Notification preferences
- Privacy settings

### Social Media-Based Login

#### Overview

Social login allows users to sign in using their existing social media accounts (Google, Apple, Facebook, etc.) instead of creating a new password. This significantly reduces friction in the signup process and improves user experience.

#### Available Social Login Providers

| Provider | Platform Support | Cost | User Base | Best For |
|----------|----------------|------|-----------|----------|
| **Google Sign-In** | iOS, Android, Web | Free | ~3B users | Universal, most popular |
| **Apple Sign-In** | iOS, macOS, Web | Free | ~1.5B users | Privacy-focused, iOS users |
| **Facebook Login** | iOS, Android, Web | Free | ~3B users | Older demographics, regions |
| **Twitter/X** | iOS, Android, Web | Free | ~400M users | Tech-savvy users (future) |

#### Detailed Provider Analysis

##### 1. Google Sign-In

**Pros:**
- ✅ **Widest adoption:** Most users have Google accounts
- ✅ **Cross-platform:** Works on iOS, Android, Web
- ✅ **Easy integration:** Well-documented, good Flutter packages
- ✅ **Reliable:** High uptime, trusted by users
- ✅ **Free:** No cost for authentication
- ✅ **Email verified:** Google accounts are pre-verified
- ✅ **Profile data:** Access to name, email, avatar automatically

**Cons:**
- ❌ **Privacy concerns:** Some users avoid Google
- ❌ **Regional restrictions:** Blocked in some countries (China, etc.)
- ❌ **Data dependency:** Relies on Google's infrastructure

**Implementation:**
```dart
// Flutter package: google_sign_in
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
);

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = 
      await googleUser!.authentication;
  
  // Use with Supabase/Firebase
  return await supabase.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: googleAuth.idToken!,
  );
}
```

**User Experience:**
- One tap to sign in
- No password to remember
- Automatic profile picture and name
- Email pre-verified

**Recommendation:** ✅ **Implement First** - Highest adoption rate

---

##### 2. Apple Sign-In

**Pros:**
- ✅ **Privacy-focused:** Apple's privacy-first approach
- ✅ **Required on iOS:** Apple requires it for apps with other social logins
- ✅ **Hide My Email:** Users can use private relay email
- ✅ **Trusted brand:** High user trust
- ✅ **Free:** No cost
- ✅ **Cross-platform:** Works on iOS, macOS, Web, Android (via web)

**Cons:**
- ❌ **iOS-first:** Best experience on Apple devices
- ❌ **Smaller user base:** Only Apple device users
- ❌ **Limited profile data:** Less information available
- ❌ **Android support:** Limited on Android (web-based)

**Implementation:**
```dart
// Flutter package: sign_in_with_apple
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<AuthorizationCredentialAppleID> signInWithApple() async {
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );
  
  return await supabase.auth.signInWithIdToken(
    provider: OAuthProvider.apple,
    idToken: credential.identityToken!,
  );
}
```

**User Experience:**
- Face ID/Touch ID authentication
- Privacy relay email option
- Minimal data sharing
- Seamless on iOS

**Recommendation:** ✅ **Required for iOS** - Apple mandates it if you offer other social logins

---

##### 3. Facebook Login

**Pros:**
- ✅ **Large user base:** ~3 billion users
- ✅ **Popular in some regions:** Middle East, Southeast Asia
- ✅ **Rich profile data:** Access to profile picture, friends (optional)
- ✅ **Free:** No cost
- ✅ **Cross-platform:** Works everywhere

**Cons:**
- ❌ **Privacy concerns:** Many users avoid Facebook
- ❌ **Declining usage:** Less popular with younger users
- ❌ **Complex permissions:** Can be confusing
- ❌ **Regional restrictions:** Blocked in some countries

**Implementation:**
```dart
// Flutter package: flutter_facebook_auth
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<LoginResult> signInWithFacebook() async {
  final LoginResult result = await FacebookAuth.instance.login(
    permissions: ['email', 'public_profile'],
  );
  
  if (result.status == LoginStatus.success) {
    final AccessToken accessToken = result.accessToken!;
    return await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.facebook,
      accessToken: accessToken.token,
    );
  }
}
```

**User Experience:**
- One tap login
- Access to profile picture
- Can see mutual friends (if enabled)

**Recommendation:** ⚠️ **Optional** - Consider for specific regions (Middle East, Southeast Asia)

---

#### Social Login Benefits

##### 1. Reduced Friction

**Traditional Signup:**
```
1. Enter email
2. Verify email (check inbox, click link)
3. Create password (meet requirements)
4. Confirm password
5. Submit
Total: 2-5 minutes
```

**Social Login:**
```
1. Tap "Sign in with Google"
2. Select account
Total: 5-10 seconds
```

**Impact:** 90% reduction in signup time

---

##### 2. Higher Conversion Rates

**Statistics:**
- Social login increases signup conversion by 20-30%
- Reduces abandonment during signup by 15-25%
- Users are 2x more likely to complete signup with social login

**Why:**
- No password to create/remember
- Email already verified
- Trust in social provider
- Familiar process

---

##### 3. Better User Experience

**Benefits:**
- **Automatic profile:** Name, email, avatar pre-filled
- **No password reset:** Users don't forget passwords
- **Faster onboarding:** Get started immediately
- **Less friction:** One tap vs multiple steps

---

##### 4. Reduced Support Burden

**Traditional:**
- Password reset requests
- Email verification issues
- Account recovery problems

**Social Login:**
- Minimal support needed
- Password issues handled by provider
- Email verification automatic

---

#### Privacy & Security Considerations

##### Data Collection

**What Social Providers Share:**
- **Google:** Email, name, profile picture, locale
- **Apple:** Email (or private relay), name (optional)
- **Facebook:** Email, name, profile picture, friends (optional)

**What We Store:**
- User ID from provider
- Email address
- Display name
- Avatar URL
- Provider type (google/apple/facebook)

**What We Don't Store:**
- Social media passwords (never accessed)
- Friends lists (unless explicitly requested)
- Other social media data

---

##### Privacy Controls

**User Options:**
1. **Use private email:** Apple Sign-In allows "Hide My Email"
2. **Limit data sharing:** Only request necessary permissions
3. **Account linking:** Allow users to link multiple providers
4. **Data deletion:** Easy account deletion

**Implementation:**
```dart
// Request minimal permissions
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'], // Only email and profile
  // Don't request: contacts, calendar, etc.
);
```

---

##### Security Benefits

**Advantages:**
- ✅ **No password storage:** We don't store passwords
- ✅ **Provider security:** Google/Apple handle security
- ✅ **Two-factor auth:** Inherited from provider
- ✅ **Account recovery:** Handled by provider
- ✅ **Less attack surface:** No password database to hack

**Considerations:**
- ⚠️ **Provider dependency:** If provider is down, login fails
- ⚠️ **Account linking:** Need to handle multiple providers per user
- ⚠️ **Token management:** Handle refresh tokens properly

---

#### Regional Considerations

##### Middle East / Muslim Users

**Preferences:**
- **Google:** Most popular, widely used
- **Apple:** Growing, privacy-focused
- **Facebook:** Still popular in some regions
- **Twitter/X:** Less common for login

**Cultural Considerations:**
- Privacy is important
- Some users prefer not to link social accounts
- Always offer email/phone as alternative

**Recommendation:**
- Primary: Google + Apple
- Optional: Facebook (for specific regions)
- Always: Email/phone fallback

---

##### Global Considerations

| Region | Preferred Provider | Notes |
|--------|-------------------|-------|
| **Global** | Google | Most universal |
| **iOS Users** | Apple | Required by Apple |
| **Middle East** | Google, Facebook | Facebook still popular |
| **Southeast Asia** | Google, Facebook | Facebook dominant |
| **China** | WeChat, QQ | Not applicable (blocked) |
| **Europe** | Google, Apple | Privacy-focused |

---

#### Implementation Strategy

##### Phase 1: MVP (Essential)

**Implement:**
1. ✅ **Google Sign-In** - Highest adoption
2. ✅ **Apple Sign-In** - Required for iOS

**Why:**
- Covers 90%+ of users
- Required by Apple App Store
- Easy to implement
- Free

**Timeline:** 1-2 days implementation

---

##### Phase 2: Growth (Optional)

**Consider Adding:**
3. ⚠️ **Facebook Login** - If user requests or regional need

**Why:**
- Some users prefer Facebook
- Popular in specific regions
- Easy to add later

**Timeline:** 1 day implementation

---

##### Phase 3: Future (Nice to Have)

**Potential Additions:**
4. Twitter/X Login
5. Microsoft Account
6. GitHub (for developers)

**Why:**
- Niche use cases
- Low priority
- Add if user demand

---

#### Technical Implementation

##### With Supabase

**Setup:**
1. Configure OAuth providers in Supabase dashboard
2. Add provider credentials (Client ID, Secret)
3. Configure redirect URLs
4. Use Supabase Flutter SDK

**Code:**
```dart
// Supabase handles OAuth flow
await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
  redirectTo: 'tasktrakr://auth-callback',
);

// Handle callback
final session = await supabase.auth.getSession();
```

**Benefits:**
- ✅ Built-in OAuth handling
- ✅ Automatic token management
- ✅ Secure by default
- ✅ Easy to implement

---

##### With Firebase

**Setup:**
1. Enable providers in Firebase Console
2. Add OAuth credentials
3. Use Firebase Auth SDK

**Code:**
```dart
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
final GoogleSignInAuthentication googleAuth = 
    await googleUser!.authentication;

final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);

await FirebaseAuth.instance.signInWithCredential(credential);
```

---

#### Cost Analysis

**Social Login Costs:**

| Provider | Cost | Notes |
|----------|------|-------|
| **Google** | Free | Unlimited authentications |
| **Apple** | Free | Unlimited authentications |
| **Facebook** | Free | Unlimited authentications |
| **Supabase OAuth** | Free | Included in all tiers |
| **Firebase Auth** | Free* | 50K MAU free, then $0.0055/user |

*Firebase: Free for first 50K monthly active users

**Total Cost:** $0/month (for social login itself)

**Additional Costs:**
- Backend storage: Already covered in hosting costs
- No extra charges for social login

---

#### User Experience Flow

##### Signup with Social Login

```
1. User taps "Sign in with Google"
   ↓
2. Google sign-in screen appears
   ↓
3. User selects account (or enters credentials)
   ↓
4. User grants permissions
   ↓
5. App receives token
   ↓
6. Account created automatically
   ↓
7. User lands in app (signed in)
```

**Total Time:** 5-10 seconds

---

##### Account Linking

**Scenario:** User signs up with email, later wants to add Google login

```
1. User goes to Settings → "Link Account"
   ↓
2. Taps "Link Google"
   ↓
3. Google sign-in screen
   ↓
4. Account linked (can now use either method)
```

**Benefits:**
- Users can use multiple login methods
- Reduces lockout risk
- Better user experience

---

#### Recommendations for TaskTrakr

##### Priority Order

1. **✅ Google Sign-In** (Implement First)
   - Highest user adoption
   - Universal support
   - Easy implementation

2. **✅ Apple Sign-In** (Required for iOS)
   - Apple App Store requirement
   - Privacy-focused users
   - Good iOS experience

3. **⚠️ Facebook Login** (Optional)
   - Add if user requests
   - Consider for Middle East/Southeast Asia
   - Can add later if needed

4. **❌ Other Providers** (Future)
   - Low priority
   - Add only if significant demand

---

##### Implementation Plan

**Week 1:**
- Set up Google Sign-In
- Set up Apple Sign-In
- Test on iOS and Android
- Handle account creation flow

**Week 2:**
- Add account linking
- Handle edge cases (cancelled login, errors)
- Test with real users
- Polish UX

**Optional (Later):**
- Add Facebook if needed
- Add other providers if requested

---

##### Success Metrics

**Track:**
- % of users using social login vs email/phone
- Conversion rate: social vs traditional signup
- Time to complete signup: social vs traditional
- Support tickets: password-related issues

**Expected Results:**
- 60-70% of users choose social login
- 20-30% higher signup conversion
- 90% reduction in signup time
- 50% reduction in password-related support

---

### Account Migration

**Challenge:** Users with existing solo goals need to migrate to accounts.

**Solution:**
1. On first group action, prompt for account creation
2. Offer social login as primary option (faster)
3. Offer to migrate existing local data to cloud
4. Keep local data as backup
5. Allow export before migration

**Migration Flow:**
```
User with solo goals → Tries to share goal
    ↓
"Create account to share goals"
    ↓
Show signup options:
  - [Google] [Apple] [Email] [Phone]
    ↓
User chooses social login (recommended)
    ↓
Account created in 5 seconds
    ↓
"Migrate your existing goals to cloud?"
    ↓
[Yes] → Goals uploaded → Ready to share
[No] → Solo goals stay local → Can share new goals
```

---

## Data Models

### Database Schema

#### Users Table

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE,
  phone VARCHAR(20) UNIQUE,
  display_name VARCHAR(100) NOT NULL,
  avatar_url TEXT,
  language VARCHAR(10) DEFAULT 'en',
  timezone VARCHAR(50) DEFAULT 'UTC',
  
  -- Social login providers
  auth_provider VARCHAR(20), -- 'email', 'phone', 'google', 'apple', 'facebook'
  provider_id VARCHAR(255), -- Provider-specific user ID
  provider_email VARCHAR(255), -- Email from provider (may differ from main email)
  
  -- Account linking (multiple providers per user)
  linked_providers TEXT[], -- Array of provider names: ['google', 'apple']
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  last_seen_at TIMESTAMP,
  is_anonymous BOOLEAN DEFAULT FALSE,
  
  -- Ensure at least one identifier
  CONSTRAINT users_has_identifier CHECK (
    email IS NOT NULL OR phone IS NOT NULL OR provider_id IS NOT NULL
  )
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_provider ON users(auth_provider, provider_id);
CREATE INDEX idx_users_provider_email ON users(provider_email);
```

#### Shared Goals Table

```sql
-- Represents a goal that can be shared with others
CREATE TABLE shared_goals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  original_goal_id UUID NOT NULL, -- Reference to original goal (can be local or cloud)
  shared_by UUID REFERENCES users(id) ON DELETE CASCADE,
  share_code VARCHAR(50) UNIQUE NOT NULL, -- For shareable links
  share_code_expires_at TIMESTAMP,
  is_sharing_active BOOLEAN DEFAULT TRUE,
  privacy_level VARCHAR(20) DEFAULT 'show_stats', -- show_stats, hide_stats
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_shared_goals_shared_by ON shared_goals(shared_by);
CREATE INDEX idx_shared_goals_code ON shared_goals(share_code);
CREATE INDEX idx_shared_goals_active ON shared_goals(is_sharing_active) WHERE is_sharing_active = TRUE;
```

#### Goal Participants Table

```sql
-- Tracks who has accepted a shared goal
CREATE TABLE goal_participants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  shared_goal_id UUID REFERENCES shared_goals(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  original_goal_id UUID NOT NULL, -- Their copy of the goal (local or cloud)
  accepted_at TIMESTAMP DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  privacy_level VARCHAR(20) DEFAULT 'show_stats', -- show_stats, hide_stats
  UNIQUE(shared_goal_id, user_id)
);

CREATE INDEX idx_goal_participants_shared_goal ON goal_participants(shared_goal_id);
CREATE INDEX idx_goal_participants_user ON goal_participants(user_id);
CREATE INDEX idx_goal_participants_active ON goal_participants(is_active) WHERE is_active = TRUE;
```

#### Goal Aggregates Table

```sql
-- Pre-computed aggregate statistics for shared goals
CREATE TABLE goal_aggregates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  shared_goal_id UUID REFERENCES shared_goals(id) ON DELETE CASCADE,
  date DATE NOT NULL, -- For daily aggregates
  total_tasks_completed INTEGER DEFAULT 0,
  total_tasks_available INTEGER DEFAULT 0,
  active_participants_count INTEGER DEFAULT 0,
  average_completion_rate DECIMAL(5,2) DEFAULT 0.0,
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(shared_goal_id, date)
);

CREATE INDEX idx_goal_aggregates_shared_goal ON goal_aggregates(shared_goal_id);
CREATE INDEX idx_goal_aggregates_date ON goal_aggregates(date);
```

#### User Goals Table (Cloud Copy)

```sql
-- Cloud copy of user's goals (for shared goals only)
-- Solo goals remain local-only
CREATE TABLE user_goals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  title_short VARCHAR(100),
  description TEXT,
  category VARCHAR(50),
  icon VARCHAR(10), -- Emoji
  duration_days INTEGER NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  difficulty VARCHAR(20), -- easy, moderate, challenging
  special_mode VARCHAR(20), -- ramadan, etc.
  is_shared BOOLEAN DEFAULT FALSE, -- Is this goal shared?
  shared_goal_id UUID REFERENCES shared_goals(id), -- If shared, link to shared_goals
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_user_goals_user ON user_goals(user_id);
CREATE INDEX idx_user_goals_shared ON user_goals(is_shared) WHERE is_shared = TRUE;
CREATE INDEX idx_user_goals_shared_goal ON user_goals(shared_goal_id);
```

#### User Day Plans Table (Cloud Copy)

```sql
-- Cloud copy of day plans (for shared goals only)
CREATE TABLE user_day_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_goal_id UUID REFERENCES user_goals(id) ON DELETE CASCADE,
  day INTEGER NOT NULL, -- 1, 2, 3...
  date DATE NOT NULL,
  task TEXT,
  task_short VARCHAR(255),
  estimated_minutes INTEGER,
  notes TEXT,
  intensity VARCHAR(20), -- light, moderate, intense
  ramadan_phase VARCHAR(20), -- mercy, forgiveness, salvation
  is_laylatul_qadr_night BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_goal_id, day)
);

CREATE INDEX idx_user_day_plans_goal ON user_day_plans(user_goal_id);
CREATE INDEX idx_user_day_plans_date ON user_day_plans(date);
```

#### User Task Completions Table (Cloud Copy)

```sql
-- Cloud copy of task completions (for shared goals only)
CREATE TABLE user_task_completions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  day_plan_id UUID REFERENCES user_day_plans(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  status VARCHAR(20) DEFAULT 'completed', -- completed, in_progress, skipped
  minutes_completed INTEGER DEFAULT 0,
  completed_at TIMESTAMP DEFAULT NOW(),
  notes TEXT,
  UNIQUE(day_plan_id, user_id)
);

CREATE INDEX idx_user_task_completions_day_plan ON user_task_completions(day_plan_id);
CREATE INDEX idx_user_task_completions_user ON user_task_completions(user_id);
CREATE INDEX idx_user_task_completions_date ON user_task_completions(completed_at);
```

### Flutter Models (Dart)

#### SharedGoal Model

```dart
class SharedGoal {
  final String id;
  final String originalGoalId; // Reference to original goal
  final String sharedBy; // User ID who shared
  final String shareCode; // For shareable links
  final DateTime? shareCodeExpiresAt;
  final bool isSharingActive;
  final PrivacyLevel privacyLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Computed
  int get participantCount;
  List<GoalParticipant> get participants;
  GoalAggregates? get aggregates; // Daily/weekly/overall stats
}

enum PrivacyLevel {
  showStats,  // Include my stats in aggregates
  hideStats,  // Don't include my stats (but I can see others')
}
```

#### GoalParticipant Model

```dart
class GoalParticipant {
  final String id;
  final String sharedGoalId;
  final String userId;
  final String originalGoalId; // Their copy of the goal
  final DateTime acceptedAt;
  final bool isActive;
  final PrivacyLevel privacyLevel;
  
  // Related
  final User user; // User profile
  final Goal? goal; // Their goal copy (if loaded)
}
```

#### GoalAggregates Model

```dart
class GoalAggregates {
  final String id;
  final String sharedGoalId;
  final DateTime date; // For daily aggregates
  final int totalTasksCompleted;
  final int totalTasksAvailable;
  final int activeParticipantsCount;
  final double averageCompletionRate;
  final DateTime updatedAt;
  
  // Computed
  double get completionPercentage => 
    totalTasksAvailable > 0 
      ? totalTasksCompleted / totalTasksAvailable 
      : 0.0;
}

// Weekly aggregates (computed from daily)
class WeeklyAggregates {
  final String sharedGoalId;
  final DateTime weekStart; // Monday of the week
  final int totalTasksCompleted;
  final int totalTasksAvailable;
  final double averageCompletionRate;
  final int activeDays; // Days with at least one completion
}

// Overall aggregates (all-time)
class OverallAggregates {
  final String sharedGoalId;
  final int totalTasksCompleted;
  final int totalTasksAvailable;
  final double averageCompletionRate;
  final int activeParticipantsCount;
  final int daysSinceStart;
  final int weeklyStreak; // Consecutive weeks with activity
}
```

#### Extended Goal Model (for shared goals)

```dart
// Extend existing Goal model with sharing info
extension SharedGoalExtension on Goal {
  bool get isShared => sharedGoalId != null;
  String? get sharedGoalId;
  SharedGoal? get sharedGoal; // If shared
  List<GoalParticipant>? get participants; // If shared
  GoalAggregates? get dailyAggregates; // Today's stats
  GoalAggregates? get weeklyAggregates; // This week's stats
  OverallAggregates? get overallAggregates; // All-time stats
}
```

---

## API Design

### REST API Endpoints

#### Authentication

```
POST   /api/auth/register              # Email/password signup
POST   /api/auth/login                 # Email/password login
POST   /api/auth/logout                # Logout
POST   /api/auth/refresh               # Refresh token
GET    /api/auth/me                    # Get current user
PUT    /api/auth/profile               # Update profile

# Social Login
GET    /api/auth/oauth/google          # Initiate Google OAuth
GET    /api/auth/oauth/apple           # Initiate Apple OAuth
GET    /api/auth/oauth/facebook        # Initiate Facebook OAuth
GET    /api/auth/oauth/callback        # OAuth callback handler

# Account Linking
POST   /api/auth/link/google           # Link Google account
POST   /api/auth/link/apple            # Link Apple account
POST   /api/auth/link/facebook         # Link Facebook account
DELETE /api/auth/unlink/:provider     # Unlink provider
```

#### Shared Goals

```
POST   /api/goals/:goalId/share                # Share a goal (creates shared_goal)
GET    /api/goals/:goalId/share                 # Get sharing info for a goal
PUT    /api/goals/:goalId/share                # Update sharing settings
DELETE /api/goals/:goalId/share                # Stop sharing a goal
GET    /api/shared-goals/:shareCode             # Get shared goal by code (for preview)
POST   /api/shared-goals/:shareCode/accept      # Accept a shared goal
GET    /api/shared-goals/:id/participants       # List participants
GET    /api/shared-goals/:id/aggregates        # Get aggregate stats
GET    /api/shared-goals/:id/aggregates/daily   # Get daily aggregates
GET    /api/shared-goals/:id/aggregates/weekly  # Get weekly aggregates
GET    /api/shared-goals/:id/aggregates/overall # Get overall aggregates
```

#### User Goals (Cloud)

```
GET    /api/user/goals                         # List user's cloud goals (shared goals only)
POST   /api/user/goals                         # Create cloud goal (when accepting shared)
GET    /api/user/goals/:id                     # Get user goal details
PUT    /api/user/goals/:id                     # Update user goal
DELETE /api/user/goals/:id                     # Delete user goal
GET    /api/user/goals/:id/day-plans            # Get day plans
POST   /api/user/goals/:id/day-plans/:day/completions  # Mark task complete
PUT    /api/user/goals/:id/day-plans/:day/completions  # Update completion
DELETE /api/user/goals/:id/day-plans/:day/completions  # Uncomplete task
```

#### Real-time Subscriptions

```
WebSocket: /ws/shared-goals/:sharedGoalId
  - Subscribe to shared goal updates
  - Receive: participant joins/leaves, aggregate stat updates
```

### API Response Examples

#### Share Goal

**Request:**
```json
POST /api/goals/goal-123/share
{
  "privacyLevel": "show_stats",
  "expiresInDays": 30
}
```

**Response:**
```json
{
  "id": "shared-goal-456",
  "originalGoalId": "goal-123",
  "sharedBy": "user-123",
  "shareCode": "RAMADAN2026-QURAN",
  "shareCodeExpiresAt": "2026-03-30T00:00:00Z",
  "isSharingActive": true,
  "privacyLevel": "show_stats",
  "shareUrl": "https://tasktrakr.app/goal/RAMADAN2026-QURAN",
  "createdAt": "2026-02-15T10:00:00Z"
}
```

#### Get Shared Goal (Preview)

**Request:**
```
GET /api/shared-goals/RAMADAN2026-QURAN
```

**Response:**
```json
{
  "id": "shared-goal-456",
  "goal": {
    "title": "Complete Quran Reading",
    "titleShort": "Read Quran",
    "description": "Read the entire Quran during Ramadan",
    "category": "ramadan",
    "icon": "📖",
    "durationDays": 30,
    "startDate": "2026-02-28",
    "endDate": "2026-03-29"
  },
  "sharedBy": {
    "id": "user-123",
    "displayName": "Ahmed",
    "avatarUrl": "https://..."
  },
  "participantCount": 3,
  "canAccept": true
}
```

#### Accept Shared Goal

**Request:**
```json
POST /api/shared-goals/RAMADAN2026-QURAN/accept
```

**Response:**
```json
{
  "participantId": "participant-789",
  "sharedGoalId": "shared-goal-456",
  "userId": "user-456",
  "goalId": "goal-789", // Their new goal copy
  "acceptedAt": "2026-02-15T11:00:00Z"
}
```

#### Get Aggregate Stats

**Request:**
```
GET /api/shared-goals/shared-goal-456/aggregates/daily?date=2026-02-20
```

**Response:**
```json
{
  "sharedGoalId": "shared-goal-456",
  "date": "2026-02-20",
  "totalTasksCompleted": 12,
  "totalTasksAvailable": 15,
  "activeParticipantsCount": 4,
  "averageCompletionRate": 0.80,
  "updatedAt": "2026-02-20T18:30:00Z"
}
```

#### Get Weekly Aggregates

**Request:**
```
GET /api/shared-goals/shared-goal-456/aggregates/weekly?week=2026-02-17
```

**Response:**
```json
{
  "sharedGoalId": "shared-goal-456",
  "weekStart": "2026-02-17",
  "totalTasksCompleted": 84,
  "totalTasksAvailable": 105,
  "averageCompletionRate": 0.80,
  "activeDays": 7,
  "updatedAt": "2026-02-23T23:59:59Z"
}
```

#### Get Overall Aggregates

**Request:**
```
GET /api/shared-goals/shared-goal-456/aggregates/overall
```

**Response:**
```json
{
  "sharedGoalId": "shared-goal-456",
  "totalTasksCompleted": 360,
  "totalTasksAvailable": 450,
  "averageCompletionRate": 0.80,
  "activeParticipantsCount": 4,
  "daysSinceStart": 12,
  "weeklyStreak": 2,
  "updatedAt": "2026-02-20T18:30:00Z"
}
```

---

## Storage & Sync Strategy

### Hybrid Storage Approach

**Solo Goals:** Remain local-only (Hive) - no cloud sync needed
**Shared Goals:** Cloud-synced (PostgreSQL) - only when goal is shared or accepted

### Sync Strategy

#### 1. Initial Sync

When user first enables groups:
```
1. Create account (if not exists)
2. Upload existing solo goals (optional)
3. Download group goals from server
4. Merge with local data
```

#### 2. Real-time Sync

**For Group Goals:**
- Use WebSocket or Server-Sent Events (SSE)
- Subscribe to group updates
- Receive: task completions, member changes, goal updates
- Update local cache immediately

**For Solo Goals:**
- Remain local-only
- No sync needed

#### 3. Offline Support

**Strategy:**
- Cache group data locally (Hive or SQLite)
- Queue operations when offline
- Sync when connection restored

**Implementation:**
```dart
class SyncService {
  // Queue for offline operations
  final Queue<SyncOperation> _pendingOperations = Queue();
  
  Future<void> markTaskComplete(String taskId) async {
    try {
      // Try to sync immediately
      await api.completeTask(taskId);
      // Update local cache
      await localCache.updateTask(taskId, completed: true);
    } catch (e) {
      // Offline - queue for later
      _pendingOperations.add(SyncOperation.completeTask(taskId));
      // Update local cache optimistically
      await localCache.updateTask(taskId, completed: true);
    }
  }
  
  Future<void> syncPendingOperations() async {
    while (_pendingOperations.isNotEmpty) {
      final op = _pendingOperations.removeFirst();
      try {
        await op.execute();
      } catch (e) {
        // Re-queue if failed
        _pendingOperations.add(op);
        break;
      }
    }
  }
}
```

#### 4. Conflict Resolution

**Scenario:** Two users complete same task simultaneously

**Strategy:**
- Last-write-wins (with timestamp)
- Or: Merge completions (if shared ownership)
- Show conflict notification if needed

**Implementation:**
```dart
class ConflictResolver {
  Future<void> resolveConflict(
    LocalTask local,
    RemoteTask remote,
  ) async {
    if (remote.updatedAt.isAfter(local.updatedAt)) {
      // Remote is newer - use it
      await localCache.update(local.id, remote);
    } else {
      // Local is newer - push to server
      await api.updateTask(local);
    }
  }
}
```

### Data Partitioning

**Local Storage (Hive):**
- Solo goals (StoredGoal) - never synced
- Solo day plans (StoredDayPlan) - never synced
- User preferences (UserPreferences)
- Cached shared goal data (for offline)

**Cloud Storage (PostgreSQL):**
- User accounts
- Shared goals (metadata only)
- Goal participants
- Goal aggregates (pre-computed stats)
- User goals (cloud copies of shared goals only)
- User day plans (cloud copies of shared goals only)
- User task completions (cloud copies of shared goals only)

### Backup & Export

**User Data Export:**
- Export all goals (solo + group) as JSON
- Include completion history
- Include group memberships
- One-click download

**Backup Strategy:**
- Automatic cloud backup (optional)
- Manual export to file
- Restore from backup

---

## Sharing & Invitations

### Share Link Format

**Structure:**
```
https://tasktrakr.app/goal/{share-code}
```

**Example:**
```
https://tasktrakr.app/goal/RAMADAN2026-QURAN
```

### Share Link Flow

#### For Registered Users

```
1. User receives share link
2. Clicks link
3. App opens (if installed) or web opens
4. If logged in: Show goal preview → "Accept Goal" → Goal added
5. If not logged in: Prompt to login, then show preview
```

#### For Unregistered Users

```
1. User receives share link
2. Clicks link
3. App/web opens
4. Show goal preview (title, description, duration, participant count)
5. Prompt: "Create account to accept this goal"
6. Sign up flow
7. Auto-accept goal after signup
```

### Share Code Security

**Share Code Properties:**
- Unique per shared goal
- Configurable expiration (default: 30 days)
- Can be regenerated (invalidates old code)
- Can be revoked (stop sharing)
- Reusable (not one-time use)

**Privacy:**
- Share codes don't reveal goal details beyond preview
- Preview shows: title, description, duration, participant count
- Full goal details only after accepting
- Aggregate stats visible to all participants

### Sharing Methods

#### 1. Copy Link
```
User clicks "Share" → Link copied to clipboard → User pastes anywhere
```

#### 2. Share Sheet (Native)
```
User clicks "Share" → Native share sheet opens → Choose app (Messages, Email, etc.)
```

#### 3. Email Invite
```
User enters email → System sends invite email → User clicks link in email
```

#### 4. In-App Invite
```
User searches for username/email → Send in-app notification → User accepts
```

### Deep Linking

**App Deep Link:**
```
tasktrakr://goal/RAMADAN2026-QURAN
```

**Universal Link (iOS):**
```
https://tasktrakr.app/goal/RAMADAN2026-QURAN
```

**Android App Link:**
```
https://tasktrakr.app/goal/RAMADAN2026-QURAN
```

**Implementation:**
- Handle deep links in app
- Route to goal preview screen
- Show "Accept Goal" button if not already accepted
- Auto-accept if authenticated and not already participant
- Show signup if not authenticated

---

## Security & Privacy

### Authentication Security

**Password Requirements:**
- Minimum 8 characters
- At least one number
- At least one letter
- Optional: Special characters

**Session Management:**
- JWT tokens with expiration
- Refresh tokens for long sessions
- Secure HTTP-only cookies (web)
- Token rotation on refresh

**Account Security:**
- Email verification required
- Phone verification (if using phone)
- Two-factor authentication (future)
- Account recovery via email/phone

### Data Privacy

#### Row-Level Security (RLS)

**Supabase/PostgreSQL RLS Policies:**

```sql
-- Users can only see shared goals they created or are participants in
CREATE POLICY "Users can view their shared goals"
ON shared_goals FOR SELECT
USING (
  shared_by = auth.uid() OR
  id IN (
    SELECT shared_goal_id FROM goal_participants
    WHERE user_id = auth.uid() AND is_active = TRUE
  )
);

-- Users can only see participants of shared goals they're part of
CREATE POLICY "Users can view goal participants"
ON goal_participants FOR SELECT
USING (
  shared_goal_id IN (
    SELECT id FROM shared_goals
    WHERE shared_by = auth.uid()
  ) OR
  user_id = auth.uid()
);

-- Users can only see aggregates for shared goals they're part of
CREATE POLICY "Users can view goal aggregates"
ON goal_aggregates FOR SELECT
USING (
  shared_goal_id IN (
    SELECT id FROM shared_goals
    WHERE shared_by = auth.uid() OR
    id IN (
      SELECT shared_goal_id FROM goal_participants
      WHERE user_id = auth.uid() AND is_active = TRUE
    )
  )
);

-- Users can only see their own goal completions
CREATE POLICY "Users can view their completions"
ON user_task_completions FOR SELECT
USING (user_id = auth.uid());
```

#### Visibility Controls

**Per-Goal Privacy:**
- Goal sharer sets privacy level (show_stats/hide_stats)
- Participants can set their own privacy level
- Privacy only affects aggregate stats (not individual task details)
- Aggregate stats always show overall numbers (never individual details)

**Privacy Levels:**
- **Show Stats:** Your completions included in aggregates
- **Hide Stats:** Your completions excluded from aggregates (but you can still see others' aggregates)

#### Data Encryption

**At Rest:**
- Database encryption (PostgreSQL)
- Encrypted backups
- Secure key management

**In Transit:**
- HTTPS/TLS for all API calls
- WebSocket over WSS
- Certificate pinning (mobile)

### Content Moderation

**User-Generated Content:**
- Goal titles/descriptions (when shared)
- Task notes
- User display names

**Moderation Strategy:**
- AI content filter (Gemini API)
- Keyword blocking
- User reporting
- Admin review queue

### GDPR Compliance

**User Rights:**
- Right to access data
- Right to delete data
- Right to export data
- Right to withdraw consent

**Implementation:**
- Data export endpoint
- Account deletion endpoint
- Privacy settings page
- Clear consent flows

---

## Implementation Phases

### Phase 1: Foundation (Weeks 1-2)

**Goal:** Set up backend infrastructure

**Tasks:**
- [ ] Choose backend (Supabase recommended)
- [ ] Set up database schema
- [ ] Implement authentication (email/password)
- [ ] Create basic API endpoints
- [ ] Set up Flutter backend integration
- [ ] Test authentication flow

**Deliverables:**
- Working authentication
- Database schema deployed
- Basic API working

---

### Phase 2: Share Goal (Weeks 3-4)

**Goal:** Users can share any goal

**Tasks:**
- [ ] "Share" button on goal detail screen
- [ ] Share link generation
- [ ] Share code creation
- [ ] Copy link to clipboard
- [ ] Native share sheet integration
- [ ] Stop sharing functionality
- [ ] Share status indicator on goals

**Deliverables:**
- Users can share any goal
- Shareable links work
- Users can stop sharing

---

### Phase 3: Accept Shared Goal (Weeks 5-6)

**Goal:** Users can accept shared goals

**Tasks:**
- [ ] Goal preview screen (from share link)
- [ ] Accept goal flow
- [ ] Create goal copy for accepting user
- [ ] Deep linking setup
- [ ] Unregistered user flow (signup → accept)
- [ ] Participant tracking
- [ ] "Shared by" indicator

**Deliverables:**
- Users can accept shared goals
- Deep links work
- Unregistered users can join

---

### Phase 4: Aggregate Stats (Weeks 7-8)

**Goal:** Show aggregate progress when 2+ people have same goal

**Tasks:**
- [ ] Aggregate stats computation (daily/weekly/overall)
- [ ] Aggregate stats UI on shared goals
- [ ] Daily totals display
- [ ] Weekly totals display
- [ ] Overall totals display
- [ ] Participant count badge
- [ ] Privacy controls (show/hide stats)
- [ ] Real-time aggregate updates (WebSocket/SSE)

**Deliverables:**
- Aggregate stats visible on shared goals
- Real-time updates work
- Privacy controls functional

---

### Phase 5: Participant Management (Weeks 9-10)

**Goal:** View and manage participants

**Tasks:**
- [ ] Participant list UI
- [ ] Participant avatars and names
- [ ] Participant count badge
- [ ] "X people tracking this goal" indicator
- [ ] Leave shared goal functionality
- [ ] Shared goals filter in dashboard

**Deliverables:**
- Users can see participants
- Users can manage shared goals
- Dashboard shows shared goals clearly

---

### Phase 6: Polish & Testing (Weeks 11-12)

**Goal:** Production-ready feature

**Tasks:**
- [ ] Offline support
- [ ] Conflict resolution
- [ ] Error handling
- [ ] Performance optimization
- [ ] Security audit
- [ ] User testing
- [ ] Bug fixes
- [ ] Documentation

**Deliverables:**
- Feature complete
- Tested and stable
- Ready for production

---

## Success Metrics

### Adoption Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| % users who share a goal | >25% | Within 3 months of launch |
| Average shared goal participants | 2-4 people | Track participant count |
| Shared goals created per day | 100+ | Daily shared goals |
| Share link acceptance rate | >60% | Accepted / Shared goals |

### Engagement Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Daily active shared goals | >40% | Shared goals with activity in last 24h |
| Shared goal completion rate | +15% vs solo | Compare completion rates |
| Average tasks per participant | 5+ | Per active shared goal |
| Shared goal retention (30-day) | >35% | Shared goals still active after 30 days |

### Technical Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| API response time (p95) | <200ms | Monitor API latency |
| Real-time update latency | <1s | WebSocket message delivery |
| Sync success rate | >99% | Successful syncs / Total syncs |
| Offline operation success | >95% | Queued operations that sync |

### Business Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| User retention (shared goal users) | +15% vs solo | 30-day retention rate |
| Daily active users (shared goals) | 1.5x solo users | Compare engagement |
| Viral coefficient | >0.4 | Share links per user |

---

## Open Questions & Decisions Needed

### Technical Decisions

1. **Backend Choice**
   - ✅ Recommended: Supabase
   - Alternative: Firebase, Custom Node.js
   - **Decision needed:** Final backend selection

2. **Real-time Strategy**
   - WebSocket vs Server-Sent Events
   - Polling fallback?
   - **Decision needed:** Real-time approach

3. **Offline Strategy**
   - How much data to cache?
   - Conflict resolution approach?
   - **Decision needed:** Offline behavior

### Product Decisions

1. **Participant Limits**
   - Maximum participants per shared goal?
   - Pricing tiers for larger shared goals?
   - **Decision needed:** Limits and pricing

2. **Free vs Paid Features**
   - Which features are free?
   - What requires subscription?
   - **Decision needed:** Monetization model

3. **Privacy Defaults**
   - Default visibility level?
   - Can users opt-out of groups?
   - **Decision needed:** Privacy defaults

### UX Decisions

1. **Onboarding Flow**
   - When to prompt for account creation?
   - How to migrate solo goals?
   - **Decision needed:** User journey

2. **Notification Strategy**
   - What events trigger notifications?
   - Push vs in-app only?
   - **Decision needed:** Notification rules

---

## Appendix

### A. Database Indexes

```sql
-- Performance indexes
CREATE INDEX idx_goal_participants_active ON goal_participants(shared_goal_id, is_active) WHERE is_active = TRUE;
CREATE INDEX idx_user_task_completions_recent ON user_task_completions(user_id, completed_at DESC);
CREATE INDEX idx_shared_goals_active ON shared_goals(is_sharing_active) WHERE is_sharing_active = TRUE;
CREATE INDEX idx_goal_aggregates_date ON goal_aggregates(shared_goal_id, date DESC);
```

### B. API Rate Limiting

```
- Authentication: 10 requests/minute
- Share goal operations: 30 requests/minute
- Accept goal: 20 requests/minute
- Task completions: 100 requests/minute
- Aggregate stats: 60 requests/minute
```

### C. Hosting & Cost Analysis

#### Hosting Options Comparison

| Provider | Free Tier | Paid Tier | Best For | Setup Complexity |
|----------|-----------|-----------|----------|------------------|
| **Supabase** | 500MB DB, 2GB bandwidth | $25-100/mo | Small-medium scale | ⭐ Easy |
| **Firebase** | 1GB storage, 10GB transfer | Pay-as-you-go | Rapid scaling | ⭐ Easy |
| **AWS (RDS + Lambda)** | 750h Lambda, 20GB RDS | Pay-as-you-go | Enterprise scale | ⭐⭐⭐ Complex |
| **Google Cloud (Cloud SQL + Cloud Run)** | $300 credit | Pay-as-you-go | Google ecosystem | ⭐⭐ Medium |
| **Railway** | $5 credit | $20-100/mo | Simple deployments | ⭐ Easy |
| **Render** | Free tier (limited) | $7-25/mo | Small apps | ⭐ Easy |
| **Fly.io** | 3 VMs free | Pay-as-you-go | Global edge | ⭐⭐ Medium |

#### Detailed Cost Breakdown by Scale

##### Option 1: Supabase (Recommended for MVP)

**Free Tier:**
- 500MB PostgreSQL database
- 2GB bandwidth/month
- 50,000 monthly active users
- 200 concurrent real-time connections
- Built-in authentication
- Row-level security
- **Cost: $0/month**

**Pro Tier ($25/month):**
- 8GB database
- 50GB bandwidth
- 100,000 monthly active users
- 500 concurrent connections
- Daily backups
- **Cost: $25/month**

**Team Tier ($100/month):**
- 32GB database
- 250GB bandwidth
- Unlimited users
- 1,000 concurrent connections
- Point-in-time recovery
- **Cost: $100/month**

**Estimated Costs:**
- 0-10K users: **$0** (Free tier)
- 10K-50K users: **$0-25** (Free tier or Pro)
- 50K-200K users: **$25-100** (Pro to Team)
- 200K+ users: **$100-200** (Team + custom)

**Why Supabase:**
- ✅ Open source (can self-host later)
- ✅ PostgreSQL (familiar, powerful)
- ✅ Built-in real-time
- ✅ Generous free tier
- ✅ Good Flutter SDK
- ✅ Row-level security built-in

---

##### Option 2: Firebase (Google Cloud)

**Spark Plan (Free):**
- 1GB Firestore storage
- 10GB/month bandwidth
- 50K reads/day, 20K writes/day
- Authentication: 50K MAU
- **Cost: $0/month**

**Blaze Plan (Pay-as-you-go):**
- Firestore: $0.06/GB storage, $0.18/100K reads, $0.54/100K writes
- Cloud Functions: $0.40/million invocations
- Authentication: $0.0055/user/month (after 50K)
- Bandwidth: $0.12/GB

**Estimated Costs (100K users, 10% shared goals):**
- Storage: ~5GB × $0.06 = **$0.30**
- Reads: ~10M/month × $0.18/100K = **$18**
- Writes: ~2M/month × $0.54/100K = **$10.80**
- Auth: 50K free + 50K × $0.0055 = **$275**
- **Total: ~$304/month**

**Why Firebase:**
- ✅ Easy setup
- ✅ Real-time built-in
- ✅ Good scaling
- ❌ Vendor lock-in
- ❌ Costs scale with usage
- ❌ Can get expensive at scale

---

##### Option 3: AWS (RDS + Lambda + API Gateway)

**Free Tier (12 months):**
- RDS: 750 hours/month (t2.micro)
- Lambda: 1M requests/month
- API Gateway: 1M requests/month
- **Cost: $0/month (first year)**

**After Free Tier (100K users):**
- RDS (db.t3.micro): **$15/month**
- Lambda: ~5M requests × $0.20/million = **$1**
- API Gateway: ~5M requests × $3.50/million = **$17.50**
- Data transfer: ~50GB × $0.09/GB = **$4.50**
- **Total: ~$38/month**

**At 500K users:**
- RDS (db.t3.small): **$30/month**
- Lambda: ~25M requests = **$5**
- API Gateway: ~25M requests = **$87.50**
- Data transfer: ~250GB = **$22.50**
- **Total: ~$145/month**

**Why AWS:**
- ✅ Very scalable
- ✅ Full control
- ✅ Enterprise-grade
- ❌ Complex setup
- ❌ More management overhead
- ❌ Can be expensive

---

##### Option 4: Google Cloud (Cloud SQL + Cloud Run)

**Free Tier:**
- $300 credit for 90 days
- Cloud SQL: 1 instance (db-f1-micro)
- Cloud Run: 2M requests/month

**After Free Tier (100K users):**
- Cloud SQL (db-f1-micro): **$7.67/month**
- Cloud Run: ~5M requests × $0.40/million = **$2**
- Data transfer: ~50GB × $0.12/GB = **$6**
- **Total: ~$16/month**

**At 500K users:**
- Cloud SQL (db-n1-standard-1): **$50/month**
- Cloud Run: ~25M requests = **$10**
- Data transfer: ~250GB = **$30**
- **Total: ~$90/month**

**Why Google Cloud:**
- ✅ Good integration with Firebase
- ✅ Competitive pricing
- ✅ Good documentation
- ❌ More complex than managed services
- ❌ Requires more setup

---

##### Option 5: Railway (Simplified Hosting)

**Hobby Plan ($5/month):**
- 512MB RAM
- 1GB disk
- 100GB bandwidth
- **Cost: $5/month**

**Pro Plan ($20/month):**
- 8GB RAM
- 100GB disk
- 1TB bandwidth
- **Cost: $20/month**

**Estimated Costs:**
- 0-10K users: **$5-20/month**
- 10K-50K users: **$20-50/month**
- 50K+ users: **$50-100/month**

**Why Railway:**
- ✅ Very easy setup
- ✅ Simple pricing
- ✅ Good for small-medium scale
- ❌ Less control
- ❌ Can get expensive at scale

---

#### Cost Minimization Strategies

##### 1. Use Free Tiers Aggressively

**Strategy:**
- Start with Supabase free tier (500MB, 2GB bandwidth)
- Use Firebase free tier for auth only (50K MAU)
- Use Cloudflare Workers for API proxy (100K requests/day free)

**Savings:** $0-25/month for first 10K-50K users

---

##### 2. Optimize Database Usage

**Strategies:**
- **Archive old data:** Move completed goals older than 90 days to cold storage
- **Compress data:** Use JSON compression for large fields
- **Index efficiently:** Only index frequently queried columns
- **Partition tables:** Separate active vs archived data

**Example:**
```
Active goals: ~10MB per 1K users
Archived goals: Move to S3/Cloud Storage ($0.023/GB)
Savings: 80% reduction in database size
```

---

##### 3. Cache Aggressively

**Strategy:**
- Cache aggregate stats (update every 5-15 minutes, not real-time)
- Use Redis (free tier: Upstash, Redis Cloud)
- Cache user profiles (TTL: 1 hour)
- Cache goal previews (TTL: 5 minutes)

**Cost:**
- Upstash Redis: Free tier (10K commands/day)
- Or: Cloudflare KV (free tier: 100K reads/day)

**Savings:** 60-80% reduction in database queries

---

##### 4. Batch Operations

**Strategy:**
- Batch aggregate calculations (run every 15 minutes, not per request)
- Batch email notifications (send digest, not individual)
- Batch cleanup jobs (delete old data weekly, not daily)

**Savings:** 50-70% reduction in compute costs

---

##### 5. Use CDN for Static Assets

**Strategy:**
- Serve avatars/images via Cloudflare CDN (free tier)
- Cache API responses at edge (Cloudflare Workers)
- Use Cloudflare R2 for file storage ($0.015/GB, cheaper than S3)

**Savings:** 80-90% reduction in bandwidth costs

---

##### 6. Optimize Real-time Updates

**Strategy:**
- Use polling fallback (reduce WebSocket connections)
- Batch real-time updates (send every 5 seconds, not instant)
- Use Server-Sent Events (SSE) instead of WebSocket when possible

**Savings:** 40-60% reduction in real-time connection costs

---

##### 7. Smart Data Storage

**Strategy:**
- Store only shared goals in cloud (solo goals stay local)
- Compress JSON payloads
- Use efficient data types (UUIDs, timestamps, enums)

**Example:**
```
Per user data (shared goals only):
- 10 shared goals × 30 days × 1KB = 300KB
- 100K users = 30GB (fits in Supabase Pro tier)
```

---

#### Recommended Hosting Strategy by Scale

##### Phase 1: MVP (0-10K users)
**Recommended: Supabase Free Tier**
- Cost: **$0/month**
- Why: Generous free tier, easy setup, includes auth + real-time
- When to upgrade: When approaching 500MB database or 2GB bandwidth

---

##### Phase 2: Growth (10K-50K users)
**Recommended: Supabase Pro ($25/month)**
- Cost: **$25/month**
- Why: Still affordable, 8GB database, 50GB bandwidth
- Optimizations: Add caching, archive old data

---

##### Phase 3: Scale (50K-200K users)
**Recommended: Supabase Team ($100/month) OR AWS/GCP**
- Option A: Supabase Team - **$100/month**
  - Easiest, includes everything
  - 32GB database, 250GB bandwidth
  
- Option B: AWS RDS + Lambda - **$40-80/month**
  - More control, potentially cheaper
  - Requires more setup/maintenance

**Decision:** Choose based on team expertise
- Small team → Supabase
- DevOps expertise → AWS/GCP

---

##### Phase 4: High Scale (200K+ users)
**Recommended: AWS or Google Cloud (Self-managed)**
- Cost: **$100-300/month**
- Why: More cost-effective at scale, full control
- Setup: RDS/Cloud SQL + Cloud Run/Lambda + CloudFront/Cloudflare

---

#### Cost Comparison Summary

| Users | Supabase | Firebase | AWS | GCP | Railway |
|-------|----------|----------|-----|-----|---------|
| **10K** | $0 | $0 | $0* | $0* | $5 |
| **50K** | $25 | $150 | $40 | $20 | $50 |
| **100K** | $100 | $300 | $80 | $50 | $100 |
| **200K** | $200 | $600 | $150 | $100 | $200 |
| **500K** | Custom | $1,500 | $300 | $200 | N/A |

*First 12 months free tier

**Winner by Scale:**
- **0-50K users:** Supabase (free/low cost, easy)
- **50K-200K users:** Supabase or AWS/GCP (depends on expertise)
- **200K+ users:** AWS or GCP (more cost-effective)

---

#### Final Recommendation

**For TaskTrakr Post-MVP:**

1. **Start with Supabase Free Tier** ($0/month)
   - Covers MVP needs
   - Easy setup
   - Includes auth + real-time

2. **Upgrade to Supabase Pro** ($25/month) when:
   - Database > 400MB
   - Bandwidth > 1.5GB/month
   - Need daily backups

3. **Consider AWS/GCP** ($40-100/month) when:
   - 200K+ users
   - Need more control
   - Have DevOps expertise
   - Want to optimize costs further

4. **Cost Minimization:**
   - Archive old data (90+ days)
   - Cache aggregate stats
   - Use CDN for static assets
   - Batch operations
   - Store only shared goals in cloud

**Expected Monthly Costs:**
- MVP (0-10K): **$0**
- Growth (10K-50K): **$25**
- Scale (50K-200K): **$100**
- High Scale (200K+): **$100-300**

**Total Annual Cost Estimate:**
- Year 1: **$0-300** (mostly free tier)
- Year 2: **$300-1,200** (growth phase)
- Year 3+: **$1,200-3,600** (scale phase)

---

### D. Comprehensive Cost Minimization Strategy

> **Critical for Free, Ad-Free App:** This section outlines aggressive cost minimization strategies to keep the app sustainable without ads or subscriptions.

#### Cost Breakdown by Component

**Monthly Costs (100K users, 10% use shared goals):**

| Component | Without Optimization | With Optimization | Savings |
|-----------|---------------------|-------------------|---------|
| **Database Storage** | $50-100 | $10-20 | 80% |
| **Bandwidth** | $50-100 | $5-10 | 90% |
| **API Calls** | $30-50 | $5-10 | 80% |
| **Real-time Connections** | $20-40 | $5-10 | 75% |
| **AI (Gemini)** | $0-20 | $0-5 | 75% |
| **Total** | **$150-310** | **$25-55** | **83%** |

**Target: Keep costs under $50/month for first 100K users**

---

#### Strategy 1: Maximize Free Tiers (Critical)

##### Use Multiple Free Tiers Simultaneously

**Stack Free Tiers:**
```
Supabase Free Tier (500MB DB, 2GB bandwidth)
    +
Cloudflare Workers Free (100K requests/day)
    +
Cloudflare R2 Free (10GB storage)
    +
Upstash Redis Free (10K commands/day)
    +
Cloudflare KV Free (100K reads/day)
```

**Combined Free Capacity:**
- Database: 500MB (Supabase)
- Bandwidth: 2GB (Supabase) + unlimited CDN (Cloudflare)
- Storage: 10GB (Cloudflare R2)
- Cache: 10K commands/day (Upstash)
- API Proxy: 100K requests/day (Cloudflare Workers)

**Savings:** $0-50/month for first 10K-20K users

**Implementation:**
- Use Supabase for database + auth
- Use Cloudflare Workers for API proxy (hide Gemini API key)
- Use Cloudflare R2 for avatar/image storage
- Use Upstash Redis for caching (free tier)
- Use Cloudflare KV for edge caching

---

#### Strategy 2: Aggressive Data Minimization

##### Keep Solo Goals 100% Local

**Rule:** Never sync solo goals to cloud. Only shared goals go to cloud.

**Impact:**
- 90% of users only use solo goals → 0 cloud cost
- Only 10% of users share goals → minimal cloud usage

**Data Per User (Shared Goals Only):**
```
1 shared goal = ~50KB (metadata + 30 days tasks)
10 shared goals = ~500KB per user
100K users × 10% sharing × 500KB = 5GB total
```

**Fits in:** Supabase Free Tier (500MB) → Pro Tier ($25/month) for 100K users

**Savings:** 90% reduction in storage costs

---

##### Archive Old Data Aggressively

**Strategy:**
- Completed goals older than 60 days → Archive to cold storage
- Inactive shared goals (30+ days no activity) → Archive
- Old aggregates (keep only last 90 days) → Delete older

**Archive to Cloudflare R2:**
- Cost: $0.015/GB/month (vs $0.06/GB for database)
- 75% cheaper than active database storage

**Implementation:**
```sql
-- Archive completed goals older than 60 days
CREATE OR REPLACE FUNCTION archive_old_goals()
RETURNS void AS $$
BEGIN
  INSERT INTO archived_goals
  SELECT * FROM user_goals
  WHERE end_date < NOW() - INTERVAL '60 days'
    AND is_completed = TRUE;
  
  DELETE FROM user_goals
  WHERE end_date < NOW() - INTERVAL '60 days'
    AND is_completed = TRUE;
END;
$$ LANGUAGE plpgsql;

-- Run weekly via cron
```

**Savings:** 60-70% reduction in active database size

---

##### Compress Data Aggressively

**Strategies:**
- Compress JSON fields (gzip before storing)
- Use enums instead of strings (saves 50-70% space)
- Store dates as integers (Unix timestamp)
- Remove null fields (don't store nulls)

**Example:**
```dart
// Before compression: ~2KB per day plan
{
  "task": "Read Juz 5 (20 pages)",
  "task_short": "Read Juz 5",
  "notes": "Surah An-Nisa verses 24-147",
  "intensity": "moderate",
  "ramadan_phase": "mercy"
}

// After compression: ~500 bytes
{
  "t": "Read Juz 5 (20 pages)",  // Shortened keys
  "ts": "Read Juz 5",
  "n": "Surah An-Nisa verses 24-147",
  "i": 1,  // Enum: 0=light, 1=moderate, 2=intense
  "rp": 0  // Enum: 0=mercy, 1=forgiveness, 2=salvation
}
```

**Savings:** 60-75% reduction in storage size

---

#### Strategy 3: Aggressive Caching

##### Cache Everything Possible

**Cache Strategy:**

1. **Aggregate Stats** (Update every 15 minutes, not real-time)
   - Daily aggregates: Cache 15 minutes
   - Weekly aggregates: Cache 1 hour
   - Overall aggregates: Cache 1 hour

2. **User Profiles** (Cache 1 hour)
   - Display names, avatars
   - Participant lists

3. **Goal Previews** (Cache 5 minutes)
   - Shared goal metadata
   - Participant counts

4. **Static Data** (Cache forever)
   - Categories, duration options
   - Language lists

**Implementation:**
```dart
class CacheService {
  // Use Hive for local caching (free)
  final Box<String> _cacheBox;
  
  Future<T?> getCached<T>(String key, Duration ttl) async {
    final cached = _cacheBox.get(key);
    if (cached != null) {
      final data = jsonDecode(cached);
      final cachedAt = DateTime.parse(data['cached_at']);
      if (DateTime.now().difference(cachedAt) < ttl) {
        return data['value'] as T;
      }
    }
    return null;
  }
  
  Future<void> setCached(String key, dynamic value) async {
    await _cacheBox.put(key, jsonEncode({
      'value': value,
      'cached_at': DateTime.now().toIso8601String(),
    }));
  }
}
```

**Savings:** 70-80% reduction in database queries

---

##### Use Edge Caching (Cloudflare)

**Strategy:**
- Cache API responses at Cloudflare edge
- Cache static assets (avatars, images)
- Use Cloudflare KV for edge caching

**Cloudflare Free Tier:**
- 100K KV reads/day free
- Unlimited CDN bandwidth (free)
- 100K Workers requests/day free

**Implementation:**
```javascript
// Cloudflare Worker - Cache API responses
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const cacheKey = request.url;
  const cached = await caches.default.match(cacheKey);
  
  if (cached) {
    return cached; // Serve from cache
  }
  
  const response = await fetch(request);
  event.waitUntil(caches.default.put(cacheKey, response.clone()));
  return response;
}
```

**Savings:** 80-90% reduction in bandwidth costs

---

#### Strategy 4: Minimize Real-time Connections

##### Use Polling Instead of WebSockets When Possible

**Strategy:**
- Poll for updates every 30-60 seconds (not real-time)
- Only use WebSocket for active screens
- Disconnect WebSocket when app in background

**Impact:**
- Supabase Free: 200 concurrent connections
- With polling: Need 10-20 connections (for active users)
- 90% reduction in connection usage

**Implementation:**
```dart
class UpdateService {
  Timer? _pollTimer;
  
  void startPolling() {
    // Poll every 30 seconds instead of WebSocket
    _pollTimer = Timer.periodic(Duration(seconds: 30), (_) {
      _fetchUpdates();
    });
  }
  
  void stopPolling() {
    _pollTimer?.cancel();
  }
  
  // Only use WebSocket when user is actively viewing shared goal
  void connectWebSocket(String sharedGoalId) {
    // Connect only when needed
  }
}
```

**Savings:** 80-90% reduction in real-time connection costs

---

##### Batch Real-time Updates

**Strategy:**
- Collect updates for 5-10 seconds
- Send batched update (not individual)
- Reduces message count by 80-90%

**Savings:** 80-90% reduction in real-time message costs

---

#### Strategy 5: Optimize API Calls

##### Batch API Requests

**Strategy:**
- Batch multiple operations into single request
- Use GraphQL-style queries (fetch multiple resources at once)
- Reduce round trips

**Example:**
```dart
// Bad: Multiple requests
await api.getGoal(goalId);
await api.getParticipants(goalId);
await api.getAggregates(goalId);

// Good: Single batched request
await api.getGoalDetails(goalId, include: ['participants', 'aggregates']);
```

**Savings:** 60-70% reduction in API calls

---

##### Rate Limiting (Client-Side)

**Strategy:**
- Limit API calls per user per minute
- Cache responses aggressively
- Queue operations when rate limited

**Implementation:**
```dart
class RateLimitedApi {
  final Map<String, DateTime> _lastCall = {};
  final int _maxCallsPerMinute = 10;
  
  Future<T> call<T>(String endpoint) async {
    final now = DateTime.now();
    final lastCall = _lastCall[endpoint];
    
    if (lastCall != null && now.difference(lastCall).inSeconds < 60) {
      // Rate limited - use cache or queue
      return _getCached(endpoint);
    }
    
    _lastCall[endpoint] = now;
    return await _makeRequest(endpoint);
  }
}
```

**Savings:** 50-60% reduction in API calls

---

#### Strategy 6: Minimize AI Costs

##### Use Templates Aggressively

**Strategy:**
- Build 50+ goal templates covering 80-90% of common goals
- Templates = 0 AI cost
- Only use AI for custom/uncommon goals

**Template Coverage:**
- 80% coverage = 80% cost reduction
- 90% coverage = 90% cost reduction
- 95% coverage = 95% cost reduction

**Cost Impact:**
```
Without templates: 100K users × 2 goals × $0.001 = $200/month
With 90% templates: 100K users × 2 goals × 10% × $0.001 = $20/month
Savings: $180/month (90% reduction)
```

**Implementation:**
```dart
class GoalService {
  Future<GoalPlan> generatePlan(String goalText) async {
    // 1. Try to match template first (free)
    final template = await _matchTemplate(goalText);
    if (template != null) {
      return template.customize(dates);
    }
    
    // 2. Only use AI if no template matches
    return await _generateWithAI(goalText);
  }
}
```

**Savings:** 80-95% reduction in AI costs

---

##### Use Gemini Free Tier Aggressively

**Gemini Free Tier Limits:**
- 15 requests per minute
- 1M tokens/month
- ~30K goal generations/month

**Strategy:**
- Stay within free tier limits
- Use templates to reduce AI calls
- Queue requests if rate limited (don't fail)

**Savings:** $0 AI cost for first 30K-50K users

---

#### Strategy 7: Optimize Database Queries

##### Use Efficient Indexes

**Strategy:**
- Index only frequently queried columns
- Use partial indexes (WHERE clauses)
- Remove unused indexes

**Example:**
```sql
-- Efficient: Partial index for active goals only
CREATE INDEX idx_active_shared_goals 
ON shared_goals(shared_by, created_at DESC) 
WHERE is_sharing_active = TRUE;

-- Inefficient: Full index
CREATE INDEX idx_all_shared_goals 
ON shared_goals(shared_by, created_at DESC);
```

**Savings:** 30-40% reduction in query time, less database load

---

##### Use Connection Pooling

**Strategy:**
- Reuse database connections
- Limit connection pool size
- Use Supabase connection pooling (built-in)

**Savings:** 20-30% reduction in database overhead

---

#### Strategy 8: Minimize Bandwidth

##### Compress API Responses

**Strategy:**
- Enable gzip compression on all API responses
- Use binary formats for large payloads
- Minimize response sizes

**Implementation:**
```dart
// Compress large responses
final compressed = gzip.encode(utf8.encode(jsonEncode(data)));
response.headers['Content-Encoding'] = 'gzip';
```

**Savings:** 70-80% reduction in bandwidth

---

##### Use CDN for Everything

**Strategy:**
- Serve all static assets via Cloudflare CDN (free)
- Cache API responses at edge
- Use Cloudflare R2 for file storage

**Cloudflare Free:**
- Unlimited CDN bandwidth
- 10GB R2 storage
- 100K Workers requests/day

**Savings:** 90-95% reduction in bandwidth costs

---

#### Strategy 9: Smart Sync Strategy

##### Sync Only When Needed

**Strategy:**
- Sync on app open (not continuously)
- Sync when user makes changes
- Batch sync operations
- Skip sync if no changes

**Implementation:**
```dart
class SyncService {
  DateTime? _lastSync;
  
  Future<void> syncIfNeeded() async {
    // Only sync if last sync was > 5 minutes ago
    if (_lastSync != null && 
        DateTime.now().difference(_lastSync!).inMinutes < 5) {
      return; // Skip sync
    }
    
    await sync();
    _lastSync = DateTime.now();
  }
}
```

**Savings:** 70-80% reduction in sync operations

---

##### Optimistic Updates

**Strategy:**
- Update UI immediately (optimistic)
- Sync in background
- Don't wait for server response

**Savings:** Better UX + reduced perceived latency

---

#### Strategy 10: Data Retention Policies

##### Auto-Delete Old Data

**Strategy:**
- Delete completed goals older than 90 days (unless user exports)
- Delete inactive accounts (1 year no login)
- Delete old aggregates (keep only last 90 days)

**Implementation:**
```sql
-- Auto-cleanup job (run weekly)
CREATE OR REPLACE FUNCTION cleanup_old_data()
RETURNS void AS $$
BEGIN
  -- Delete completed goals older than 90 days
  DELETE FROM user_goals
  WHERE end_date < NOW() - INTERVAL '90 days'
    AND is_completed = TRUE;
  
  -- Delete old aggregates (keep last 90 days)
  DELETE FROM goal_aggregates
  WHERE date < NOW() - INTERVAL '90 days';
  
  -- Archive inactive shared goals
  UPDATE shared_goals
  SET is_sharing_active = FALSE
  WHERE updated_at < NOW() - INTERVAL '30 days'
    AND is_sharing_active = TRUE;
END;
$$ LANGUAGE plpgsql;
```

**Savings:** 50-60% reduction in storage over time

---

#### Strategy 11: Use Free Alternatives

##### Free Services Stack

**Complete Free Stack:**
```
Database: Supabase Free (500MB, 2GB bandwidth)
Cache: Upstash Redis Free (10K commands/day)
Storage: Cloudflare R2 Free (10GB)
CDN: Cloudflare Free (unlimited bandwidth)
API Proxy: Cloudflare Workers Free (100K requests/day)
Edge Cache: Cloudflare KV Free (100K reads/day)
AI: Gemini Free Tier (1M tokens/month)
Auth: Supabase Auth Free (unlimited users)
```

**Total Cost:** $0/month for first 10K-20K users

---

#### Strategy 12: Monitor and Alert

##### Cost Monitoring

**Track:**
- Database size (alert at 400MB on free tier)
- Bandwidth usage (alert at 1.5GB on free tier)
- API call counts
- Real-time connections

**Alerts:**
- Set up alerts at 80% of free tier limits
- Automatically archive data when approaching limits
- Notify before upgrading tier

**Implementation:**
```dart
class CostMonitor {
  Future<void> checkLimits() async {
    final dbSize = await getDatabaseSize();
    final bandwidth = await getBandwidthUsage();
    
    if (dbSize > 400 * 1024 * 1024) { // 400MB
      await archiveOldData(); // Auto-archive
      sendAlert('Database approaching limit');
    }
    
    if (bandwidth > 1.5 * 1024 * 1024 * 1024) { // 1.5GB
      await optimizeBandwidth(); // Enable compression
      sendAlert('Bandwidth approaching limit');
    }
  }
}
```

---

#### Cost Minimization Checklist

**Before Launch:**
- [ ] Set up Supabase Free Tier
- [ ] Configure Cloudflare Workers (free API proxy)
- [ ] Set up Cloudflare R2 for file storage (free)
- [ ] Implement aggressive caching
- [ ] Build 50+ goal templates (reduce AI costs)
- [ ] Set up data archiving (auto-delete old data)
- [ ] Enable gzip compression
- [ ] Use CDN for all static assets
- [ ] Implement rate limiting
- [ ] Set up cost monitoring alerts

**Ongoing:**
- [ ] Monitor database size weekly
- [ ] Monitor bandwidth usage weekly
- [ ] Archive old data monthly
- [ ] Review and optimize queries monthly
- [ ] Add more templates (reduce AI usage)
- [ ] Optimize cache TTLs based on usage

---

#### Expected Cost Progression

**With All Optimizations:**

| Users | Database | Bandwidth | API Calls | AI | Total |
|-------|----------|-----------|-----------|----|----|
| **10K** | $0 (free) | $0 (free) | $0 (free) | $0 (free) | **$0** |
| **50K** | $0-25 | $0 (CDN) | $0 (free) | $0-5 | **$0-30** |
| **100K** | $25 | $0 (CDN) | $0 (free) | $5-10 | **$30-35** |
| **200K** | $100 | $0 (CDN) | $0-10 | $10-20 | **$110-130** |
| **500K** | $200 | $0-20 | $10-20 | $20-50 | **$250-290** |

**Key:** Aggressive optimization keeps costs 70-80% lower than unoptimized

---

#### Critical Rules for Cost Minimization

1. **Never sync solo goals** → 90% of users = 0 cloud cost
2. **Archive aggressively** → Keep only last 60-90 days active
3. **Cache everything** → 70-80% reduction in queries
4. **Use templates** → 80-95% reduction in AI costs
5. **CDN for all assets** → 90% reduction in bandwidth
6. **Poll instead of WebSocket** → 80% reduction in connections
7. **Batch operations** → 60-70% reduction in API calls
8. **Monitor limits** → Auto-archive before hitting limits
9. **Use free tiers** → Stack multiple free tiers
10. **Compress data** → 60-75% reduction in storage

---

#### Emergency Cost Reduction

**If Approaching Budget:**

1. **Immediate (Same Day):**
   - Archive all completed goals older than 30 days
   - Reduce cache TTLs (more frequent updates)
   - Disable real-time (use polling only)
   - Enable aggressive compression

2. **Short-term (This Week):**
   - Add more templates (reduce AI usage)
   - Implement stricter rate limiting
   - Archive inactive shared goals
   - Optimize database queries

3. **Long-term (This Month):**
   - Migrate to self-hosted (if scale justifies)
   - Implement data retention policies
   - Add user data export (reduce support burden)
   - Consider optional premium features (if needed)

---

#### Success Metrics

**Cost Targets:**

| Metric | Target | Alert Threshold |
|--------|--------|----------------|
| Monthly cost (10K users) | $0 | $10 |
| Monthly cost (50K users) | $0-25 | $40 |
| Monthly cost (100K users) | $25-50 | $75 |
| Database size (free tier) | <400MB | 450MB |
| Bandwidth (free tier) | <1.5GB | 1.8GB |
| AI costs | $0-10 | $20 |

**Goal:** Keep total costs under $50/month for first 100K users

---

## Conclusion

Shared Goals transforms TaskTrakr from a personal tool into a collaborative platform. This PRD outlines a simpler, more organic approach: goals start as individual, then become shared when others accept them. This balances features, technical complexity, and user experience while maintaining the app's core simplicity.

**Next Steps:**
1. Review and approve this PRD
2. Finalize technical decisions (backend, real-time)
3. Create detailed technical specifications
4. Begin Phase 1 implementation
5. User testing after Phase 3

**Estimated Timeline:** 12 weeks from start to production-ready feature.

---

**Document Version:** 1.3  
**Last Updated:** 2026-02-15  
**Author:** TaskTrakr Team  
**Status:** Draft - Pending Review

---

## Changelog

**v1.3 (2026-02-15):**
- Added comprehensive cost minimization strategy section
- 12 detailed strategies to minimize costs for free, ad-free app
- Cost breakdown by component with optimization savings
- Free tier stacking strategy (multiple free tiers)
- Aggressive data minimization (keep solo goals local)
- Caching strategies (70-80% query reduction)
- AI cost reduction (templates + free tier)
- Bandwidth optimization (CDN, compression)
- Real-time optimization (polling vs WebSocket)
- Data archiving and retention policies
- Cost monitoring and alerting
- Emergency cost reduction procedures
- Target: Keep costs under $50/month for first 100K users

**v1.2 (2026-02-15):**
- Added comprehensive social media-based login discussion
- Detailed analysis of Google, Apple, and Facebook login
- Implementation strategies and code examples
- Privacy and security considerations
- Regional considerations for Middle East/Muslim users
- Cost analysis for social login (free)
- Updated database schema to support multiple auth providers
- Updated API endpoints for OAuth flows
- Recommendations: Google + Apple as primary, Facebook optional

**v1.1 (2026-02-15):**
- Added comprehensive hosting & cost analysis section
- Updated technical architecture with cost recommendations
- Added cost minimization strategies
- Included detailed cost breakdowns by scale for all major providers
- Recommended Supabase as primary hosting solution (cost-effective, easy setup)

**v1.0 (2026-02-15):**
- Initial PRD for shared goals feature
- Simplified approach: goals start individual, become shared when accepted
- Aggregate stats for multiple participants
