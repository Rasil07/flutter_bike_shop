import 'package:bike_shop_2/data/repositories/bike/bike_repository.dart';
import 'package:bike_shop_2/data/services/api_client.dart';
import 'package:bike_shop_2/data/services/firestore/bike_firestore_service.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';

class BikeService implements BikeRepository {
  final BikeFirestoreService _bikeFirestoreService;
  final ApiClient _apiClient;
  BikeService({
    required ApiClient apiClient,
    required BikeFirestoreService bikeFirestoreService,
  }) : _apiClient = apiClient,
       _bikeFirestoreService = bikeFirestoreService;

  @override
  Future<List<Bike>> listBikes() async {
    List<Bike> firestoreBikes = await _bikeFirestoreService.listBikes();
    return firestoreBikes;
  }

  @override
  Future<Bike?> getBikeById(String id) {
    return Future.value(null);
  }

  @override
  Future<void> createBike(Bike bike) {
    return Future.value();
  }

  @override
  Future<void> updateBike(Bike bike) {
    return Future.value();
  }

  @override
  Future<void> deleteBike(String id) {
    return Future.value();
  }
}
