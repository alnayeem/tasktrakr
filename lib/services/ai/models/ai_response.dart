/// Response from the AI goal generation service
class TaskTrakrPlanResponse {
  final bool success;
  final String? errorMessage;
  final AIGoal? goal;
  final List<AIDayPlan> dayPlans;
  final List<AIMilestone> milestones;
  final List<String> tips;
  final AIRamadanData? ramadanData;

  const TaskTrakrPlanResponse({
    required this.success,
    this.errorMessage,
    this.goal,
    this.dayPlans = const [],
    this.milestones = const [],
    this.tips = const [],
    this.ramadanData,
  });

  factory TaskTrakrPlanResponse.error(String message) => TaskTrakrPlanResponse(
        success: false,
        errorMessage: message,
      );

  factory TaskTrakrPlanResponse.fromJson(Map<String, dynamic> json) {
    try {
      return TaskTrakrPlanResponse(
        success: json['success'] as bool? ?? true,
        errorMessage: json['error_message'] as String?,
        goal: json['goal'] != null
            ? AIGoal.fromJson(json['goal'] as Map<String, dynamic>)
            : null,
        dayPlans: (json['day_plans'] as List<dynamic>?)
                ?.map((e) => AIDayPlan.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        milestones: (json['milestones'] as List<dynamic>?)
                ?.map((e) => AIMilestone.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
        tips: (json['tips'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        ramadanData: json['ramadan_data'] != null
            ? AIRamadanData.fromJson(
                json['ramadan_data'] as Map<String, dynamic>)
            : null,
      );
    } catch (e) {
      return TaskTrakrPlanResponse.error('Failed to parse response: $e');
    }
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        if (errorMessage != null) 'error_message': errorMessage,
        if (goal != null) 'goal': goal!.toJson(),
        'day_plans': dayPlans.map((e) => e.toJson()).toList(),
        'milestones': milestones.map((e) => e.toJson()).toList(),
        'tips': tips,
        if (ramadanData != null) 'ramadan_data': ramadanData!.toJson(),
      };
}

/// Goal metadata from AI response
class AIGoal {
  final String title;
  final String titleShort;
  final String category;
  final int durationDays;
  final String difficulty;
  final String description;
  final String iconSuggestion;

  const AIGoal({
    required this.title,
    required this.titleShort,
    required this.category,
    required this.durationDays,
    required this.difficulty,
    required this.description,
    required this.iconSuggestion,
  });

  factory AIGoal.fromJson(Map<String, dynamic> json) => AIGoal(
        title: json['title'] as String? ?? 'Untitled Goal',
        titleShort: json['title_short'] as String? ?? 'Goal',
        category: json['category'] as String? ?? 'general',
        durationDays: json['duration_days'] as int? ?? 30,
        difficulty: json['difficulty'] as String? ?? 'moderate',
        description: json['description'] as String? ?? '',
        iconSuggestion: json['icon_suggestion'] as String? ?? '🎯',
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'title_short': titleShort,
        'category': category,
        'duration_days': durationDays,
        'difficulty': difficulty,
        'description': description,
        'icon_suggestion': iconSuggestion,
      };
}

/// Daily plan from AI response
class AIDayPlan {
  final int day;
  final String? task;
  final String? taskShort;
  final int? estimatedMinutes;
  final String? notes;
  final String? intensity;
  final String? ramadanPhase;
  final bool? isLaylaulQadrNight;

  const AIDayPlan({
    required this.day,
    this.task,
    this.taskShort,
    this.estimatedMinutes,
    this.notes,
    this.intensity,
    this.ramadanPhase,
    this.isLaylaulQadrNight,
  });

  /// Whether this day has an assignment (not a rest day)
  bool get hasAssignment => task != null && task!.isNotEmpty;

  /// Whether this is a rest day
  bool get isRestDay => !hasAssignment;

  factory AIDayPlan.fromJson(Map<String, dynamic> json) => AIDayPlan(
        day: json['day'] as int,
        task: json['task'] as String?,
        taskShort: json['task_short'] as String?,
        estimatedMinutes: json['estimated_minutes'] as int?,
        notes: json['notes'] as String?,
        intensity: json['intensity'] as String?,
        ramadanPhase: json['ramadan_phase'] as String?,
        isLaylaulQadrNight: json['is_laylatul_qadr_night'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        if (task != null) 'task': task,
        if (taskShort != null) 'task_short': taskShort,
        if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
        if (notes != null) 'notes': notes,
        if (intensity != null) 'intensity': intensity,
        if (ramadanPhase != null) 'ramadan_phase': ramadanPhase,
        if (isLaylaulQadrNight != null)
          'is_laylatul_qadr_night': isLaylaulQadrNight,
      };
}

/// Milestone from AI response
class AIMilestone {
  final int day;
  final String title;
  final String description;
  final String icon;

  const AIMilestone({
    required this.day,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory AIMilestone.fromJson(Map<String, dynamic> json) => AIMilestone(
        day: json['day'] as int,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        icon: json['icon'] as String? ?? '🎉',
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'title': title,
        'description': description,
        'icon': icon,
      };
}

/// Ramadan-specific data from AI response
class AIRamadanData {
  final AIRamadanPhases phases;
  final List<int> laylaulQadrNights;

  const AIRamadanData({
    required this.phases,
    required this.laylaulQadrNights,
  });

  factory AIRamadanData.fromJson(Map<String, dynamic> json) => AIRamadanData(
        phases: AIRamadanPhases.fromJson(
            json['phases'] as Map<String, dynamic>? ?? {}),
        laylaulQadrNights: (json['laylatul_qadr_nights'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            const [21, 23, 25, 27, 29],
      );

  Map<String, dynamic> toJson() => {
        'phases': phases.toJson(),
        'laylatul_qadr_nights': laylaulQadrNights,
      };
}

/// Ramadan phases info
class AIRamadanPhases {
  final String mercy;
  final String forgiveness;
  final String salvation;

  const AIRamadanPhases({
    this.mercy = 'Days 1-10: Mercy (رحمة)',
    this.forgiveness = 'Days 11-20: Forgiveness (مغفرة)',
    this.salvation = 'Days 21-30: Salvation (عتق من النار)',
  });

  factory AIRamadanPhases.fromJson(Map<String, dynamic> json) =>
      AIRamadanPhases(
        mercy: json['mercy'] as String? ?? 'Days 1-10: Mercy (رحمة)',
        forgiveness:
            json['forgiveness'] as String? ?? 'Days 11-20: Forgiveness (مغفرة)',
        salvation: json['salvation'] as String? ??
            'Days 21-30: Salvation (عتق من النار)',
      );

  Map<String, dynamic> toJson() => {
        'mercy': mercy,
        'forgiveness': forgiveness,
        'salvation': salvation,
      };
}
