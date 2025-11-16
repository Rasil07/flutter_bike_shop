import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';
import 'package:bike_shop_2/features/bikes/presentation/pages/bike_detail_page.dart';
import 'package:bike_shop_2/features/bikes/view_model/bike_detail_view_model.dart';
import 'package:bike_shop_2/features/bikes/view_model/bike_list_view_model.dart';
import 'package:bike_shop_2/features/bikes/view_model/create_bike_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'pages/bike_list_page.dart';
import 'pages/bike_create_page.dart';
import 'package:bike_shop_2/features/bikes/presentation/route_names.dart';

/// Route names (stable identifiers for deep links/analytics/tests)
///

Widget _fade(
  BuildContext _,
  Animation<double> a,
  Animation<double> __,
  Widget child,
) {
  final curved = CurvedAnimation(parent: a, curve: Curves.easeOutCubic);
  return FadeTransition(opacity: curved, child: child);
}

final List<RouteBase> bikesRoutes = <RouteBase>[
  GoRoute(
    path: bikesListPath,
    name: BikesRouteNames.list,
    builder: (context, state) {
      final viewModel = BikeListViewModel(
        bikeRepository: context.read<BikeRepositoryRemote>(),
      )..fetchBikes();
      return BikeListPage(viewModel: viewModel);
    },
  ),
  GoRoute(
    path: bikeCreatePath,
    name: BikesRouteNames.create,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (context) => BikeCreateViewModel(
          repository: context.read<BikeRepositoryRemote>(),
        ),
        child: const BikeCreatePage(),
      );
    },
  ),

  GoRoute(
    path: bikeDetailPath,
    name: BikesRouteNames.detail,
    builder: (context, state) {
      final bike = state.extra! as Bike;

      return ChangeNotifierProvider(
        create: (context) => BikeDetailViewModel(
          repository: context.read<BikeRepositoryRemote>(),
          bike: bike,
        ),
        child: const BikeDetailPage(),
      );
    },
  ),
];
