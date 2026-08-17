import 'package:flutter/foundation.dart';

class AppConfig {
  static const String _configuredApiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static String get apiBaseUrl {
    if (_configuredApiBaseUrl.isNotEmpty) {
      return _configuredApiBaseUrl;
    }
    if (kIsWeb) {
      return 'http://localhost:4000/api';
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'http://10.0.2.2:4000/api',
      _ => 'http://localhost:4000/api',
    };
  }
}
