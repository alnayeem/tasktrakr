import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user_preferences.dart';
import 'repository_providers.dart';

/// State class for user preferences
class PreferencesState {
  final UserPreferences preferences;
  final bool isLoading;
  final String? error;
  final String? userId;

  const PreferencesState({
    required this.preferences,
    this.isLoading = false,
    this.error,
    this.userId,
  });

  factory PreferencesState.initial() {
    return PreferencesState(preferences: UserPreferences.defaults());
  }

  PreferencesState copyWith({
    UserPreferences? preferences,
    bool? isLoading,
    String? error,
    String? userId,
    bool clearUserId = false,
  }) {
    return PreferencesState(
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userId: clearUserId ? null : (userId ?? this.userId),
    );
  }

  // Convenience getters
  String get language => preferences.language;
  String get theme => preferences.theme;
  bool get onboardingCompleted => preferences.onboardingCompleted;
  bool get notificationsEnabled => preferences.notificationsEnabled;
  String? get reminderTime => preferences.reminderTime;
  bool get hapticsEnabled => preferences.hapticsEnabled;
  bool get soundEnabled => preferences.soundEnabled;
}

/// Notifier for managing user preferences
class PreferencesNotifier extends StateNotifier<PreferencesState> {
  final Ref _ref;
  String? _currentUserId;

  PreferencesNotifier(this._ref) : super(PreferencesState.initial()) {
    _loadPreferences();
  }

  /// Load preferences from repository for the current user
  void _loadPreferences({String? userId}) {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: userId);
      _currentUserId = userId;
      state = state.copyWith(preferences: prefs, isLoading: false, userId: userId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Load preferences for a specific user (called on sign-in)
  Future<void> loadForUser(String userId) async {
    final repository = _ref.read(preferencesRepositoryProvider);

    // Migrate default preferences to user if this is their first sign-in
    await repository.migrateDefaultPreferencesToUser(userId);

    _loadPreferences(userId: userId);
  }

  /// Clear user context (called on sign-out)
  void clearUserContext() {
    _currentUserId = null;
    _loadPreferences(userId: null);
  }

  /// Set language
  Future<void> setLanguage(String languageCode) async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.language = languageCode;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set theme
  Future<void> setTheme(String theme) async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.theme = theme;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Complete onboarding
  Future<void> completeOnboarding() async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.onboardingCompleted = true;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set notifications enabled
  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.notificationsEnabled = enabled;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set reminder time
  Future<void> setReminderTime(String? time) async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.reminderTime = time;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set haptics enabled
  Future<void> setHapticsEnabled(bool enabled) async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.hapticsEnabled = enabled;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set sound enabled
  Future<void> setSoundEnabled(bool enabled) async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      final prefs = repository.getPreferences(userId: _currentUserId);
      prefs.soundEnabled = enabled;
      await prefs.save();
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Reset to defaults
  Future<void> resetToDefaults() async {
    try {
      final repository = _ref.read(preferencesRepositoryProvider);
      await repository.resetToDefaults(userId: _currentUserId);
      _loadPreferences(userId: _currentUserId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Refresh preferences
  void refresh() => _loadPreferences(userId: _currentUserId);
}

/// Main preferences provider
final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>((ref) {
  return PreferencesNotifier(ref);
});

/// Provider for checking if onboarding is completed
final onboardingCompletedProvider = Provider<bool>((ref) {
  return ref.watch(preferencesProvider).onboardingCompleted;
});

/// Provider for current theme setting
final themeSettingProvider = Provider<String>((ref) {
  return ref.watch(preferencesProvider).theme;
});

/// Provider for ThemeMode based on preference
final themeModeProvider = Provider<ThemeMode>((ref) {
  final themeSetting = ref.watch(themeSettingProvider);
  switch (themeSetting) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
});

/// Provider for notifications enabled
final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(preferencesProvider).notificationsEnabled;
});

/// Provider for haptics enabled
final hapticsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(preferencesProvider).hapticsEnabled;
});

/// Provider for sound enabled
final soundEnabledProvider = Provider<bool>((ref) {
  return ref.watch(preferencesProvider).soundEnabled;
});
