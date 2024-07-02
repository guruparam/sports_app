import 'package:flutter/foundation.dart';

class Urls {
  static const String APP_URL_ANDROID_IOS = 'http://10.0.2.2:8000'; // Android and iOS URL
  static const String APP_URL_WEB = 'http://127.0.0.1:8000'; // Web URL

  static String get appUrl {
    // Determine platform and return the appropriate URL
    if (kIsWeb) {
      return APP_URL_WEB;
    } else {
      return APP_URL_ANDROID_IOS;
    }
  }
}
