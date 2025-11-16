// lib/features/bikes/presentation/pages/bike_detail_page.dart

import 'package:bike_shop_2/app/core/widgets/image_urls.dart';

import 'package:bike_shop_2/features/bikes/view_model/bike_detail_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BikeDetailPage extends StatelessWidget {
  const BikeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BikeDetailViewModel>();
    final bike = vm.bike;

    final theme = Theme.of(context);
    final String? imageUrl = bike.imageUrl != null
        ? buildBikeImageUrl(bike.imageUrl!)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(bike.model),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: vm.isDeleting
                ? null
                : () => _confirmAndDelete(context, vm),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // IMAGE
                SizedBox(
                  height: 260,
                  child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, ___) => const Center(
                            child: Icon(Icons.broken_image, size: 40),
                          ),
                        )
                      : Container(
                          color: theme.colorScheme.surfaceVariant,
                          child: const Center(
                            child: Icon(Icons.directions_bike, size: 48),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              bike.model,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$${bike.price.toStringAsFixed(2)}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bike.brand,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Text(
                        'Description',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is a placeholder description for ${bike.model}. '
                        'Later you can extend your Bike model and Firestore schema '
                        'to include a real description, specs and more fields.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: vm.isDeleting ? null : () {},
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: const Text('Add to cart'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (vm.errorMessage != null) ...[
                        Text(
                          vm.errorMessage!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (vm.isDeleting)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmAndDelete(
    BuildContext context,
    BikeDetailViewModel vm,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete bike'),
            content: const Text(
              'Are you sure you want to delete this bike? '
              'This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) return;

    final success = await vm.deleteBike();

    if (!context.mounted) return;

    if (success) {
      context.pop(); // go back to list
    } else if (vm.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(vm.errorMessage!)));
    }
  }
}
