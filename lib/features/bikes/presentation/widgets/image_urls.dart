const String cloudflareWorkerBaseUrl =
    'https://flutter-bike-api.rasil-baidar44.workers.dev';

String buildBikeImageUrl(String imageKey) {
  final encodedKey = Uri.encodeComponent(imageKey);
  // adjust this path to match your Worker route
  return '$cloudflareWorkerBaseUrl/file?key=$encodedKey';
}
