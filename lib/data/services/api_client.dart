import 'dart:convert';

import 'package:http/http.dart' as http;

/// Thrown when the API returns a non-2xx response.
class ApiException implements Exception {
  final int statusCode;
  final String? message;
  final dynamic data;

  ApiException({required this.statusCode, this.message, this.data});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message, data: $data)';
}

class ApiClient {
  final http.Client _client;
  final String baseURL;

  ApiClient({http.Client? client, required this.baseURL})
    : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _client.get(Uri.parse('$baseURL$endpoint'));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'GET request failed',
        data: response.body,
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse('$baseURL$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'POST request failed',
        data: response.body,
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
