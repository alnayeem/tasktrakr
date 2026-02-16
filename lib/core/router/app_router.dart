import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/password_reset_screen.dart';
import '../../features/auth/screens/email_verification_screen.dart';
import '../../features/onboarding/screens/language_selection_screen.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/goal_creation/screens/goal_creation_screen.dart';
import '../../features/goal_creation/screens/ai_loading_screen.dart';
import '../../features/goal_detail/screens/goal_detail_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../providers/auth_provider.dart';
import '../../providers/preferences_provider.dart';
import 'app_routes.dart';
import 'route_params.dart';

/// Provider for the GoRouter instance
/// This allows the router to be reactive to auth and onboarding state changes
final routerProvider = Provider<GoRouter>((ref) {
  final onboardingCompleted = ref.watch(onboardingCompletedProvider);
  final authStatus = ref.watch(authStatusProvider);
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final needsEmailVerification = ref.watch(needsEmailVerificationProvider);

  return GoRouter(
    navigatorKey: AppRouter._rootNavigatorKey,
    initialLocation: _getInitialLocation(
      isAuthenticated,
      onboardingCompleted,
      authStatus,
      needsEmailVerification,
    ),
    debugLogDiagnostics: true,
    routes: AppRouter._routes,
    errorBuilder: AppRouter._errorBuilder,
    redirect: (context, state) => AppRouter._redirect(
      context,
      state,
      onboardingCompleted,
      isAuthenticated,
      authStatus,
      needsEmailVerification,
    ),
  );
});

/// Determine initial location based on auth and onboarding state
String _getInitialLocation(
  bool isAuthenticated,
  bool onboardingCompleted,
  AuthStatus authStatus,
  bool needsEmailVerification,
) {
  // Still loading auth state
  if (authStatus == AuthStatus.initial) {
    return AppRoute.login.path;
  }

  // Not authenticated
  if (!isAuthenticated) {
    return AppRoute.login.path;
  }

  // Needs email verification
  if (needsEmailVerification) {
    return AppRoute.emailVerification.path;
  }

  // Authenticated but needs onboarding
  if (!onboardingCompleted) {
    return AppRoute.languageSelection.path;
  }

  // Fully authenticated and onboarded
  return AppRoute.dashboard.path;
}

/// Main router configuration for the TaskTrakr app
/// Uses go_router with type-safe route definitions
/// Language is managed globally via Riverpod provider, not passed via routes
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// Navigate to a route by enum
  static void go(BuildContext context, AppRoute route,
      {Map<String, String>? params}) {
    context.go(route.buildPath(params: params));
  }

  /// Push a route onto the stack
  static void push(BuildContext context, AppRoute route,
      {Map<String, String>? params}) {
    context.push(route.buildPath(params: params));
  }

  /// Navigate to AI loading screen with parameters
  static void goToAILoading(BuildContext context, AILoadingParams params) {
    context.go('${AppRoute.aiLoading.path}?${params.toQueryString()}');
  }

  /// Navigate to goal detail screen
  static void goToGoalDetail(BuildContext context, String goalId) {
    context.go(AppRoute.goalDetail.withGoalId(goalId));
  }

  /// Push goal detail onto stack (for back navigation)
  static void pushGoalDetail(BuildContext context, String goalId) {
    context.push(AppRoute.goalDetail.withGoalId(goalId));
  }

  /// Route configuration - screens get language from provider, not from route
  static final List<RouteBase> _routes = [
    // Auth routes
    GoRoute(
      path: AppRoute.login.path,
      name: AppRoute.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoute.signUp.path,
      name: AppRoute.signUp.name,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoute.passwordReset.path,
      name: AppRoute.passwordReset.name,
      builder: (context, state) => const PasswordResetScreen(),
    ),
    GoRoute(
      path: AppRoute.emailVerification.path,
      name: AppRoute.emailVerification.name,
      builder: (context, state) => const EmailVerificationScreen(),
    ),

    // Onboarding routes
    GoRoute(
      path: AppRoute.languageSelection.path,
      name: AppRoute.languageSelection.name,
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: AppRoute.welcome.path,
      name: AppRoute.welcome.name,
      builder: (context, state) => const WelcomeScreen(),
    ),

    // Main app routes
    GoRoute(
      path: AppRoute.dashboard.path,
      name: AppRoute.dashboard.name,
      builder: (context, state) => const DashboardScreen(),
    ),

    // Goal routes
    GoRoute(
      path: AppRoute.goalCreation.path,
      name: AppRoute.goalCreation.name,
      builder: (context, state) => const GoalCreationScreen(),
    ),
    GoRoute(
      path: AppRoute.aiLoading.path,
      name: AppRoute.aiLoading.name,
      builder: (context, state) {
        final queryParams = state.uri.queryParameters;
        final params = AILoadingParams.fromQueryParams(queryParams);
        return AILoadingScreen(
          goalText: params.goalText,
          durationDays: params.durationDays,
          category: params.category,
        );
      },
    ),
    GoRoute(
      path: AppRoute.goalDetail.path,
      name: AppRoute.goalDetail.name,
      builder: (context, state) {
        final goalId = state.pathParameters['goalId'] ?? '';
        return GoalDetailScreen(goalId: goalId);
      },
    ),

    // Settings
    GoRoute(
      path: AppRoute.settings.path,
      name: AppRoute.settings.name,
      builder: (context, state) => const SettingsScreen(),
    ),
  ];

  /// Error page builder
  static Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.path}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoute.dashboard.path),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }

  /// Redirect logic for authentication/onboarding
  static String? _redirect(
    BuildContext context,
    GoRouterState state,
    bool onboardingCompleted,
    bool isAuthenticated,
    AuthStatus authStatus,
    bool needsEmailVerification,
  ) {
    final currentPath = state.uri.path;
    final currentRoute = AppRoute.fromPath(currentPath);

    // Still loading auth state - stay on current route
    if (authStatus == AuthStatus.initial || authStatus == AuthStatus.loading) {
      return null;
    }

    // ============ CASE 1: Not authenticated ============
    if (!isAuthenticated) {
      // Allow auth routes
      if (currentRoute != null && currentRoute.isAuthRoute) {
        return null;
      }
      // Redirect to login for any non-auth route
      return AppRoute.login.path;
    }

    // ============ CASE 2: Authenticated but needs email verification ============
    if (needsEmailVerification) {
      if (currentRoute == AppRoute.emailVerification) {
        return null;
      }
      return AppRoute.emailVerification.path;
    }

    // ============ CASE 3: Authenticated, on auth route ============
    if (currentRoute != null && currentRoute.isAuthRoute) {
      // Go to onboarding or dashboard
      return onboardingCompleted
          ? AppRoute.dashboard.path
          : AppRoute.languageSelection.path;
    }

    // ============ CASE 4: Authenticated, onboarding not complete ============
    if (!onboardingCompleted) {
      if (currentRoute != null && currentRoute.isOnboarding) {
        return null; // Allow onboarding routes
      }
      return AppRoute.languageSelection.path;
    }

    // ============ CASE 5: Fully authenticated and onboarded ============
    // Redirect away from onboarding routes
    if (currentRoute != null && currentRoute.isOnboarding) {
      return AppRoute.dashboard.path;
    }

    // Allow access to all other routes
    return null;
  }
}

/// Extension on BuildContext for convenient navigation
extension TaskTrakrNavigation on BuildContext {
  // Auth navigation
  void goToLogin() => go(AppRoute.login.path);
  void goToSignUp() => go(AppRoute.signUp.path);
  void goToPasswordReset() => go(AppRoute.passwordReset.path);
  void goToEmailVerification() => go(AppRoute.emailVerification.path);

  /// Navigate to language selection
  void goToLanguageSelection() => go(AppRoute.languageSelection.path);

  /// Navigate to welcome screen
  void goToWelcome() => go(AppRoute.welcome.path);

  /// Navigate to dashboard
  void goToDashboard() => go(AppRoute.dashboard.path);

  /// Navigate to goal creation
  void goToGoalCreation() => go(AppRoute.goalCreation.path);

  /// Push goal creation onto stack
  void pushGoalCreation() => push(AppRoute.goalCreation.path);

  /// Navigate to AI loading with parameters
  void goToAILoading(AILoadingParams params) {
    go('${AppRoute.aiLoading.path}?${params.toQueryString()}');
  }

  /// Navigate to goal detail
  void goToGoalDetail(String goalId) =>
      go(AppRoute.goalDetail.withGoalId(goalId));

  /// Push goal detail onto stack
  void pushGoalDetail(String goalId) =>
      push(AppRoute.goalDetail.withGoalId(goalId));

  /// Navigate to settings
  void goToSettings() => go(AppRoute.settings.path);

  /// Push settings onto stack
  void pushSettings() => push(AppRoute.settings.path);
}
