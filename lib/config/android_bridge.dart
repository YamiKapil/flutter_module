import 'package:flutter/services.dart';

class AndroidBridge {
  static const _channel = MethodChannel('com.example.androidlogin/config');

  static Future<Map<String, dynamic>> getInitialData() async {
    final data = await _channel.invokeMethod<Map<dynamic, dynamic>>('getInitialData');
    return data != null
        ? Map<String, dynamic>.from(data)
        : {};
  }
}