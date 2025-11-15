import 'package:bike_shop_2/app/app_state.dart';
import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';
import 'package:bike_shop_2/data/services/api_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_shop_2/data/services/firestore/bike_firestore_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:bike_shop_2/data/services/bike/bike_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ApplicationState()),
  // Add your providers here
  Provider<ApiClient>(
    create: (_) => ApiClient(baseURL: dotenv.env['SERVER_API']!),
  ),

  Provider(create: (_) => BikeFirestoreService(FirebaseFirestore.instance)),
  Provider<BikeService>(
    create: (context) => BikeService(
      bikeFirestoreService: context.read<BikeFirestoreService>(),
      apiClient: context.read<ApiClient>(),
    ),
  ),

  Provider(
    create: (context) =>
        BikeRepositoryRemote(bikeService: context.read<BikeService>()),
  ), // Placeholder for BikeRepositoryRemote
];
