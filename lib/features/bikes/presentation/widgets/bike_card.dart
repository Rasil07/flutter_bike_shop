// lib/features/bikes/presentation/widgets/bike_card.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:bike_shop_2/domain/bike/bike.dart';

final String cloudflareWorkerBaseUrl = dotenv.env["SERVER_API"]!;

String buildBikeImageUrl(String imageKey) {
  final encodedKey = Uri.encodeComponent(imageKey);
  // adjust this path to match your Worker route
  return '$cloudflareWorkerBaseUrl/file?key=$encodedKey';
}

class BikeCard extends StatelessWidget {
  final Bike bike;
  const BikeCard({super.key, required this.bike});

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = bike.imageUrl != null
        ? buildBikeImageUrl(bike.imageUrl!)
        : null;

    print('imageUrl: $imageUrl');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            )
          else
            const SizedBox(
              height: 160,
              child: Center(child: Icon(Icons.directions_bike, size: 48)),
            ),
          ListTile(
            title: Text(bike.model),
            subtitle: Text(bike.brand),
            trailing: Text(
              '\$${bike.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
