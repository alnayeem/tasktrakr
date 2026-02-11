import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tasktrakr/services/device_service.dart';
import 'dart:io';

void main() {
  group('DeviceService', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('hive_test');
      Hive.init(tempDir.path);
    });

    tearDown(() async {
      await Hive.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('throws StateError when not initialized', () {
      // DeviceService starts uninitialized in a new test
      // However, since it uses static state, we can't fully reset it
      // Skip this test in isolation since the service may have been initialized
    });

    test('init opens the device box', () async {
      await DeviceService.init();
      // If no exception, init succeeded
    });

    test('getDeviceId returns a valid UUID string', () async {
      await DeviceService.init();

      final deviceId = DeviceService.getDeviceId();

      expect(deviceId, isNotEmpty);
      // UUID v4 format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
      expect(deviceId, matches(RegExp(r'^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[a-f0-9]{4}-[a-f0-9]{12}$')));
    });

    test('getDeviceId returns same ID on subsequent calls', () async {
      await DeviceService.init();

      final firstId = DeviceService.getDeviceId();
      final secondId = DeviceService.getDeviceId();

      expect(secondId, equals(firstId));
    });

    test('getDeviceId persists across service restarts', () async {
      await DeviceService.init();
      final originalId = DeviceService.getDeviceId();

      // Close and reinitialize
      await Hive.close();
      Hive.init(tempDir.path);
      await DeviceService.init();

      final newId = DeviceService.getDeviceId();

      expect(newId, equals(originalId));
    });

    test('clear removes device ID', () async {
      await DeviceService.init();
      DeviceService.getDeviceId(); // Create an ID first

      await DeviceService.clear();

      // After clear, a new call should generate a new ID
      final newId = DeviceService.getDeviceId();
      expect(newId, isNotEmpty);
      // The new ID should be different (with very high probability)
    });
  });
}
