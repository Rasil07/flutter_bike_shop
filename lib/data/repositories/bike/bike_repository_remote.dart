import 'dart:developer';

import 'package:bike_shop_2/data/repositories/bike/bike_repository.dart';
import 'package:bike_shop_2/data/services/bike/bike_service.dart';

import 'package:bike_shop_2/domain/bike/bike.dart';

class BikeRepositoryRemote implements BikeRepository {
  // Implementation of the BikeRepository methods

  final BikeService _bikeService;

  BikeRepositoryRemote({required BikeService bikeService})
    : _bikeService = bikeService;

  @override
  Future<List<Bike>> listBikes() async {
    List<Bike> bikes = await _bikeService.listBikes();
    inspect(bikes);
    return bikes;
  }

  @override
  Future<Bike?> getBikeById(String id) {
    // TODO: implement getBikeById
    throw UnimplementedError();
  }

  @override
  Future<void> createBike(Bike bike) {
    // TODO: implement createBike
    throw UnimplementedError();
  }

  @override
  Future<void> updateBike(Bike bike) {
    // TODO: implement updateBike
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBike(String id) {
    // TODO: implement deleteBike
    throw UnimplementedError();
  }
}
