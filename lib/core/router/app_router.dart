import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/screens/language_selection_screen.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/goal_creation/screens/goal_creation_screen.dart';
import '../../features/goal_creation/screens/ai_loading_screen.dart';
import '../../features/goal_detail/screens/goal_detail_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../providers/preferences_provider.dart';
import 'app_routes.dart';
import 'route_params.dart';

/// Provider for the GoRouter instance
/// This allows the router to be reactive to onboarding state changes
final routerProvider = Provider<GoRouter>((ref) {
  final onboardingCompleted = ref.watch(onboardingCompletedProvider);

  return GoRouter(
    navigatorKey: AppRouter._rootNavigatorKey,
    initialLocation: onboardingCompleted
        ? AppRoute.dashboard.path
        : AppRoute.languageSelection.path,
    debugLogDiagnostics: true,
    routes: AppRouter._routes,
    errorBuilder: AppRouter._errorBuilder,
    redirect: (context, state) => AppRouter._redirect(context, state, onboardingCompleted),
  );
});

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
  ) {
    final currentPath = state.uri.path;
    final currentRoute = AppRoute.fromPath(currentPath);

    // If onboarding is completed
    if (onboardingCompleted) {
      // Redirect away from onboarding routes to dashboard
      if (currentRoute != null && currentRoute.isOnboarding) {
        return AppRoute.dashboard.path;
      }
      // Allow access to all other routes
      return null;
    }

    // If onboarding is NOT completed
    // Allow access to onboarding routes
    if (currentRoute != null && currentRoute.isOnboarding) {
      return null;
    }

    // Redirect to language selection for any non-onboarding route
    return AppRoute.languageSelection.path;
  }
}

/// Extension on BuildContext for convenient navigation
extension TaskTrakrNavigation on BuildContext {
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
