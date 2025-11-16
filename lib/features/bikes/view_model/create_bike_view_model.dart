import 'package:flutter/foundation.dart';
import 'package:bike_shop_2/data/repositories/bike/bike_repository_remote.dart';

class BikeCreateViewModel extends ChangeNotifier {
  final BikeRepositoryRemote _repository;

  BikeCreateViewModel({required BikeRepositoryRemote repository})
    : _repository = repository;

  bool _isSubmitting = false;
  String? _errorMessage;

  Uint8List? _imageBytes;
  String? _imageFileName;

  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  Uint8List? get imageBytes => _imageBytes;
  String? get imageFileName => _imageFileName;

  void setImage(Uint8List bytes, String fileName) {
    _imageBytes = bytes;
    _imageFileName = fileName;
    notifyListeners();
  }

  void clearImage() {
    _imageBytes = null;
    _imageFileName = null;
    notifyListeners();
  }

  Future<bool> submit({
    required String model,
    required String brand,
    required double price,
  }) async {
    if (_isSubmitting) return false;

    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.createBike(
        model: model,
        brand: brand,
        price: price,
        imageBytes: _imageBytes,
      );

      _isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e, st) {
      _errorMessage = 'Failed to create bike';
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }
}
