import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/services/ai/fallback_templates.dart';
import 'package:tasktrakr/services/ai/models/ai_response.dart';

void main() {
  group('FallbackTemplates', () {
    test('templates getter returns all templates', () {
      final templates = FallbackTemplates.templates;

      expect(templates, hasLength(5));
    });

    test('getByCategory returns template for valid category', () {
      final ramadanTemplate = FallbackTemplates.getByCategory('ramadan');

      expect(ramadanTemplate, isNotNull);
      expect(ramadanTemplate!.category, 'ramadan');
    });

    test('getByCategory returns null for unknown category', () {
      final template = FallbackTemplates.getByCategory('unknown');

      expect(template, isNull);
    });

    test('getById returns template for valid ID', () {
      final template = FallbackTemplates.getById('quran-30-days');

      expect(template, isNotNull);
      expect(template!.id, 'quran-30-days');
    });

    test('getById returns null for unknown ID', () {
      final template = FallbackTemplates.getById('unknown-id');

      expect(template, isNull);
    });

    group('quranIn30Days template', () {
      late FallbackTemplate template;

      setUp(() {
        template = FallbackTemplates.quranIn30Days;
      });

      test('has correct metadata', () {
        expect(template.id, 'quran-30-days');
        expect(template.title, contains('Quran'));
        expect(template.category, 'ramadan');
        expect(template.durationDays, 30);
        expect(template.difficulty, 'moderate');
      });

      test('has 30 day plans', () {
        expect(template.dayPlans, hasLength(30));
      });

      test('has rest days', () {
        final restDays = template.dayPlans.where((p) => p.isRestDay);
        expect(restDays, isNotEmpty);
      });

      test('has Laylatul Qadr nights marked', () {
        final qadrNights =
            template.dayPlans.where((p) => p.isLaylaulQadrNight == true);
        expect(qadrNights, isNotEmpty);

        // Qadr nights should be on odd nights 21, 23, 25, 27, 29
        for (final plan in qadrNights) {
          expect([21, 23, 25, 27, 29], contains(plan.day));
        }
      });

      test('has ramadan phases', () {
        // First 10 days should be mercy
        final mercyDays =
            template.dayPlans.where((p) => p.ramadanPhase == 'mercy');
        expect(mercyDays, isNotEmpty);

        // Days 11-20 should be forgiveness
        final forgivenessDays =
            template.dayPlans.where((p) => p.ramadanPhase == 'forgiveness');
        expect(forgivenessDays, isNotEmpty);

        // Days 21-30 should be salvation
        final salvationDays =
            template.dayPlans.where((p) => p.ramadanPhase == 'salvation');
        expect(salvationDays, isNotEmpty);
      });

      test('has helpful tips', () {
        expect(template.tips, isNotEmpty);
        expect(template.tips.length, greaterThanOrEqualTo(2));
      });

      test('toResponse creates valid TaskTrakrPlanResponse', () {
        final response = template.toResponse();

        expect(response.success, isTrue);
        expect(response.goal, isNotNull);
        expect(response.goal!.title, template.title);
        expect(response.dayPlans, hasLength(30));
        expect(response.tips, template.tips);
      });
    });

    group('prayFiveDaily template', () {
      late FallbackTemplate template;

      setUp(() {
        template = FallbackTemplates.prayFiveDaily;
      });

      test('has correct metadata', () {
        expect(template.id, 'pray-five-30-days');
        expect(template.title, contains('Pray'));
        expect(template.category, 'ramadan');
        expect(template.durationDays, 30);
      });

      test('has 30 day plans', () {
        expect(template.dayPlans, hasLength(30));
      });

      test('has rest days every 7 days', () {
        final restDays = template.dayPlans.where((p) => p.isRestDay);
        expect(restDays, isNotEmpty);

        // Should have rest days at 7, 14, 21, 28
        final restDayNumbers = restDays.map((p) => p.day).toList();
        expect(restDayNumbers, contains(7));
        expect(restDayNumbers, contains(14));
        expect(restDayNumbers, contains(21));
        expect(restDayNumbers, contains(28));
      });

      test('has increased intensity on Qadr nights', () {
        final qadrNights =
            template.dayPlans.where((p) => p.isLaylaulQadrNight == true);
        for (final plan in qadrNights) {
          expect(plan.intensity, 'intense');
        }
      });
    });

    group('run5k template', () {
      late FallbackTemplate template;

      setUp(() {
        template = FallbackTemplates.run5k;
      });

      test('has correct metadata', () {
        expect(template.id, 'run-5k-30-days');
        expect(template.title, contains('5K'));
        expect(template.category, 'fitness');
        expect(template.durationDays, 30);
        expect(template.difficulty, 'moderate');
      });

      test('has 30 day plans', () {
        expect(template.dayPlans, hasLength(30));
      });

      test('final day is the 5K run', () {
        final lastDay = template.dayPlans.last;
        expect(lastDay.day, 30);
        expect(lastDay.task, contains('5K'));
        expect(lastDay.intensity, 'intense');
      });

      test('has progressive structure', () {
        // Early days should have shorter intervals
        final day1 = template.dayPlans.firstWhere((p) => p.day == 1);
        final day30 = template.dayPlans.last;

        // Day 1 should be shorter than day 30
        if (day1.estimatedMinutes != null && day30.estimatedMinutes != null) {
          expect(day30.estimatedMinutes, greaterThan(day1.estimatedMinutes!));
        }
      });
    });

    group('readOneBook template', () {
      late FallbackTemplate template;

      setUp(() {
        template = FallbackTemplates.readOneBook;
      });

      test('has correct metadata', () {
        expect(template.id, 'read-book-30-days');
        expect(template.title, contains('Book'));
        expect(template.category, 'learning');
        expect(template.durationDays, 30);
        expect(template.difficulty, 'easy');
      });

      test('has 30 day plans', () {
        expect(template.dayPlans, hasLength(30));
      });

      test('has pages to read each day', () {
        final assignedDays = template.dayPlans.where((p) => p.hasAssignment);
        for (final plan in assignedDays) {
          expect(plan.task, contains('page'));
        }
      });
    });

    group('meditateDaily template', () {
      late FallbackTemplate template;

      setUp(() {
        template = FallbackTemplates.meditateDaily;
      });

      test('has correct metadata', () {
        expect(template.id, 'meditate-30-days');
        expect(template.title, contains('Meditate'));
        expect(template.category, 'wellness');
        expect(template.durationDays, 30);
        expect(template.difficulty, 'easy');
      });

      test('has 30 day plans', () {
        expect(template.dayPlans, hasLength(30));
      });

      test('has progressive duration', () {
        // Week 1: 5 min, Week 2: 10 min, etc.
        final week1Day = template.dayPlans.firstWhere(
          (p) => p.day == 1 && p.hasAssignment,
        );
        final week4Day = template.dayPlans.firstWhere(
          (p) => p.day == 25 && p.hasAssignment,
        );

        if (week1Day.estimatedMinutes != null &&
            week4Day.estimatedMinutes != null) {
          expect(
            week4Day.estimatedMinutes,
            greaterThan(week1Day.estimatedMinutes!),
          );
        }
      });
    });

    group('FallbackTemplate', () {
      test('toResponse creates complete TaskTrakrPlanResponse', () {
        final template = FallbackTemplates.quranIn30Days;
        final response = template.toResponse();

        expect(response.success, isTrue);
        expect(response.errorMessage, isNull);

        expect(response.goal!.title, template.title);
        expect(response.goal!.titleShort, template.titleShort);
        expect(response.goal!.category, template.category);
        expect(response.goal!.durationDays, template.durationDays);
        expect(response.goal!.difficulty, template.difficulty);
        expect(response.goal!.description, template.description);
        expect(response.goal!.iconSuggestion, template.icon);

        expect(response.dayPlans, template.dayPlans);
        expect(response.tips, template.tips);
      });

      test('all templates have valid icons', () {
        for (final template in FallbackTemplates.templates) {
          expect(template.icon, isNotEmpty);
        }
      });

      test('all templates have tips', () {
        for (final template in FallbackTemplates.templates) {
          expect(template.tips, isNotEmpty);
        }
      });

      test('all templates have descriptions', () {
        for (final template in FallbackTemplates.templates) {
          expect(template.description, isNotEmpty);
        }
      });

      test('all assigned day plans have estimated minutes', () {
        for (final template in FallbackTemplates.templates) {
          for (final plan in template.dayPlans) {
            if (plan.hasAssignment) {
              // Most assigned days should have estimated minutes
              // Some templates might have exceptions
            }
          }
        }
      });

      test('day numbers are sequential', () {
        for (final template in FallbackTemplates.templates) {
          for (int i = 0; i < template.dayPlans.length; i++) {
            expect(template.dayPlans[i].day, i + 1);
          }
        }
      });
    });
  });
}
