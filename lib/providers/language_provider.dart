import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/language.dart';

/// State class for language settings
class LanguageState {
  final String languageCode;
  final bool isRtl;
  final Locale locale;

  const LanguageState({
    required this.languageCode,
    required this.isRtl,
    required this.locale,
  });

  factory LanguageState.fromLanguage(Language language) {
    return LanguageState(
      languageCode: language.code,
      isRtl: language.isRtl,
      locale: Locale(language.code),
    );
  }

  factory LanguageState.defaultState() {
    return LanguageState.fromLanguage(Language.defaultLanguage);
  }

  LanguageState copyWith({
    String? languageCode,
    bool? isRtl,
    Locale? locale,
  }) {
    return LanguageState(
      languageCode: languageCode ?? this.languageCode,
      isRtl: isRtl ?? this.isRtl,
      locale: locale ?? this.locale,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageState && other.languageCode == languageCode;
  }

  @override
  int get hashCode => languageCode.hashCode;
}

/// Notifier for language state management
class LanguageNotifier extends StateNotifier<LanguageState> {
  LanguageNotifier() : super(LanguageState.defaultState());

  /// Set language by code
  void setLanguage(String languageCode) {
    final language = Language.findByCode(languageCode);
    if (language != null) {
      state = LanguageState.fromLanguage(language);
    }
  }

  /// Set language from Language model
  void setLanguageFromModel(Language language) {
    state = LanguageState.fromLanguage(language);
  }

  /// Get current language model
  Language? get currentLanguage => Language.findByCode(state.languageCode);
}

/// Provider for language state
final languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageState>((ref) {
  return LanguageNotifier();
});

/// Convenience provider for just the locale
final localeProvider = Provider<Locale>((ref) {
  return ref.watch(languageProvider).locale;
});

/// Convenience provider for RTL check
final isRtlProvider = Provider<bool>((ref) {
  return ref.watch(languageProvider).isRtl;
});

/// Convenience provider for language code
final languageCodeProvider = Provider<String>((ref) {
  return ref.watch(languageProvider).languageCode;
});
