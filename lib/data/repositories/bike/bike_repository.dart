import 'package:bike_shop_2/domain/bike/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> listBikes();
  Future<Bike?> getBikeById(String id);
  Future<void> createBike(Bike bike);
  Future<void> updateBike(Bike bike);
  Future<void> deleteBike(String id);
}
