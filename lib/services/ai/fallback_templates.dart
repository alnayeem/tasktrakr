import 'models/ai_response.dart';

/// Fallback templates for when AI is unavailable
class FallbackTemplates {
  FallbackTemplates._();

  static List<FallbackTemplate> get templates => [
        quranIn30Days,
        prayFiveDaily,
        run5k,
        readOneBook,
        meditateDaily,
      ];

  /// Get template by category
  static FallbackTemplate? getByCategory(String category) {
    return templates.where((t) => t.category == category).firstOrNull;
  }

  /// Get template by ID
  static FallbackTemplate? getById(String id) {
    return templates.where((t) => t.id == id).firstOrNull;
  }

  // Quran completion template
  static FallbackTemplate get quranIn30Days => FallbackTemplate(
        id: 'quran-30-days',
        title: 'Complete Reading the Quran in 30 Days',
        titleShort: 'Read Quran',
        category: 'ramadan',
        description:
            'Read one Juz per day to complete the entire Quran in Ramadan.',
        icon: '📖',
        durationDays: 30,
        difficulty: 'moderate',
        tips: const [
          'Read after Fajr when your mind is fresh',
          'Use a translation to understand the meaning',
          'Set a fixed time each day for consistency',
          'Listen to recitation while reading to improve tajweed',
        ],
        dayPlans: _generateQuranPlan(),
      );

  // Daily prayers template
  static FallbackTemplate get prayFiveDaily => FallbackTemplate(
        id: 'pray-five-30-days',
        title: 'Pray Five Times Daily for 30 Days',
        titleShort: 'Daily Prayers',
        category: 'ramadan',
        description:
            'Establish the habit of praying all five daily prayers on time.',
        icon: '🕌',
        durationDays: 30,
        difficulty: 'moderate',
        tips: const [
          'Set phone alarms for each prayer time',
          'Prepare your prayer space in advance',
          'Start with focusing on just praying, quality will follow',
          'If you miss one, pray it as soon as you remember',
        ],
        dayPlans: _generatePrayerPlan(),
      );

  // Running 5K template
  static FallbackTemplate get run5k => FallbackTemplate(
        id: 'run-5k-30-days',
        title: 'Run Your First 5K in 30 Days',
        titleShort: 'Run 5K',
        category: 'fitness',
        description: 'A progressive running program to complete a 5K run.',
        icon: '🏃',
        durationDays: 30,
        difficulty: 'moderate',
        tips: const [
          'Always warm up before running',
          'Listen to your body and rest when needed',
          'Stay hydrated throughout the day',
          'Get proper running shoes to prevent injury',
        ],
        dayPlans: _generateRunningPlan(),
      );

  // Reading template
  static FallbackTemplate get readOneBook => FallbackTemplate(
        id: 'read-book-30-days',
        title: 'Read One Book in 30 Days',
        titleShort: 'Read Book',
        category: 'learning',
        description:
            'Complete reading a book by reading consistently each day.',
        icon: '📚',
        durationDays: 30,
        difficulty: 'easy',
        tips: const [
          'Choose a book you\'re genuinely interested in',
          'Read at the same time each day to build habit',
          'Take notes on key insights',
          'Discuss what you read with others',
        ],
        dayPlans: _generateReadingPlan(),
      );

  // Meditation template
  static FallbackTemplate get meditateDaily => FallbackTemplate(
        id: 'meditate-30-days',
        title: 'Meditate Daily for 30 Days',
        titleShort: 'Meditate',
        category: 'wellness',
        description:
            'Build a daily meditation practice starting with just 5 minutes.',
        icon: '🧘',
        durationDays: 30,
        difficulty: 'easy',
        tips: const [
          'Start with just 5 minutes, increase gradually',
          'Find a quiet, comfortable spot',
          'Focus on your breath when mind wanders',
          'Be patient with yourself - wandering is normal',
        ],
        dayPlans: _generateMeditationPlan(),
      );
}

/// A fallback goal template
class FallbackTemplate {
  final String id;
  final String title;
  final String titleShort;
  final String category;
  final String description;
  final String icon;
  final int durationDays;
  final String difficulty;
  final List<AIDayPlan> dayPlans;
  final List<String> tips;

  const FallbackTemplate({
    required this.id,
    required this.title,
    required this.titleShort,
    required this.category,
    required this.description,
    required this.icon,
    required this.durationDays,
    required this.difficulty,
    required this.dayPlans,
    required this.tips,
  });

  TaskTrakrPlanResponse toResponse() {
    return TaskTrakrPlanResponse(
      success: true,
      goal: AIGoal(
        title: title,
        titleShort: titleShort,
        category: category,
        durationDays: durationDays,
        difficulty: difficulty,
        description: description,
        iconSuggestion: icon,
      ),
      dayPlans: dayPlans,
      tips: tips,
    );
  }
}

// ============================================================================
// PLAN GENERATORS
// ============================================================================

List<AIDayPlan> _generateQuranPlan() {
  return const [
    AIDayPlan(day: 1, task: 'Read Juz 1 (Al-Fatihah to Al-Baqarah 141)', taskShort: 'Juz 1', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 2, task: 'Read Juz 2 (Al-Baqarah 142-252)', taskShort: 'Juz 2', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 3, task: 'Read Juz 3 (Al-Baqarah 253 to Al-Imran 92)', taskShort: 'Juz 3', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 4, task: 'Read Juz 4 (Al-Imran 93 to An-Nisa 23)', taskShort: 'Juz 4', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 5, task: 'Read Juz 5 (An-Nisa 24-147)', taskShort: 'Juz 5', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 6, task: 'Read Juz 6 (An-Nisa 148 to Al-Maidah 81)', taskShort: 'Juz 6', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 7), // Rest day
    AIDayPlan(day: 8, task: 'Read Juz 7 (Al-Maidah 82 to Al-Anam 110)', taskShort: 'Juz 7', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 9, task: 'Read Juz 8 (Al-Anam 111 to Al-Araf 87)', taskShort: 'Juz 8', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 10, task: 'Read Juz 9 (Al-Araf 88 to Al-Anfal 40)', taskShort: 'Juz 9', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'mercy'),
    AIDayPlan(day: 11, task: 'Read Juz 10 (Al-Anfal 41 to At-Tawbah 92)', taskShort: 'Juz 10', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 12, task: 'Read Juz 11 (At-Tawbah 93 to Hud 5)', taskShort: 'Juz 11', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 13, task: 'Read Juz 12 (Hud 6 to Yusuf 52)', taskShort: 'Juz 12', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 14), // Rest day
    AIDayPlan(day: 15, task: 'Read Juz 13 (Yusuf 53 to Ibrahim 52)', taskShort: 'Juz 13', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 16, task: 'Read Juz 14 (Al-Hijr 1 to An-Nahl 128)', taskShort: 'Juz 14', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 17, task: 'Read Juz 15 (Al-Isra 1 to Al-Kahf 74)', taskShort: 'Juz 15', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 18, task: 'Read Juz 16 (Al-Kahf 75 to Ta-Ha 135)', taskShort: 'Juz 16', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 19, task: 'Read Juz 17 (Al-Anbiya 1 to Al-Hajj 78)', taskShort: 'Juz 17', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 20, task: 'Read Juz 18 (Al-Muminun 1 to Al-Furqan 20)', taskShort: 'Juz 18', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'forgiveness'),
    AIDayPlan(day: 21, task: 'Read Juz 19 (Al-Furqan 21 to An-Naml 55)', taskShort: 'Juz 19', estimatedMinutes: 60, intensity: 'intense', ramadanPhase: 'salvation', isLaylaulQadrNight: true),
    AIDayPlan(day: 22, task: 'Read Juz 20 (An-Naml 56 to Al-Ankabut 45)', taskShort: 'Juz 20', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'salvation'),
    AIDayPlan(day: 23, task: 'Read Juz 21 (Al-Ankabut 46 to Al-Ahzab 30)', taskShort: 'Juz 21', estimatedMinutes: 60, intensity: 'intense', ramadanPhase: 'salvation', isLaylaulQadrNight: true),
    AIDayPlan(day: 24, task: 'Read Juz 22 (Al-Ahzab 31 to Ya-Sin 27)', taskShort: 'Juz 22', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'salvation'),
    AIDayPlan(day: 25, task: 'Read Juz 23 (Ya-Sin 28 to Az-Zumar 31)', taskShort: 'Juz 23', estimatedMinutes: 60, intensity: 'intense', ramadanPhase: 'salvation', isLaylaulQadrNight: true),
    AIDayPlan(day: 26, task: 'Read Juz 24 (Az-Zumar 32 to Fussilat 46)', taskShort: 'Juz 24', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'salvation'),
    AIDayPlan(day: 27, task: 'Read Juz 25 (Fussilat 47 to Al-Jathiyah 37)', taskShort: 'Juz 25', estimatedMinutes: 60, intensity: 'intense', ramadanPhase: 'salvation', isLaylaulQadrNight: true),
    AIDayPlan(day: 28, task: 'Read Juz 26 (Al-Ahqaf 1 to Adh-Dhariyat 30)', taskShort: 'Juz 26', estimatedMinutes: 45, intensity: 'moderate', ramadanPhase: 'salvation'),
    AIDayPlan(day: 29, task: 'Read Juz 27-28 (Adh-Dhariyat 31 to Al-Mujadila)', taskShort: 'Juz 27-28', estimatedMinutes: 90, intensity: 'intense', ramadanPhase: 'salvation', isLaylaulQadrNight: true),
    AIDayPlan(day: 30, task: 'Read Juz 29-30 (Al-Mulk to An-Nas) - Complete!', taskShort: 'Juz 29-30', estimatedMinutes: 90, intensity: 'intense', ramadanPhase: 'salvation'),
  ];
}

List<AIDayPlan> _generatePrayerPlan() {
  final List<AIDayPlan> plans = [];

  for (int i = 0; i < 30; i++) {
    final day = i + 1;
    final isRestDay = day == 7 || day == 14 || day == 21 || day == 28;

    if (isRestDay) {
      plans.add(AIDayPlan(day: day));
      continue;
    }

    String phase = 'mercy';
    if (day > 20) {
      phase = 'salvation';
    } else if (day > 10) {
      phase = 'forgiveness';
    }

    final isQadrNight = [21, 23, 25, 27, 29].contains(day);

    plans.add(AIDayPlan(
      day: day,
      task: 'Pray all 5 daily prayers: Fajr, Dhuhr, Asr, Maghrib, Isha',
      taskShort: '5 Prayers',
      estimatedMinutes: isQadrNight ? 60 : 45,
      intensity: isQadrNight ? 'intense' : 'moderate',
      ramadanPhase: phase,
      isLaylaulQadrNight: isQadrNight,
      notes: isQadrNight ? 'Add extra prayers and duas tonight' : null,
    ));
  }

  return plans;
}

List<AIDayPlan> _generateRunningPlan() {
  return const [
    // Week 1: Walk/Run intervals
    AIDayPlan(day: 1, task: 'Walk 5 min, Run 1 min x 5, Walk 5 min', taskShort: 'W5/R1 x5', estimatedMinutes: 20, intensity: 'light'),
    AIDayPlan(day: 2, task: 'Rest day - light stretching', taskShort: 'Rest', estimatedMinutes: 10, intensity: 'light'),
    AIDayPlan(day: 3, task: 'Walk 5 min, Run 1 min x 6, Walk 5 min', taskShort: 'W5/R1 x6', estimatedMinutes: 22, intensity: 'light'),
    AIDayPlan(day: 4), // Rest
    AIDayPlan(day: 5, task: 'Walk 5 min, Run 2 min x 4, Walk 5 min', taskShort: 'W5/R2 x4', estimatedMinutes: 23, intensity: 'moderate'),
    AIDayPlan(day: 6, task: 'Easy 20 min walk', taskShort: 'Walk 20', estimatedMinutes: 20, intensity: 'light'),
    AIDayPlan(day: 7), // Rest
    // Week 2
    AIDayPlan(day: 8, task: 'Walk 5 min, Run 2 min x 5, Walk 5 min', taskShort: 'W5/R2 x5', estimatedMinutes: 25, intensity: 'moderate'),
    AIDayPlan(day: 9, task: 'Rest day - light stretching', taskShort: 'Rest', estimatedMinutes: 10, intensity: 'light'),
    AIDayPlan(day: 10, task: 'Walk 5 min, Run 3 min x 4, Walk 5 min', taskShort: 'W5/R3 x4', estimatedMinutes: 27, intensity: 'moderate'),
    AIDayPlan(day: 11), // Rest
    AIDayPlan(day: 12, task: 'Walk 5 min, Run 3 min x 5, Walk 5 min', taskShort: 'W5/R3 x5', estimatedMinutes: 30, intensity: 'moderate'),
    AIDayPlan(day: 13, task: 'Easy 25 min walk', taskShort: 'Walk 25', estimatedMinutes: 25, intensity: 'light'),
    AIDayPlan(day: 14), // Rest
    // Week 3
    AIDayPlan(day: 15, task: 'Walk 5 min, Run 5 min x 3, Walk 5 min', taskShort: 'W5/R5 x3', estimatedMinutes: 30, intensity: 'moderate'),
    AIDayPlan(day: 16, task: 'Rest day - light stretching', taskShort: 'Rest', estimatedMinutes: 10, intensity: 'light'),
    AIDayPlan(day: 17, task: 'Walk 5 min, Run 7 min x 2, Walk 5 min', taskShort: 'W5/R7 x2', estimatedMinutes: 29, intensity: 'moderate'),
    AIDayPlan(day: 18), // Rest
    AIDayPlan(day: 19, task: 'Walk 5 min, Run 10 min, Walk 2 min, Run 5 min', taskShort: 'R10/R5', estimatedMinutes: 32, intensity: 'moderate'),
    AIDayPlan(day: 20, task: 'Easy 30 min walk', taskShort: 'Walk 30', estimatedMinutes: 30, intensity: 'light'),
    AIDayPlan(day: 21), // Rest
    // Week 4
    AIDayPlan(day: 22, task: 'Walk 5 min, Run 15 min, Walk 5 min', taskShort: 'Run 15', estimatedMinutes: 35, intensity: 'moderate'),
    AIDayPlan(day: 23, task: 'Rest day - light stretching', taskShort: 'Rest', estimatedMinutes: 10, intensity: 'light'),
    AIDayPlan(day: 24, task: 'Walk 5 min, Run 20 min, Walk 5 min', taskShort: 'Run 20', estimatedMinutes: 40, intensity: 'moderate'),
    AIDayPlan(day: 25), // Rest
    AIDayPlan(day: 26, task: 'Walk 5 min, Run 25 min, Walk 5 min', taskShort: 'Run 25', estimatedMinutes: 45, intensity: 'intense'),
    AIDayPlan(day: 27, task: 'Rest - prepare for 5K', taskShort: 'Rest', estimatedMinutes: 10, intensity: 'light'),
    AIDayPlan(day: 28), // Rest
    AIDayPlan(day: 29, task: 'Easy 20 min jog', taskShort: 'Jog 20', estimatedMinutes: 25, intensity: 'light'),
    AIDayPlan(day: 30, task: 'Run your 5K! Walk 5 min, Run 5K, Cool down', taskShort: '5K Run!', estimatedMinutes: 45, intensity: 'intense', notes: 'Congratulations! You did it!'),
  ];
}

List<AIDayPlan> _generateReadingPlan() {
  final List<AIDayPlan> plans = [];

  for (int i = 0; i < 30; i++) {
    final day = i + 1;
    final isRestDay = day == 7 || day == 14 || day == 21 || day == 28;

    if (isRestDay) {
      plans.add(AIDayPlan(day: day));
      continue;
    }

    // Assume ~300 page book, ~10 pages/day average
    final pages = 10 + (day ~/ 10); // Gradually increase

    plans.add(AIDayPlan(
      day: day,
      task: 'Read $pages pages of your book',
      taskShort: 'Read $pages pgs',
      estimatedMinutes: pages * 2, // ~2 min per page
      intensity: day > 20 ? 'moderate' : 'light',
    ));
  }

  return plans;
}

List<AIDayPlan> _generateMeditationPlan() {
  final List<AIDayPlan> plans = [];

  for (int i = 0; i < 30; i++) {
    final day = i + 1;
    final isRestDay = day == 7 || day == 14 || day == 21 || day == 28;

    if (isRestDay) {
      plans.add(AIDayPlan(day: day));
      continue;
    }

    // Progressive duration: 5 min week 1, 10 min week 2, 15 min week 3, 20 min week 4
    int minutes;
    if (day <= 7) {
      minutes = 5;
    } else if (day <= 14) {
      minutes = 10;
    } else if (day <= 21) {
      minutes = 15;
    } else {
      minutes = 20;
    }

    plans.add(AIDayPlan(
      day: day,
      task: 'Meditate for $minutes minutes',
      taskShort: '${minutes}min meditation',
      estimatedMinutes: minutes,
      intensity: minutes > 15 ? 'moderate' : 'light',
      notes: day == 1 ? 'Find a quiet space, sit comfortably, focus on breath' : null,
    ));
  }

  return plans;
}
