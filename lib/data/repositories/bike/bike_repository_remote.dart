import 'dart:developer';
import 'package:bike_shop_2/data/repositories/bike/bike_repository.dart';
import 'package:bike_shop_2/data/services/cloud_worker/cloud_worker_service.dart';
import 'package:bike_shop_2/data/services/firestore/bike_firestore_service.dart';

import 'package:bike_shop_2/domain/bike/bike.dart';

class BikeRepositoryRemote implements BikeRepository {
  // Implementation of the BikeRepository methods

  final BikeFirestoreService _bikeFirestoreService;
  final CloudWorkerService _cloudWorkerService;

  BikeRepositoryRemote({
    required BikeFirestoreService bikeFirestoreService,
    required CloudWorkerService cloudWorkerService,
  }) : _bikeFirestoreService = bikeFirestoreService,
       _cloudWorkerService = cloudWorkerService;

  @override
  Future<List<Bike>> listBikes() async {
    List<Bike> bikes = await _bikeFirestoreService.listBikes();
    return bikes;
  }

  @override
  Future<void> createBike({
    required String model,
    required String brand,
    required double price,
    List<int>? imageBytes,
  }) async {
    String imageUrl = await _cloudWorkerService.uploadFile(imageBytes!);

    await _bikeFirestoreService.createBike(
      Bike(
        id: '',
        model: model,
        brand: brand,
        price: price,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  Future<void> deleteBike(Bike bike) async {
    await _cloudWorkerService.deleteFile(bike.imageUrl!);
    await _bikeFirestoreService.deleteBike(bike.id);
  }
}
