import 'package:bike_shop_2/data/repositories/bike/bike_repository.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';
import 'package:flutter/material.dart';

class BikeListViewModel extends ChangeNotifier {
  // ViewModel logic for Bike List Page

  final BikeRepository _bikeRepository;

  BikeListViewModel({required BikeRepository bikeRepository})
    : _bikeRepository = bikeRepository;

  List<Bike> _bikes = [];
  List<Bike> get bikes => _bikes;

  Future<void> fetchBikes() async {
    _bikes = await _bikeRepository.listBikes();
    notifyListeners();
  }
}
