import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

/// Service for managing device-specific information
class DeviceService {
  static const String _boxName = 'device';
  static const String _deviceIdKey = 'device_id';

  static Box? _box;

  /// Initialize the device service
  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  /// Get or create a persistent device ID
  static String getDeviceId() {
    if (_box == null) {
      throw StateError('DeviceService not initialized. Call DeviceService.init() first.');
    }

    String? deviceId = _box!.get(_deviceIdKey);
    if (deviceId == null) {
      deviceId = const Uuid().v4();
      _box!.put(_deviceIdKey, deviceId);
    }
    return deviceId;
  }

  /// Clear device data (for testing)
  static Future<void> clear() async {
    await _box?.clear();
  }
}
