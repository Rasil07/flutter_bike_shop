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

  // All bikes from Firestore
  List<Bike> _allBikes = [];

  List<Bike> _bikes = [];
  List<Bike> get bikes => _bikes;

  bool get isFetchingBikes => _isFetchingBikes;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  String _searchQuery = '';

  Future<void> fetchBikes() async {
    _isFetchingBikes = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _allBikes = await _bikeRepository.listBikes();
      _applyFilter();
    } catch (e) {
      _errorMessage = 'Failed to fetch bikes: $e';
      _allBikes = [];
      _bikes = [];
    } finally {
      _isFetchingBikes = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    _applyFilter();
  }

  void _applyFilter() {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      _bikes = List.unmodifiable(_allBikes);
    } else {
      _bikes = _allBikes
          .where((bike) {
            final model = bike.model.toLowerCase();
            final brand = bike.brand.toLowerCase();
            return model.contains(query) || brand.contains(query);
          })
          .toList(growable: false);
    }

    notifyListeners();
  }
}
