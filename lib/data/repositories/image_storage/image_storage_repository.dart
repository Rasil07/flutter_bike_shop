abstract class ImageStorageRepository {
  Future<String> uploadImage(List<int> bytes);
  Future<void> deleteImage(String path);
}
