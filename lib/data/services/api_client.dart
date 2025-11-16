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

  /// Multipart/form-data upload.
  /// Returns decoded JSON (e.g. { "key": "bikes/uuid.jpg" }).
  Future<Map<String, dynamic>> postMultipart(
    String endpoint, {
    required List<int> fileBytes,
    String fileField = 'file', // must match your Worker field name
    String fileName = 'file.jpg',
    Map<String, String>? fields, // extra text fields
    Map<String, String>? headers, // extra headers (e.g. auth)
  }) async {
    final uri = Uri.parse('$baseURL$endpoint');

    final request = http.MultipartRequest('POST', uri);

    // Add any additional text fields
    if (fields != null) {
      request.fields.addAll(fields);
    }

    // Add file
    request.files.add(
      http.MultipartFile.fromBytes(
        fileField,
        fileBytes,
        filename: fileName,
        // contentType: MediaType('image', 'jpeg'), // only if you really need it
      ),
    );

    // Add headers (do NOT set content-type yourself for multipart)
    if (headers != null) {
      request.headers.addAll(headers);
    }

    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Multipart POST request failed',
        data: response.body,
      );
    }

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw ApiException(
      statusCode: response.statusCode,
      message: 'Expected JSON object from multipart response',
      data: response.body,
    );
  }

  /// DELETE request.
  /// Use this for your Worker delete route: `/delete-bike-image?key=...`.
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await _client.delete(Uri.parse('$baseURL$endpoint'));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'DELETE request failed',
        data: response.body,
      );
    }

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: 'Expected JSON object from DELETE response',
      data: response.body,
    );
  }
}
