import 'package:bike_shop_2/data/services/api_client.dart';

class CloudWorkerService {
  final ApiClient _apiClient;
  CloudWorkerService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<String> uploadFile(List<int> bytes) async {
    // Implementation for uploading file to cloud worker

    final response = await _apiClient.postMultipart(
      '/upload',
      fileBytes: bytes,
      fileField: 'file',
    );
    return response['key'] as String? ?? '';
  }

  Future<bool> deleteFile(String key) async {
    // Implementation for deleting file from cloud worker
    final encodedKey = Uri.encodeQueryComponent(key);
    final endpoint = '/file?key=$encodedKey'; // adjust path
    final response = await _apiClient.delete(endpoint);
    return response['success'] as bool? ?? false;
  }
}
