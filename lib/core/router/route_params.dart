/// Route parameter models for type-safe navigation
/// Encapsulates parameters passed between routes
library;

/// Parameters for AI Loading screen
class AILoadingParams {
  final String goalText;
  final int durationDays;
  final String? category;

  const AILoadingParams({
    required this.goalText,
    required this.durationDays,
    this.category,
  });

  /// Create from query parameters map
  factory AILoadingParams.fromQueryParams(Map<String, String> params) {
    final goalText = params['goalText'];
    final durationDays = params['durationDays'];

    if (goalText == null || durationDays == null) {
      throw ArgumentError('Missing required parameters: goalText, durationDays');
    }

    return AILoadingParams(
      goalText: Uri.decodeComponent(goalText),
      durationDays: int.parse(durationDays),
      category: params['category'],
    );
  }

  /// Convert to query parameters map
  Map<String, String> toQueryParams() {
    return {
      'goalText': Uri.encodeComponent(goalText),
      'durationDays': durationDays.toString(),
      if (category != null) 'category': category!,
    };
  }

  /// Build query string
  String toQueryString() {
    final params = toQueryParams();
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AILoadingParams &&
        other.goalText == goalText &&
        other.durationDays == durationDays &&
        other.category == category;
  }

  @override
  int get hashCode => Object.hash(goalText, durationDays, category);

  @override
  String toString() =>
      'AILoadingParams(goalText: $goalText, durationDays: $durationDays, category: $category)';
}

/// Parameters for Goal Detail screen
class GoalDetailParams {
  final String goalId;

  const GoalDetailParams({required this.goalId});

  /// Create from path parameters map
  factory GoalDetailParams.fromPathParams(Map<String, String> params) {
    final goalId = params['goalId'];
    if (goalId == null) {
      throw ArgumentError('Missing required parameter: goalId');
    }
    return GoalDetailParams(goalId: goalId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GoalDetailParams && other.goalId == goalId;
  }

  @override
  int get hashCode => goalId.hashCode;

  @override
  String toString() => 'GoalDetailParams(goalId: $goalId)';
}
