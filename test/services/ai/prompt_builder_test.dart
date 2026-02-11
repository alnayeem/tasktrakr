import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/services/ai/prompt_builder.dart';
import 'package:tasktrakr/services/ai/models/goal_context.dart';

void main() {
  group('PromptBuilder', () {
    late PromptBuilder promptBuilder;

    setUp(() {
      promptBuilder = const PromptBuilder();
    });

    test('builds prompt with required context', () {
      const context = GoalContext(
        rawInput: 'I want to read more books',
        language: 'en',
        category: 'learning',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('TaskTrakr'));
      expect(prompt, contains('USER GOAL REQUEST'));
      expect(prompt, contains('I want to read more books'));
      expect(prompt, contains('RESPONSE SCHEMA'));
    });

    test('includes learning-specific prompt for learning category', () {
      const context = GoalContext(
        rawInput: 'Learn Spanish',
        language: 'en',
        category: 'learning',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('CATEGORY: LEARNING'));
      expect(prompt, contains('spaced repetition'));
    });

    test('includes fitness-specific prompt for fitness category', () {
      const context = GoalContext(
        rawInput: 'Run a 5K',
        language: 'en',
        category: 'fitness',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('CATEGORY: FITNESS'));
      expect(prompt, contains('Progressive overload'));
      expect(prompt, contains('rest days'));
    });

    test('includes ramadan-specific prompt for ramadan category', () {
      const context = GoalContext(
        rawInput: 'Complete the Quran',
        language: 'ar',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
        specialMode: 'ramadan',
        ramadan: RamadanContext(hijriStart: '1447-09-01'),
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('CATEGORY: RAMADAN'));
      expect(prompt, contains('Mercy'));
      expect(prompt, contains('Forgiveness'));
      expect(prompt, contains('Salvation'));
      expect(prompt, contains('Laylatul Qadr'));
    });

    test('includes ramadan prompt when specialMode is ramadan', () {
      const context = GoalContext(
        rawInput: 'Pray regularly',
        language: 'en',
        category: 'general',
        durationDays: 30,
        startDate: '2026-02-28',
        specialMode: 'ramadan',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('CATEGORY: RAMADAN'));
    });

    test('includes JSON schema in prompt', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('"success": true'));
      expect(prompt, contains('"goal"'));
      expect(prompt, contains('"day_plans"'));
      expect(prompt, contains('"milestones"'));
      expect(prompt, contains('"tips"'));
    });

    test('includes user context as JSON', () {
      const context = GoalContext(
        rawInput: 'Learn to cook',
        language: 'en',
        category: 'learning',
        durationDays: 14,
        startDate: '2026-03-01',
        difficulty: 'easy',
      );

      final prompt = promptBuilder.buildPrompt(context);

      // The user context should be JSON encoded
      expect(prompt, contains('"raw_input":"Learn to cook"'));
      expect(prompt, contains('"language":"en"'));
      expect(prompt, contains('"duration_days":14'));
    });

    test('prompt contains rules for AI', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('RULES'));
      expect(prompt, contains('valid JSON'));
      expect(prompt, contains('rest day'));
      expect(prompt, contains('actionable'));
    });

    test('prompt instructs AI to respond in specified language', () {
      const context = GoalContext(
        rawInput: 'أقرأ القرآن',
        language: 'ar',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('Respond in the language specified'));
    });

    test('builds different prompts for different categories', () {
      const learningContext = GoalContext(
        rawInput: 'Learn',
        language: 'en',
        category: 'learning',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      const fitnessContext = GoalContext(
        rawInput: 'Exercise',
        language: 'en',
        category: 'fitness',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      const generalContext = GoalContext(
        rawInput: 'General goal',
        language: 'en',
        category: 'general',
        durationDays: 30,
        startDate: '2026-03-01',
      );

      final learningPrompt = promptBuilder.buildPrompt(learningContext);
      final fitnessPrompt = promptBuilder.buildPrompt(fitnessContext);
      final generalPrompt = promptBuilder.buildPrompt(generalContext);

      // Learning should have learning-specific content
      expect(learningPrompt, contains('CATEGORY: LEARNING'));
      expect(fitnessPrompt, isNot(contains('CATEGORY: LEARNING')));
      expect(generalPrompt, isNot(contains('CATEGORY: LEARNING')));

      // Fitness should have fitness-specific content
      expect(fitnessPrompt, contains('CATEGORY: FITNESS'));
      expect(learningPrompt, isNot(contains('CATEGORY: FITNESS')));
      expect(generalPrompt, isNot(contains('CATEGORY: FITNESS')));

      // General should not have category-specific content
      expect(generalPrompt, isNot(contains('CATEGORY:')));
    });

    test('prompt contains estimated_minutes guidance', () {
      const context = GoalContext(
        rawInput: 'Goal',
        language: 'en',
        category: 'general',
        durationDays: 7,
        startDate: '2026-03-01',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('estimated_minutes'));
    });

    test('ramadan prompt contains Juz information for Quran goals', () {
      const context = GoalContext(
        rawInput: 'Read Quran',
        language: 'en',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
      );

      final prompt = promptBuilder.buildPrompt(context);

      expect(prompt, contains('Juz'));
      expect(prompt, contains('30-45 minutes'));
    });
  });
}
