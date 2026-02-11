/// Context object for AI goal generation
class GoalContext {
  final String rawInput;
  final String language;
  final String category;
  final int durationDays;
  final String startDate;
  final String? difficulty;
  final String? specialMode;
  final RamadanContext? ramadan;

  const GoalContext({
    required this.rawInput,
    required this.language,
    required this.category,
    required this.durationDays,
    required this.startDate,
    this.difficulty,
    this.specialMode,
    this.ramadan,
  });

  bool get isRamadanMode => specialMode == 'ramadan' || category == 'ramadan';

  Map<String, dynamic> toJson() => {
        'raw_input': rawInput,
        'language': language,
        'category': category,
        'duration_days': durationDays,
        'start_date': startDate,
        if (difficulty != null) 'difficulty': difficulty,
        if (specialMode != null) 'special_mode': specialMode,
        if (ramadan != null) 'ramadan': ramadan!.toJson(),
      };

  factory GoalContext.fromJson(Map<String, dynamic> json) => GoalContext(
        rawInput: json['raw_input'] as String,
        language: json['language'] as String,
        category: json['category'] as String,
        durationDays: json['duration_days'] as int,
        startDate: json['start_date'] as String,
        difficulty: json['difficulty'] as String?,
        specialMode: json['special_mode'] as String?,
        ramadan: json['ramadan'] != null
            ? RamadanContext.fromJson(json['ramadan'] as Map<String, dynamic>)
            : null,
      );
}

/// Ramadan-specific context for Islamic goal planning
class RamadanContext {
  final String hijriStart;
  final List<int> laylaulQadrNights;

  const RamadanContext({
    required this.hijriStart,
    this.laylaulQadrNights = const [21, 23, 25, 27, 29],
  });

  Map<String, dynamic> toJson() => {
        'hijri_start': hijriStart,
        'laylatul_qadr_nights': laylaulQadrNights,
      };

  factory RamadanContext.fromJson(Map<String, dynamic> json) => RamadanContext(
        hijriStart: json['hijri_start'] as String,
        laylaulQadrNights: (json['laylatul_qadr_nights'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            const [21, 23, 25, 27, 29],
      );

  /// Default Ramadan context for 2026
  factory RamadanContext.ramadan2026() => const RamadanContext(
        hijriStart: '1447-09-01',
        laylaulQadrNights: [21, 23, 25, 27, 29],
      );
}
