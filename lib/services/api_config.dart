import 'dart:io';

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid && !Platform.environment.containsKey('ANDROID_EMULATOR')) {
      return "http://192.168.11.107:8000";
    }

    if (Platform.isAndroid) {
      return "http://10.0.2.2:8000";
    }

    return "http://localhost:8000";
  }
}
