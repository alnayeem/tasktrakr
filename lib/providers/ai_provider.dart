import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/stored_goal.dart';
import '../data/models/stored_day_plan.dart';
import '../data/repositories/goal_repository.dart';
import '../services/ai/ai_service.dart';
import '../services/ai/ai_response_converter.dart';
import '../services/ai/models/goal_context.dart';
import 'repository_providers.dart';
import 'goals_provider.dart';

/// Provider for AI service
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService();
});

/// Provider for AI response converter
final aiResponseConverterProvider = Provider<AIResponseConverter>((ref) {
  return AIResponseConverter();
});

/// State for goal generation
class GoalGenerationState {
  final bool isLoading;
  final String? error;
  final StoredGoal? generatedGoal;
  final List<StoredDayPlan>? dayPlans;
  final List<String> tips;
  final double progress;
  final String statusMessage;

  const GoalGenerationState({
    this.isLoading = false,
    this.error,
    this.generatedGoal,
    this.dayPlans,
    this.tips = const [],
    this.progress = 0,
    this.statusMessage = '',
  });

  GoalGenerationState copyWith({
    bool? isLoading,
    String? error,
    StoredGoal? generatedGoal,
    List<StoredDayPlan>? dayPlans,
    List<String>? tips,
    double? progress,
    String? statusMessage,
  }) {
    return GoalGenerationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      generatedGoal: generatedGoal ?? this.generatedGoal,
      dayPlans: dayPlans ?? this.dayPlans,
      tips: tips ?? this.tips,
      progress: progress ?? this.progress,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  bool get hasError => error != null;
  bool get isComplete => generatedGoal != null && !isLoading;
}

/// Notifier for goal generation
class GoalGenerationNotifier extends StateNotifier<GoalGenerationState> {
  final AIService _aiService;
  final AIResponseConverter _converter;
  final GoalRepository _goalRepository;
  final Ref _ref;

  GoalGenerationNotifier({
    required AIService aiService,
    required AIResponseConverter converter,
    required GoalRepository goalRepository,
    required Ref ref,
  })  : _aiService = aiService,
        _converter = converter,
        _goalRepository = goalRepository,
        _ref = ref,
        super(const GoalGenerationState());

  /// Generate a goal plan using AI
  Future<void> generateGoal({
    required GoalContext context,
    required String deviceId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      progress: 0.1,
      statusMessage: 'Connecting to AI...',
    );

    try {
      // Update progress: Calling AI
      state = state.copyWith(
        progress: 0.3,
        statusMessage: 'Generating your personalized plan...',
      );

      // Call AI service
      final response = await _aiService.generatePlan(
        context: context,
        deviceId: deviceId,
      );

      if (!response.success) {
        state = state.copyWith(
          isLoading: false,
          error: response.errorMessage ?? 'Failed to generate plan',
          progress: 0,
        );
        return;
      }

      // Update progress: Converting response
      state = state.copyWith(
        progress: 0.7,
        statusMessage: 'Preparing your daily tasks...',
      );

      // Convert AI response to storable models
      final result = _converter.convert(
        response: response,
        context: context,
      );

      // Update progress: Saving
      state = state.copyWith(
        progress: 0.9,
        statusMessage: 'Saving your goal...',
      );

      // Save to repository
      await _goalRepository.saveGoal(result.goal, result.dayPlans);

      // Refresh goals provider
      _ref.read(goalsProvider.notifier).refresh();

      // Update state with success
      state = state.copyWith(
        isLoading: false,
        generatedGoal: result.goal,
        dayPlans: result.dayPlans,
        tips: result.tips,
        progress: 1.0,
        statusMessage: 'Goal created successfully!',
      );
    } on ConversionException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
        progress: 0,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred: $e',
        progress: 0,
      );
    }
  }

  /// Reset the generation state
  void reset() {
    state = const GoalGenerationState();
  }
}

/// Provider for goal generation
final goalGenerationProvider =
    StateNotifierProvider<GoalGenerationNotifier, GoalGenerationState>((ref) {
  return GoalGenerationNotifier(
    aiService: ref.watch(aiServiceProvider),
    converter: ref.watch(aiResponseConverterProvider),
    goalRepository: ref.watch(goalRepositoryProvider),
    ref: ref,
  );
});

/// Provider for checking if device can generate (rate limit check)
/// This is a simple check - the actual enforcement is on the server
final canGenerateProvider = Provider<bool>((ref) {
  final state = ref.watch(goalGenerationProvider);
  return !state.isLoading;
});
