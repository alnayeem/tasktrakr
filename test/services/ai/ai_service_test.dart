import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktrakr/services/ai/ai_service.dart';
import 'package:tasktrakr/services/ai/models/goal_context.dart';
import 'package:tasktrakr/services/ai/prompt_builder.dart';

// Mock Dio adapter for testing
class MockDioAdapter implements HttpClientAdapter {
  final Future<ResponseBody> Function(RequestOptions options, Stream<List<int>>? requestStream, Future<void>? cancelFuture) handler;

  MockDioAdapter(this.handler);

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return handler(options, requestStream, cancelFuture);
  }
}

void main() {
  group('AIService', () {
    late Dio mockDio;
    late AIService service;

    const testContext = GoalContext(
      rawInput: 'Read Quran in 30 days',
      language: 'en',
      category: 'ramadan',
      durationDays: 30,
      startDate: '2026-02-28',
    );

    const testDeviceId = 'test-device-123';

    setUp(() {
      mockDio = Dio();
    });

    test('creates service with default dependencies', () {
      final service = AIService();
      expect(service, isNotNull);
    });

    test('creates service with custom dependencies', () {
      final service = AIService(
        dio: Dio(),
        promptBuilder: const PromptBuilder(),
        workerUrl: 'https://test.workers.dev',
      );
      expect(service, isNotNull);
    });

    group('generatePlan', () {
      test('returns successful response when AI returns valid data', () async {
        final validResponse = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'success': true,
                      'goal': {
                        'title': 'Read Quran in 30 Days',
                        'title_short': 'Read Quran',
                        'category': 'ramadan',
                        'duration_days': 30,
                        'difficulty': 'moderate',
                        'description': 'Complete the Quran',
                        'icon_suggestion': '📖',
                      },
                      'day_plans': [
                        {'day': 1, 'task': 'Read Juz 1', 'task_short': 'Juz 1', 'estimated_minutes': 45},
                      ],
                      'tips': ['Read after Fajr'],
                    }),
                  }
                ]
              }
            }
          ]
        };

        mockDio.httpClientAdapter = MockDioAdapter((options, _, __) async {
          return ResponseBody.fromString(
            jsonEncode(validResponse),
            200,
            headers: {
              'content-type': ['application/json'],
            },
          );
        });

        service = AIService(
          dio: mockDio,
          workerUrl: 'https://test.workers.dev',
        );

        final result = await service.generatePlan(
          context: testContext,
          deviceId: testDeviceId,
        );

        expect(result.success, isTrue);
        expect(result.goal, isNotNull);
        expect(result.goal!.title, 'Read Quran in 30 Days');
        expect(result.dayPlans, hasLength(1));
        expect(result.tips, hasLength(1));
      });

      test('returns error response when AI returns no candidates', () async {
        mockDio.httpClientAdapter = MockDioAdapter((options, _, __) async {
          return ResponseBody.fromString(
            jsonEncode({'candidates': []}),
            200,
            headers: {
              'content-type': ['application/json'],
            },
          );
        });

        service = AIService(
          dio: mockDio,
          workerUrl: 'https://test.workers.dev',
        );

        final result = await service.generatePlan(
          context: testContext,
          deviceId: testDeviceId,
        );

        expect(result.success, isFalse);
        expect(result.errorMessage, contains('No response'));
      });

      test('returns error response when AI returns empty parts', () async {
        final emptyPartsResponse = {
          'candidates': [
            {
              'content': {
                'parts': []
              }
            }
          ]
        };

        mockDio.httpClientAdapter = MockDioAdapter((options, _, __) async {
          return ResponseBody.fromString(
            jsonEncode(emptyPartsResponse),
            200,
            headers: {
              'content-type': ['application/json'],
            },
          );
        });

        service = AIService(
          dio: mockDio,
          workerUrl: 'https://test.workers.dev',
        );

        final result = await service.generatePlan(
          context: testContext,
          deviceId: testDeviceId,
        );

        expect(result.success, isFalse);
        expect(result.errorMessage, contains('Empty response'));
      });

      test('returns error on rate limit (429)', () async {
        mockDio.httpClientAdapter = MockDioAdapter((options, _, __) async {
          return ResponseBody.fromString(
            'Rate limited',
            429,
            headers: {
              'content-type': ['text/plain'],
            },
          );
        });

        service = AIService(
          dio: mockDio,
          workerUrl: 'https://test.workers.dev',
        );

        final result = await service.generatePlan(
          context: testContext,
          deviceId: testDeviceId,
        );

        expect(result.success, isFalse);
        // After retries, should return error
        expect(result.errorMessage, isNotNull);
      });

      test('includes proper headers in request', () async {
        RequestOptions? capturedOptions;

        final validResponse = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'success': true,
                      'goal': {
                        'title': 'Goal',
                        'title_short': 'Goal',
                        'category': 'general',
                        'duration_days': 30,
                        'difficulty': 'easy',
                        'description': 'Description',
                        'icon_suggestion': '🎯',
                      },
                      'day_plans': [],
                    }),
                  }
                ]
              }
            }
          ]
        };

        mockDio.httpClientAdapter = MockDioAdapter((options, _, __) async {
          capturedOptions = options;
          return ResponseBody.fromString(
            jsonEncode(validResponse),
            200,
            headers: {
              'content-type': ['application/json'],
            },
          );
        });

        service = AIService(
          dio: mockDio,
          workerUrl: 'https://test.workers.dev',
        );

        await service.generatePlan(
          context: testContext,
          deviceId: testDeviceId,
        );

        expect(capturedOptions, isNotNull);
        expect(capturedOptions!.headers['Content-Type'], 'application/json');
        expect(capturedOptions!.headers['X-Device-Id'], testDeviceId);
      });

      test('includes prompt in request body', () async {
        Map<String, dynamic>? capturedBody;

        final validResponse = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'success': true,
                      'goal': {
                        'title': 'Goal',
                        'title_short': 'Goal',
                        'category': 'general',
                        'duration_days': 30,
                        'difficulty': 'easy',
                        'description': 'Description',
                        'icon_suggestion': '🎯',
                      },
                      'day_plans': [],
                    }),
                  }
                ]
              }
            }
          ]
        };

        mockDio.httpClientAdapter = MockDioAdapter((options, _, __) async {
          capturedBody = options.data as Map<String, dynamic>;
          return ResponseBody.fromString(
            jsonEncode(validResponse),
            200,
            headers: {
              'content-type': ['application/json'],
            },
          );
        });

        service = AIService(
          dio: mockDio,
          workerUrl: 'https://test.workers.dev',
        );

        await service.generatePlan(
          context: testContext,
          deviceId: testDeviceId,
        );

        expect(capturedBody, isNotNull);
        expect(capturedBody!['contents'], isNotNull);
        expect(capturedBody!['contents'][0]['parts'][0]['text'], isNotEmpty);
        expect(capturedBody!['generationConfig'], isNotNull);
        expect(capturedBody!['generationConfig']['responseMimeType'], 'application/json');
      });
    });
  });

  group('RateLimitedException', () {
    test('creates exception with message', () {
      const exception = RateLimitedException('Daily limit reached');

      expect(exception.message, 'Daily limit reached');
      expect(exception.toString(), 'Daily limit reached');
    });
  });
}
