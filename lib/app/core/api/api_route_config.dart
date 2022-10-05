import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_marvel_dev/app/core/utils/hash_calculator.dart';

class ApiRouteConfig {
  static String get baseUrl => dotenv.get('BASE_URL', fallback: null);
  static String get publicApiKey =>
      dotenv.get('PUBLIC_API_KEY', fallback: null);
  static String get privateApiKey =>
      dotenv.get('PRIVATE_API_KEY', fallback: null);
  static String get hashConf =>
      CodeCalculator(publicApiKey: publicApiKey, privateApiKey: privateApiKey)
          .code;
  static Future<void> loadEnviroments() async {
    if (kReleaseMode) {
      await dotenv.load(fileName: '.env.production');
    } else {
      await dotenv.load(fileName: '.env.development');
    }
  }
}
