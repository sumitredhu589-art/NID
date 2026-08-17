import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nid_mobile/core/config/app_config.dart';

class AiApi {
  final http.Client _client;

  AiApi({http.Client? client}) : _client = client ?? http.Client();

  Future<String?> sendPrompt({
    required String prompt,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${AppConfig.apiBaseUrl}/ai/chat'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'prompt': prompt}),
      );
      if (response.statusCode < 200 || response.statusCode >= 300) return null;
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['message'] as String?;
    } catch (_) {
      return null;
    }
  }
}
