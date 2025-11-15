abstract class ImageStorageRepository {
  Future<String> uploadImage(String path, List<int> bytes);
  Future<void> deleteImage(String path);
  Future<String> getPresignedUrl(String path, {Duration validFor});
}
