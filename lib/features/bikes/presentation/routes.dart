import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';
import 'package:bike_shop_2/features/bikes/view_model/bike_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'pages/bike_list_page.dart';
import 'pages/bike_create_page.dart';

/// Route names (stable identifiers for deep links/analytics/tests)
abstract class BikesRouteNames {
  static const list = 'bikes:list';
  static const detail = 'bikes:detail';
  static const create = 'bikes:create';
}

/// Paths (single source of truth)
const bikesListPath = '/bikes';
const bikeCreatePath = '/bikes/new';
const bikeDetailPath = '/bikes/:id';

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
    builder: (context, state) => const BikeCreatePage(),
  ),
];
