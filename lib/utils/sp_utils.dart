import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SpUtils {
  // 静态私有变量
  static SharedPreferences? _prefs;

  // 初始化方法，必须在 main.dart 中调用一次
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // --- 基础存取方法 ---

  static Future<bool> setString(String key, String value) => _prefs!.setString(key, value);

  static String getString(String key, {String defaultValue = ''}) {
    return _prefs!.getString(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) => _prefs!.setBool(key, value);

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs!.getBool(key) ?? defaultValue;
  }

  static Future<bool> remove(String key) => _prefs!.remove(key);

  static Future<bool> clear() => _prefs!.clear();

  // --- 业务特定方法：vdevice_guid ---

  static const String _keyGuid = 'vdevice_guid';

  /// 获取唯一的 vdevice_guid，如果不存在则生成并保存
  ///
  static String getVDeviceGuid() {
    String guid = getString(_keyGuid);
    if (guid.isEmpty) {
      guid = generateRandomHex(32);
      setString(_keyGuid, guid);
    }
    return guid;
  }

  // 内部辅助：生成随机十六进制字符串
  static String generateRandomHex(int length) {
    final random = Random();
    const chars = '0123456789abcdef';
    return List.generate(length, (index) => chars[random.nextInt(16)]).join();
  }
}