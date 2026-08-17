import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nid_mobile/core/config/app_config.dart';

class AuthApi {
  final http.Client _client;

  AuthApi({http.Client? client}) : _client = client ?? http.Client();

  Future<bool> sendOtp(String phoneNumber) async {
    try {
      final response = await _client.post(
        Uri.parse('${AppConfig.apiBaseUrl}/auth/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  Future<AuthTokens?> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${AppConfig.apiBaseUrl}/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'otp': otp}),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) return null;
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final accessToken = body['accessToken'] as String?;
      final refreshToken = body['refreshToken'] as String?;
      if (accessToken == null || refreshToken == null) return null;
      return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
    } catch (_) {
      return null;
    }
  }
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });
}
