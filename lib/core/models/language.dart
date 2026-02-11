/// Represents a supported language in the app
class Language {
  final String code;
  final String flag;
  final String nativeName;
  final String englishName;
  final String continueText;
  final bool isRtl;

  const Language({
    required this.code,
    required this.flag,
    required this.nativeName,
    required this.englishName,
    required this.continueText,
    this.isRtl = false,
  });

  /// All supported languages (English first, then alphabetical)
  static const List<Language> supported = [
    Language(
      code: 'en',
      flag: '🇺🇸',
      nativeName: 'English',
      englishName: 'English',
      continueText: 'Continue',
    ),
    Language(
      code: 'ar',
      flag: '🇸🇦',
      nativeName: 'العربية',
      englishName: 'Arabic',
      continueText: 'التالي',
      isRtl: true,
    ),
    Language(
      code: 'id',
      flag: '🇮🇩',
      nativeName: 'Bahasa Indonesia',
      englishName: 'Indonesian',
      continueText: 'Lanjutkan',
    ),
    Language(
      code: 'ms',
      flag: '🇲🇾',
      nativeName: 'Bahasa Melayu',
      englishName: 'Malay',
      continueText: 'Teruskan',
    ),
    Language(
      code: 'bn',
      flag: '🇧🇩',
      nativeName: 'বাংলা',
      englishName: 'Bengali',
      continueText: 'শুরু করুন',
    ),
    Language(
      code: 'de',
      flag: '🇩🇪',
      nativeName: 'Deutsch',
      englishName: 'German',
      continueText: 'Weiter',
    ),
    Language(
      code: 'es',
      flag: '🇪🇸',
      nativeName: 'Español',
      englishName: 'Spanish',
      continueText: 'Continuar',
    ),
    Language(
      code: 'fr',
      flag: '🇫🇷',
      nativeName: 'Français',
      englishName: 'French',
      continueText: 'Continuer',
    ),
    Language(
      code: 'hi',
      flag: '🇮🇳',
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
      continueText: 'जारी रखें',
    ),
    Language(
      code: 'uz',
      flag: '🇺🇿',
      nativeName: "O'zbek",
      englishName: 'Uzbek',
      continueText: 'Davom etish',
    ),
    Language(
      code: 'tr',
      flag: '🇹🇷',
      nativeName: 'Türkçe',
      englishName: 'Turkish',
      continueText: 'Devam Et',
    ),
    Language(
      code: 'ur',
      flag: '🇵🇰',
      nativeName: 'اردو',
      englishName: 'Urdu',
      continueText: 'جاری رکھیں',
      isRtl: true,
    ),
  ];

  /// Find a language by its code
  static Language? findByCode(String code) {
    try {
      return supported.firstWhere((lang) => lang.code == code);
    } catch (_) {
      return null;
    }
  }

  /// Default language (English)
  static Language get defaultLanguage => supported.first;
}
