/// Route definitions for the TaskTrakr app
/// Uses enum-based approach for type-safe routing
library;

/// Enum defining all routes in the app
enum AppRoute {
  // ============ Auth Routes ============

  /// Login screen
  login('/auth/login'),

  /// Sign up screen
  signUp('/auth/signup'),

  /// Password reset screen
  passwordReset('/auth/password-reset'),

  /// Email verification screen
  emailVerification('/auth/verify-email'),

  // ============ Onboarding Routes ============

  /// Onboarding - Language selection (first screen)
  languageSelection('/language'),

  /// Onboarding - Welcome screen after language selection
  welcome('/welcome'),

  // ============ Main App Routes ============

  /// Main dashboard showing today's tasks and goals
  dashboard('/dashboard'),

  /// Create a new goal
  goalCreation('/goal/create'),

  /// AI generating plan loading screen
  aiLoading('/goal/loading'),

  /// Goal detail view with progress and day plans
  goalDetail('/goal/:goalId'),

  /// App settings
  settings('/settings');

  /// The path pattern for this route
  final String path;

  const AppRoute(this.path);

  /// Get the route name (used for named navigation)
  String get routeName => name;

  /// Check if this is the initial route (language selection for new users)
  bool get isInitial => this == AppRoute.languageSelection;

  /// Check if this is an auth route
  bool get isAuthRoute => [
        AppRoute.login,
        AppRoute.signUp,
        AppRoute.passwordReset,
        AppRoute.emailVerification,
      ].contains(this);

  /// Check if this is an onboarding route
  bool get isOnboarding =>
      this == AppRoute.languageSelection || this == AppRoute.welcome;

  /// Check if this route requires authentication
  bool get requiresAuth => !isAuthRoute && !isOnboarding;

  /// Check if this route requires authentication/onboarding completion
  bool get requiresOnboardingComplete =>
      !isOnboarding && !isAuthRoute && this != AppRoute.languageSelection;

  /// Build the path with parameters substituted
  String buildPath({Map<String, String>? params}) {
    if (params == null || params.isEmpty) return path;

    String result = path;
    params.forEach((key, value) {
      result = result.replaceAll(':$key', value);
    });
    return result;
  }

  /// Get route by path
  static AppRoute? fromPath(String path) {
    // Remove query parameters for matching
    final pathWithoutQuery = path.split('?').first;

    for (final route in AppRoute.values) {
      if (_matchesPattern(route.path, pathWithoutQuery)) {
        return route;
      }
    }
    return null;
  }

  /// Check if a path matches a route pattern
  static bool _matchesPattern(String pattern, String path) {
    final patternSegments = pattern.split('/');
    final pathSegments = path.split('/');

    if (patternSegments.length != pathSegments.length) return false;

    for (int i = 0; i < patternSegments.length; i++) {
      final patternSeg = patternSegments[i];
      final pathSeg = pathSegments[i];

      // Skip parameter segments (they match anything)
      if (patternSeg.startsWith(':')) continue;

      if (patternSeg != pathSeg) return false;
    }
    return true;
  }
}

/// Extension methods for route navigation helpers
extension AppRouteNavigation on AppRoute {
  /// Navigate to goal detail with goal ID
  String withGoalId(String goalId) {
    if (this != AppRoute.goalDetail) {
      throw ArgumentError('withGoalId can only be used with goalDetail route');
    }
    return buildPath(params: {'goalId': goalId});
  }
}
