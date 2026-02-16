import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'models/goal_context.dart';
import 'models/ai_response.dart';
import 'prompt_builder.dart';

/// Service for generating AI-powered goal plans via Cloudflare Worker proxy
class AIService {
  final Dio _dio;
  final PromptBuilder _promptBuilder;
  final String _workerUrl;

  static const int _maxRetries = 3;
  static const Duration _timeout = Duration(seconds: 60);

  AIService({
    Dio? dio,
    PromptBuilder? promptBuilder,
    String? workerUrl,
  })  : _dio = dio ?? Dio(),
        _promptBuilder = promptBuilder ?? const PromptBuilder(),
        _workerUrl = workerUrl ?? const String.fromEnvironment(
          'CLOUDFLARE_WORKER_URL',
          defaultValue: 'https://tasktrakr-ai.niyyah-app.workers.dev',
        );

  /// Generate a personalized goal plan using AI
  Future<TaskTrakrPlanResponse> generatePlan({
    required GoalContext context,
    required String deviceId,
  }) async {
    for (int attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        final response = await _callWorker(context, deviceId);
        final parsed = _parseResponse(response);

        if (parsed.success && parsed.goal != null) {
          return parsed;
        }

        // If response wasn't valid, retry
        if (attempt < _maxRetries - 1) {
          await _delay(attempt);
          continue;
        }

        return parsed;
      } on DioException catch (e) {
        if (attempt == _maxRetries - 1) {
          return _handleDioError(e);
        }
        await _delay(attempt);
      } catch (e) {
        if (attempt == _maxRetries - 1) {
          return TaskTrakrPlanResponse.error('Unexpected error: $e');
        }
        await _delay(attempt);
      }
    }

    return TaskTrakrPlanResponse.error('Failed after $_maxRetries attempts');
  }

  Future<Map<String, dynamic>> _callWorker(
    GoalContext context,
    String deviceId,
  ) async {
    final prompt = _promptBuilder.buildPrompt(context);

    final requestBody = {
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ]
        }
      ],
      'generationConfig': {
        'responseMimeType': 'application/json',
        'temperature': 0.7,
        'maxOutputTokens': 8192,
      }
    };

    debugPrint('AIService: Calling worker at $_workerUrl');

    final response = await _dio.post(
      _workerUrl,
      data: requestBody,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'X-Device-Id': deviceId,
        },
        sendTimeout: _timeout,
        receiveTimeout: _timeout,
      ),
    );

    if (response.statusCode == 429) {
      throw const RateLimitedException('Daily limit reached. Try again tomorrow.');
    }

    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Server returned ${response.statusCode}',
      );
    }

    return response.data as Map<String, dynamic>;
  }

  TaskTrakrPlanResponse _parseResponse(Map<String, dynamic> workerResponse) {
    try {
      // Gemini API response structure
      final candidates = workerResponse['candidates'] as List<dynamic>?;
      if (candidates == null || candidates.isEmpty) {
        return TaskTrakrPlanResponse.error('No response from AI');
      }

      final content = candidates[0]['content'] as Map<String, dynamic>?;
      final parts = content?['parts'] as List<dynamic>?;
      if (parts == null || parts.isEmpty) {
        return TaskTrakrPlanResponse.error('Empty response from AI');
      }

      final text = parts[0]['text'] as String?;
      if (text == null || text.isEmpty) {
        return TaskTrakrPlanResponse.error('No text in AI response');
      }

      // Parse the JSON from the text
      final jsonData = jsonDecode(text) as Map<String, dynamic>;
      return TaskTrakrPlanResponse.fromJson(jsonData);
    } catch (e) {
      debugPrint('AIService: Parse error - $e');
      return TaskTrakrPlanResponse.error('Failed to parse AI response: $e');
    }
  }

  TaskTrakrPlanResponse _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TaskTrakrPlanResponse.error(
          'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.connectionError:
        return TaskTrakrPlanResponse.error(
          'No internet connection. Please try again when online.',
        );
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 429) {
          return TaskTrakrPlanResponse.error(
            'Daily limit reached. Try again tomorrow.',
          );
        }
        return TaskTrakrPlanResponse.error(
          'Server error. Please try again later.',
        );
      default:
        return TaskTrakrPlanResponse.error(
          'Network error. Please try again.',
        );
    }
  }

  Future<void> _delay(int attempt) async {
    final seconds = pow(2, attempt).toInt();
    await Future.delayed(Duration(seconds: seconds));
  }
}

/// Exception for rate limiting
class RateLimitedException implements Exception {
  final String message;
  const RateLimitedException(this.message);

  @override
  String toString() => message;
}
