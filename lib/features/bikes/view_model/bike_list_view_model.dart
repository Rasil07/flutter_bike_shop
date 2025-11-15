import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';
import 'package:flutter/material.dart';

class BikeListViewModel extends ChangeNotifier {
  // ViewModel logic for Bike List Page

  final BikeRepositoryRemote _bikeRepository;

  BikeListViewModel({required BikeRepositoryRemote bikeRepository})
    : _bikeRepository = bikeRepository;

  bool _isFetchingBikes = false;
  String? _errorMessage;
  List<Bike> _bikes = [];
  List<Bike> get bikes => _bikes;
  bool get isFetchingBikes => _isFetchingBikes;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBikes() async {
    _isFetchingBikes = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _bikes = await _bikeRepository.listBikes();
    } catch (e) {
      _errorMessage = 'Failed to fetch bikes: $e';
    } finally {
      _isFetchingBikes = false;
      notifyListeners();
    }
  }
}
