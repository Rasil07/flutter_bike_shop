import 'package:bike_shop_2/domain/bike/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> listBikes();

  Future<void> createBike({
    required String model,
    required String brand,
    required double price,
    List<int>? imageBytes,
  });

  Future<void> deleteBike(Bike bike);
}
