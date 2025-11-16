// lib/app/core/widgets/image_urls.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String cloudflareWorkerBaseUrl = dotenv.env["SERVER_API"]!;

String buildBikeImageUrl(String imageKey) {
  final encodedKey = Uri.encodeComponent(imageKey);
  // adjust this path to match your Worker route
  return '$cloudflareWorkerBaseUrl/file?key=$encodedKey';
}
