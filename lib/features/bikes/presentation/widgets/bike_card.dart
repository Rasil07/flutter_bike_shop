// lib/features/bikes/presentation/widgets/bike_card.dart
import 'package:bike_shop_2/app/core/widgets/image_urls.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:bike_shop_2/domain/bike/bike.dart';

class BikeCard extends StatelessWidget {
  final Bike bike;

  final VoidCallback? onTap;
  const BikeCard({super.key, required this.bike, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String? imageUrl = bike.imageUrl != null
        ? buildBikeImageUrl(bike.imageUrl!)
        : null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // IMAGE
            SizedBox(
              height: 120,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (_, __, ___) =>
                          const Center(child: Icon(Icons.broken_image)),
                    )
                  : const Center(child: Icon(Icons.directions_bike, size: 32)),
            ),

            // TEXT AREA
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Model + price in one row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          bike.model,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${bike.price.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bike.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
