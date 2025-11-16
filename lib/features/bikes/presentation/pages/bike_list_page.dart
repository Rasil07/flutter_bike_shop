import 'package:bike_shop_2/features/bikes/presentation/widgets/bike_card.dart';
import 'package:bike_shop_2/features/bikes/view_model/bike_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bike_shop_2/features/bikes/presentation/route_names.dart';

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

    return Column(
      children: [
        // SEARCH BAR
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search bikes by model or brand',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              isDense: true,
            ),
            onChanged: vm.updateSearchQuery,
          ),
        ),
        const SizedBox(height: 8),

        // GRID OR EMPTY STATE
        Expanded(
          child: vm.bikes.isEmpty
              ? Center(
                  child: Text(
                    vm.searchQuery.isEmpty
                        ? 'No bikes found'
                        : 'No bikes match "${vm.searchQuery}"',
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: vm.bikes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final bike = vm.bikes[index];
                    return BikeCard(
                      bike: bike,
                      onTap: () {
                        context.pushNamed(
                          BikesRouteNames.detail,
                          pathParameters: {'id': bike.id},
                          extra: bike,
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
