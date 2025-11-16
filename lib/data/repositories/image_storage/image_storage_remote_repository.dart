import 'package:bike_shop_2/data/repositories/image_storage/image_storage_repository.dart';
import 'package:bike_shop_2/data/services/api_client.dart';

class ImageStorageRemoteRepository implements ImageStorageRepository {
  final ApiClient _apiClient;

  ImageStorageRemoteRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<String> uploadImage(List<int> bytes) async {
    // Implementation for uploading image to remote storage
    // Return the URL of the uploaded image
    final response = await _apiClient.postMultipart(
      '/upload',
      fileBytes: bytes,
      fileField: 'file',
    );

    return response['key'] as String? ?? '';
  }

  @override
  Future<void> deleteImage(String path) async {
    // Implementation for deleting image from remote storage
  }
}
