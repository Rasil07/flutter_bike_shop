import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';
import 'package:flutter/material.dart';

class BikeDetailViewModel extends ChangeNotifier {
  final BikeRepositoryRemote _repository;
  final Bike bike;

  BikeDetailViewModel({
    required BikeRepositoryRemote repository,
    required this.bike,
  }) : _repository = repository;

  bool _isDeleting = false;
  String? _errorMessage;

  bool get isDeleting => _isDeleting;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteBike() async {
    if (_isDeleting) return false;

    _isDeleting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.deleteBike(bike);
      _isDeleting = false;
      notifyListeners();
      return true;
    } catch (e, st) {
      _errorMessage = 'Failed to delete bike';
      _isDeleting = false;
      notifyListeners();
      return false;
    }
  }
}
