import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ADPEnvironment {
  prod,
}

class EnvironmentConfig {
  static Future<void> init({
    required ADPEnvironment environment,
  }) async {
    await dotenv.load(
      fileName: 'env/.${environment.name}_env',
    );
  }

  static String get baseUrl {
    return dotenv.get('BASE_URL');
  }
}
