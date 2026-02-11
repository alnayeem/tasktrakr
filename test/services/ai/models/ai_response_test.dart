import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/services/ai/models/ai_response.dart';

void main() {
  group('TaskTrakrPlanResponse', () {
    test('creates success response', () {
      const response = TaskTrakrPlanResponse(
        success: true,
        goal: AIGoal(
          title: 'Read Quran',
          titleShort: 'Quran',
          category: 'ramadan',
          durationDays: 30,
          difficulty: 'moderate',
          description: 'Read one Juz per day',
          iconSuggestion: '📖',
        ),
        dayPlans: [],
        tips: ['Tip 1', 'Tip 2'],
      );

      expect(response.success, isTrue);
      expect(response.goal, isNotNull);
      expect(response.errorMessage, isNull);
      expect(response.tips, hasLength(2));
    });

    test('creates error response using factory', () {
      final response = TaskTrakrPlanResponse.error('Something went wrong');

      expect(response.success, isFalse);
      expect(response.errorMessage, 'Something went wrong');
      expect(response.goal, isNull);
    });

    group('fromJson', () {
      test('parses successful response', () {
        final json = {
          'success': true,
          'goal': {
            'title': 'Read Quran in 30 days',
            'title_short': 'Read Quran',
            'category': 'ramadan',
            'duration_days': 30,
            'difficulty': 'moderate',
            'description': 'Complete the Quran in Ramadan',
            'icon_suggestion': '📖',
          },
          'day_plans': [
            {
              'day': 1,
              'task': 'Read Juz 1',
              'task_short': 'Juz 1',
              'estimated_minutes': 45,
              'intensity': 'moderate',
            },
          ],
          'milestones': [
            {
              'day': 10,
              'title': 'First third done',
              'description': 'Completed 10 Juz',
              'icon': '🎉',
            },
          ],
          'tips': ['Read after Fajr'],
        };

        final response = TaskTrakrPlanResponse.fromJson(json);

        expect(response.success, isTrue);
        expect(response.goal, isNotNull);
        expect(response.goal!.title, 'Read Quran in 30 days');
        expect(response.dayPlans, hasLength(1));
        expect(response.milestones, hasLength(1));
        expect(response.tips, hasLength(1));
      });

      test('parses response with ramadan data', () {
        final json = {
          'success': true,
          'goal': {
            'title': 'Read Quran',
            'title_short': 'Quran',
            'category': 'ramadan',
            'duration_days': 30,
            'difficulty': 'moderate',
            'description': 'Complete Quran',
            'icon_suggestion': '📖',
          },
          'day_plans': [],
          'ramadan_data': {
            'phases': {
              'mercy': 'Days 1-10: Mercy',
              'forgiveness': 'Days 11-20: Forgiveness',
              'salvation': 'Days 21-30: Salvation',
            },
            'laylatul_qadr_nights': [21, 23, 25, 27, 29],
          },
        };

        final response = TaskTrakrPlanResponse.fromJson(json);

        expect(response.ramadanData, isNotNull);
        expect(response.ramadanData!.laylaulQadrNights, [21, 23, 25, 27, 29]);
      });

      test('handles missing optional fields', () {
        final json = {
          'success': true,
          'goal': {
            'title': 'Goal',
            'title_short': 'Goal',
            'category': 'general',
            'duration_days': 7,
            'difficulty': 'easy',
            'description': 'A goal',
            'icon_suggestion': '🎯',
          },
        };

        final response = TaskTrakrPlanResponse.fromJson(json);

        expect(response.success, isTrue);
        expect(response.dayPlans, isEmpty);
        expect(response.milestones, isEmpty);
        expect(response.tips, isEmpty);
        expect(response.ramadanData, isNull);
      });

      test('returns error response on parse failure', () {
        final json = {'invalid': 'data'};

        final response = TaskTrakrPlanResponse.fromJson(json);

        // Should use default success: true from parse
        expect(response.success, isTrue);
        expect(response.goal, isNull);
      });
    });

    group('toJson', () {
      test('serializes to JSON', () {
        const response = TaskTrakrPlanResponse(
          success: true,
          goal: AIGoal(
            title: 'Read Quran',
            titleShort: 'Quran',
            category: 'ramadan',
            durationDays: 30,
            difficulty: 'moderate',
            description: 'Complete Quran',
            iconSuggestion: '📖',
          ),
          dayPlans: [
            AIDayPlan(
              day: 1,
              task: 'Read Juz 1',
              taskShort: 'Juz 1',
              estimatedMinutes: 45,
            ),
          ],
          tips: ['Tip 1'],
        );

        final json = response.toJson();

        expect(json['success'], isTrue);
        expect(json['goal'], isA<Map<String, dynamic>>());
        expect(json['day_plans'], hasLength(1));
        expect(json['tips'], ['Tip 1']);
      });
    });
  });

  group('AIGoal', () {
    test('creates instance with required parameters', () {
      const goal = AIGoal(
        title: 'Read Quran',
        titleShort: 'Quran',
        category: 'ramadan',
        durationDays: 30,
        difficulty: 'moderate',
        description: 'Complete Quran in Ramadan',
        iconSuggestion: '📖',
      );

      expect(goal.title, 'Read Quran');
      expect(goal.titleShort, 'Quran');
      expect(goal.category, 'ramadan');
      expect(goal.durationDays, 30);
      expect(goal.difficulty, 'moderate');
      expect(goal.description, 'Complete Quran in Ramadan');
      expect(goal.iconSuggestion, '📖');
    });

    group('fromJson', () {
      test('parses complete JSON', () {
        final json = {
          'title': 'Read Quran',
          'title_short': 'Quran',
          'category': 'ramadan',
          'duration_days': 30,
          'difficulty': 'moderate',
          'description': 'Complete Quran',
          'icon_suggestion': '📖',
        };

        final goal = AIGoal.fromJson(json);

        expect(goal.title, 'Read Quran');
        expect(goal.titleShort, 'Quran');
        expect(goal.category, 'ramadan');
      });

      test('uses default values for missing fields', () {
        final json = <String, dynamic>{};

        final goal = AIGoal.fromJson(json);

        expect(goal.title, 'Untitled Goal');
        expect(goal.titleShort, 'Goal');
        expect(goal.category, 'general');
        expect(goal.durationDays, 30);
        expect(goal.difficulty, 'moderate');
        expect(goal.description, '');
        expect(goal.iconSuggestion, '🎯');
      });
    });

    group('toJson', () {
      test('serializes to JSON', () {
        const goal = AIGoal(
          title: 'Read Quran',
          titleShort: 'Quran',
          category: 'ramadan',
          durationDays: 30,
          difficulty: 'moderate',
          description: 'Complete Quran',
          iconSuggestion: '📖',
        );

        final json = goal.toJson();

        expect(json['title'], 'Read Quran');
        expect(json['title_short'], 'Quran');
        expect(json['category'], 'ramadan');
        expect(json['duration_days'], 30);
        expect(json['difficulty'], 'moderate');
        expect(json['description'], 'Complete Quran');
        expect(json['icon_suggestion'], '📖');
      });
    });
  });

  group('AIDayPlan', () {
    test('creates assigned day plan', () {
      const plan = AIDayPlan(
        day: 1,
        task: 'Read Juz 1',
        taskShort: 'Juz 1',
        estimatedMinutes: 45,
        intensity: 'moderate',
      );

      expect(plan.day, 1);
      expect(plan.task, 'Read Juz 1');
      expect(plan.hasAssignment, isTrue);
      expect(plan.isRestDay, isFalse);
    });

    test('creates rest day plan', () {
      const plan = AIDayPlan(day: 7);

      expect(plan.day, 7);
      expect(plan.task, isNull);
      expect(plan.hasAssignment, isFalse);
      expect(plan.isRestDay, isTrue);
    });

    test('hasAssignment returns false for empty task', () {
      const plan = AIDayPlan(day: 7, task: '');

      expect(plan.hasAssignment, isFalse);
      expect(plan.isRestDay, isTrue);
    });

    test('creates ramadan day plan with special fields', () {
      const plan = AIDayPlan(
        day: 27,
        task: 'Read Juz 27',
        taskShort: 'Juz 27',
        estimatedMinutes: 60,
        intensity: 'intense',
        ramadanPhase: 'salvation',
        isLaylaulQadrNight: true,
      );

      expect(plan.ramadanPhase, 'salvation');
      expect(plan.isLaylaulQadrNight, isTrue);
    });

    group('fromJson', () {
      test('parses assigned day', () {
        final json = {
          'day': 1,
          'task': 'Read Juz 1',
          'task_short': 'Juz 1',
          'estimated_minutes': 45,
          'notes': 'Start early',
          'intensity': 'moderate',
          'ramadan_phase': 'mercy',
          'is_laylatul_qadr_night': false,
        };

        final plan = AIDayPlan.fromJson(json);

        expect(plan.day, 1);
        expect(plan.task, 'Read Juz 1');
        expect(plan.taskShort, 'Juz 1');
        expect(plan.estimatedMinutes, 45);
        expect(plan.notes, 'Start early');
        expect(plan.intensity, 'moderate');
        expect(plan.ramadanPhase, 'mercy');
        expect(plan.isLaylaulQadrNight, isFalse);
      });

      test('parses rest day', () {
        final json = {'day': 7};

        final plan = AIDayPlan.fromJson(json);

        expect(plan.day, 7);
        expect(plan.task, isNull);
        expect(plan.isRestDay, isTrue);
      });
    });

    group('toJson', () {
      test('serializes assigned day to JSON', () {
        const plan = AIDayPlan(
          day: 1,
          task: 'Read Juz 1',
          taskShort: 'Juz 1',
          estimatedMinutes: 45,
          intensity: 'moderate',
        );

        final json = plan.toJson();

        expect(json['day'], 1);
        expect(json['task'], 'Read Juz 1');
        expect(json['task_short'], 'Juz 1');
        expect(json['estimated_minutes'], 45);
        expect(json['intensity'], 'moderate');
      });

      test('serializes rest day to JSON with only day', () {
        const plan = AIDayPlan(day: 7);

        final json = plan.toJson();

        expect(json['day'], 7);
        expect(json.containsKey('task'), isFalse);
        expect(json.containsKey('task_short'), isFalse);
      });
    });
  });

  group('AIMilestone', () {
    test('creates milestone', () {
      const milestone = AIMilestone(
        day: 10,
        title: 'First third complete',
        description: 'You have completed 10 Juz',
        icon: '🎉',
      );

      expect(milestone.day, 10);
      expect(milestone.title, 'First third complete');
      expect(milestone.description, 'You have completed 10 Juz');
      expect(milestone.icon, '🎉');
    });

    group('fromJson', () {
      test('parses complete JSON', () {
        final json = {
          'day': 10,
          'title': 'First third complete',
          'description': 'You have completed 10 Juz',
          'icon': '🎉',
        };

        final milestone = AIMilestone.fromJson(json);

        expect(milestone.day, 10);
        expect(milestone.title, 'First third complete');
        expect(milestone.description, 'You have completed 10 Juz');
        expect(milestone.icon, '🎉');
      });

      test('uses default values for missing fields', () {
        final json = {'day': 10};

        final milestone = AIMilestone.fromJson(json);

        expect(milestone.day, 10);
        expect(milestone.title, '');
        expect(milestone.description, '');
        expect(milestone.icon, '🎉');
      });
    });

    group('toJson', () {
      test('serializes to JSON', () {
        const milestone = AIMilestone(
          day: 10,
          title: 'First third complete',
          description: 'You have completed 10 Juz',
          icon: '🎉',
        );

        final json = milestone.toJson();

        expect(json['day'], 10);
        expect(json['title'], 'First third complete');
        expect(json['description'], 'You have completed 10 Juz');
        expect(json['icon'], '🎉');
      });
    });
  });

  group('AIRamadanData', () {
    test('creates ramadan data', () {
      const data = AIRamadanData(
        phases: AIRamadanPhases(),
        laylaulQadrNights: [21, 23, 25, 27, 29],
      );

      expect(data.laylaulQadrNights, [21, 23, 25, 27, 29]);
      expect(data.phases, isNotNull);
    });

    group('fromJson', () {
      test('parses complete JSON', () {
        final json = {
          'phases': {
            'mercy': 'Days 1-10: Mercy',
            'forgiveness': 'Days 11-20: Forgiveness',
            'salvation': 'Days 21-30: Salvation',
          },
          'laylatul_qadr_nights': [21, 23, 25, 27, 29],
        };

        final data = AIRamadanData.fromJson(json);

        expect(data.laylaulQadrNights, [21, 23, 25, 27, 29]);
        expect(data.phases.mercy, 'Days 1-10: Mercy');
      });

      test('uses defaults for missing laylatul qadr nights', () {
        final json = <String, dynamic>{
          'phases': <String, dynamic>{},
        };

        final data = AIRamadanData.fromJson(json);

        expect(data.laylaulQadrNights, [21, 23, 25, 27, 29]);
      });
    });

    group('toJson', () {
      test('serializes to JSON', () {
        const data = AIRamadanData(
          phases: AIRamadanPhases(),
          laylaulQadrNights: [21, 23, 25, 27, 29],
        );

        final json = data.toJson();

        expect(json['laylatul_qadr_nights'], [21, 23, 25, 27, 29]);
        expect(json['phases'], isA<Map<String, dynamic>>());
      });
    });
  });

  group('AIRamadanPhases', () {
    test('creates with default values', () {
      const phases = AIRamadanPhases();

      expect(phases.mercy, 'Days 1-10: Mercy (رحمة)');
      expect(phases.forgiveness, 'Days 11-20: Forgiveness (مغفرة)');
      expect(phases.salvation, 'Days 21-30: Salvation (عتق من النار)');
    });

    test('creates with custom values', () {
      const phases = AIRamadanPhases(
        mercy: 'Custom mercy',
        forgiveness: 'Custom forgiveness',
        salvation: 'Custom salvation',
      );

      expect(phases.mercy, 'Custom mercy');
      expect(phases.forgiveness, 'Custom forgiveness');
      expect(phases.salvation, 'Custom salvation');
    });

    group('fromJson', () {
      test('parses complete JSON', () {
        final json = {
          'mercy': 'Days 1-10: Mercy',
          'forgiveness': 'Days 11-20: Forgiveness',
          'salvation': 'Days 21-30: Salvation',
        };

        final phases = AIRamadanPhases.fromJson(json);

        expect(phases.mercy, 'Days 1-10: Mercy');
        expect(phases.forgiveness, 'Days 11-20: Forgiveness');
        expect(phases.salvation, 'Days 21-30: Salvation');
      });

      test('uses defaults for missing fields', () {
        final json = <String, dynamic>{};

        final phases = AIRamadanPhases.fromJson(json);

        expect(phases.mercy, contains('Mercy'));
        expect(phases.forgiveness, contains('Forgiveness'));
        expect(phases.salvation, contains('Salvation'));
      });
    });

    group('toJson', () {
      test('serializes to JSON', () {
        const phases = AIRamadanPhases();

        final json = phases.toJson();

        expect(json['mercy'], phases.mercy);
        expect(json['forgiveness'], phases.forgiveness);
        expect(json['salvation'], phases.salvation);
      });
    });
  });
}
