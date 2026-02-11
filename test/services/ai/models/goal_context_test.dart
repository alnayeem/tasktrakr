import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/services/ai/models/goal_context.dart';

void main() {
  group('GoalContext', () {
    test('creates instance with required parameters', () {
      const context = GoalContext(
        rawInput: 'Read Quran daily',
        language: 'en',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
      );

      expect(context.rawInput, 'Read Quran daily');
      expect(context.language, 'en');
      expect(context.category, 'ramadan');
      expect(context.durationDays, 30);
      expect(context.startDate, '2026-02-28');
      expect(context.difficulty, isNull);
      expect(context.specialMode, isNull);
      expect(context.ramadan, isNull);
    });

    test('creates instance with all parameters', () {
      const ramadanContext = RamadanContext(
        hijriStart: '1447-09-01',
        laylaulQadrNights: [21, 23, 25, 27, 29],
      );

      const context = GoalContext(
        rawInput: 'Complete Quran',
        language: 'ar',
        category: 'ramadan',
        durationDays: 30,
        startDate: '2026-02-28',
        difficulty: 'moderate',
        specialMode: 'ramadan',
        ramadan: ramadanContext,
      );

      expect(context.difficulty, 'moderate');
      expect(context.specialMode, 'ramadan');
      expect(context.ramadan, ramadanContext);
    });

    group('isRamadanMode', () {
      test('returns true when specialMode is ramadan', () {
        const context = GoalContext(
          rawInput: 'Goal',
          language: 'en',
          category: 'general',
          durationDays: 30,
          startDate: '2026-02-28',
          specialMode: 'ramadan',
        );

        expect(context.isRamadanMode, isTrue);
      });

      test('returns true when category is ramadan', () {
        const context = GoalContext(
          rawInput: 'Goal',
          language: 'en',
          category: 'ramadan',
          durationDays: 30,
          startDate: '2026-02-28',
        );

        expect(context.isRamadanMode, isTrue);
      });

      test('returns false for non-ramadan goals', () {
        const context = GoalContext(
          rawInput: 'Goal',
          language: 'en',
          category: 'fitness',
          durationDays: 30,
          startDate: '2026-02-28',
        );

        expect(context.isRamadanMode, isFalse);
      });
    });

    group('toJson', () {
      test('converts to JSON with required fields', () {
        const context = GoalContext(
          rawInput: 'Read Quran',
          language: 'en',
          category: 'ramadan',
          durationDays: 30,
          startDate: '2026-02-28',
        );

        final json = context.toJson();

        expect(json['raw_input'], 'Read Quran');
        expect(json['language'], 'en');
        expect(json['category'], 'ramadan');
        expect(json['duration_days'], 30);
        expect(json['start_date'], '2026-02-28');
        expect(json.containsKey('difficulty'), isFalse);
        expect(json.containsKey('special_mode'), isFalse);
        expect(json.containsKey('ramadan'), isFalse);
      });

      test('converts to JSON with all fields', () {
        const context = GoalContext(
          rawInput: 'Read Quran',
          language: 'ar',
          category: 'ramadan',
          durationDays: 30,
          startDate: '2026-02-28',
          difficulty: 'moderate',
          specialMode: 'ramadan',
          ramadan: RamadanContext(
            hijriStart: '1447-09-01',
          ),
        );

        final json = context.toJson();

        expect(json['difficulty'], 'moderate');
        expect(json['special_mode'], 'ramadan');
        expect(json['ramadan'], isA<Map<String, dynamic>>());
      });
    });

    group('fromJson', () {
      test('creates instance from JSON with required fields', () {
        final json = {
          'raw_input': 'Read Quran',
          'language': 'en',
          'category': 'ramadan',
          'duration_days': 30,
          'start_date': '2026-02-28',
        };

        final context = GoalContext.fromJson(json);

        expect(context.rawInput, 'Read Quran');
        expect(context.language, 'en');
        expect(context.category, 'ramadan');
        expect(context.durationDays, 30);
        expect(context.startDate, '2026-02-28');
      });

      test('creates instance from JSON with all fields', () {
        final json = {
          'raw_input': 'Read Quran',
          'language': 'ar',
          'category': 'ramadan',
          'duration_days': 30,
          'start_date': '2026-02-28',
          'difficulty': 'moderate',
          'special_mode': 'ramadan',
          'ramadan': {
            'hijri_start': '1447-09-01',
            'laylatul_qadr_nights': [21, 23, 25, 27, 29],
          },
        };

        final context = GoalContext.fromJson(json);

        expect(context.difficulty, 'moderate');
        expect(context.specialMode, 'ramadan');
        expect(context.ramadan, isNotNull);
        expect(context.ramadan!.hijriStart, '1447-09-01');
      });

      test('roundtrips through JSON', () {
        const original = GoalContext(
          rawInput: 'Complete Quran',
          language: 'ar',
          category: 'ramadan',
          durationDays: 30,
          startDate: '2026-02-28',
          difficulty: 'moderate',
          specialMode: 'ramadan',
          ramadan: RamadanContext(
            hijriStart: '1447-09-01',
            laylaulQadrNights: [21, 23, 25, 27, 29],
          ),
        );

        final json = original.toJson();
        final restored = GoalContext.fromJson(json);

        expect(restored.rawInput, original.rawInput);
        expect(restored.language, original.language);
        expect(restored.category, original.category);
        expect(restored.durationDays, original.durationDays);
        expect(restored.startDate, original.startDate);
        expect(restored.difficulty, original.difficulty);
        expect(restored.specialMode, original.specialMode);
        expect(restored.ramadan?.hijriStart, original.ramadan?.hijriStart);
      });
    });
  });

  group('RamadanContext', () {
    test('creates instance with required parameters', () {
      const context = RamadanContext(hijriStart: '1447-09-01');

      expect(context.hijriStart, '1447-09-01');
      expect(context.laylaulQadrNights, [21, 23, 25, 27, 29]);
    });

    test('creates instance with custom laylatul qadr nights', () {
      const context = RamadanContext(
        hijriStart: '1447-09-01',
        laylaulQadrNights: [23, 25, 27],
      );

      expect(context.laylaulQadrNights, [23, 25, 27]);
    });

    test('ramadan2026 factory creates correct context', () {
      final context = RamadanContext.ramadan2026();

      expect(context.hijriStart, '1447-09-01');
      expect(context.laylaulQadrNights, [21, 23, 25, 27, 29]);
    });

    group('toJson', () {
      test('converts to JSON', () {
        const context = RamadanContext(
          hijriStart: '1447-09-01',
          laylaulQadrNights: [21, 23, 25, 27, 29],
        );

        final json = context.toJson();

        expect(json['hijri_start'], '1447-09-01');
        expect(json['laylatul_qadr_nights'], [21, 23, 25, 27, 29]);
      });
    });

    group('fromJson', () {
      test('creates instance from JSON', () {
        final json = {
          'hijri_start': '1447-09-01',
          'laylatul_qadr_nights': [21, 23, 25, 27, 29],
        };

        final context = RamadanContext.fromJson(json);

        expect(context.hijriStart, '1447-09-01');
        expect(context.laylaulQadrNights, [21, 23, 25, 27, 29]);
      });

      test('uses default laylatul qadr nights when not provided', () {
        final json = {
          'hijri_start': '1447-09-01',
        };

        final context = RamadanContext.fromJson(json);

        expect(context.laylaulQadrNights, [21, 23, 25, 27, 29]);
      });

      test('roundtrips through JSON', () {
        const original = RamadanContext(
          hijriStart: '1447-09-01',
          laylaulQadrNights: [21, 23, 25, 27, 29],
        );

        final json = original.toJson();
        final restored = RamadanContext.fromJson(json);

        expect(restored.hijriStart, original.hijriStart);
        expect(restored.laylaulQadrNights, original.laylaulQadrNights);
      });
    });
  });
}
