/// Represents a duration option for goals
class DurationOption {
  final int days;
  final String localizationKey;

  const DurationOption({
    required this.days,
    required this.localizationKey,
  });

  /// All available duration options
  static const List<DurationOption> all = [
    DurationOption(days: 7, localizationKey: 'days7'),
    DurationOption(days: 14, localizationKey: 'days14'),
    DurationOption(days: 21, localizationKey: 'days21'),
    DurationOption(days: 30, localizationKey: 'days30'),
    DurationOption(days: 60, localizationKey: 'days60'),
    DurationOption(days: 90, localizationKey: 'days90'),
  ];

  /// Find duration by days
  static DurationOption? findByDays(int days) {
    try {
      return all.firstWhere((d) => d.days == days);
    } catch (_) {
      return null;
    }
  }
}
