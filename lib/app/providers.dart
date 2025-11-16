import 'package:bike_shop_2/app/app_state.dart';
import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';
import 'package:bike_shop_2/data/services/api_client.dart';
import 'package:bike_shop_2/data/services/cloud_worker/cloud_worker_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_shop_2/data/services/firestore/bike_firestore_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ApplicationState()),
  // Add your providers here
  Provider<ApiClient>(
    create: (_) => ApiClient(baseURL: dotenv.env['SERVER_API']!),
  ),

  Provider(create: (_) => BikeFirestoreService(FirebaseFirestore.instance)),
  Provider(
    create: (context) =>
        CloudWorkerService(apiClient: context.read<ApiClient>()),
  ),

  Provider(
    create: (context) => BikeRepositoryRemote(
      bikeFirestoreService: context.read<BikeFirestoreService>(),
      cloudWorkerService: context.read<CloudWorkerService>(),
    ),
  ), // Placeholder for BikeRepositoryRemote
];
