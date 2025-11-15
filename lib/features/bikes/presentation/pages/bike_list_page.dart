import 'package:bike_shop_2/features/bikes/presentation/widgets/bike_card.dart';
import 'package:bike_shop_2/features/bikes/view_model/bike_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String cloudflareWorkerBaseUrl =
    'https://flutter-bike-api.rasil-baidar44.workers.dev';

String buildBikeImageUrl(String imageKey) {
  final encodedKey = Uri.encodeComponent(imageKey);
  // adjust this path to match your Worker route
  return '$cloudflareWorkerBaseUrl/file?key=$encodedKey';
}

class BikeListPage extends StatelessWidget {
  final BikeListViewModel viewModel;
  const BikeListPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Our Bike Collection")),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: const _BikeListView(),
      ),
    );
  }
}

class _BikeListView extends StatelessWidget {
  const _BikeListView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BikeListViewModel>();

    if (vm.isFetchingBikes) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(child: Text(vm.errorMessage!));
    }

    if (vm.bikes.isEmpty) {
      return const Center(child: Text('No bikes found'));
    }

    return ListView.builder(
      itemCount: vm.bikes.length,
      itemBuilder: (context, index) {
        final bike = vm.bikes[index];
        return BikeCard(bike: bike);
      },
    );
  }
}
