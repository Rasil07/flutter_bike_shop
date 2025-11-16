import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';

import 'dart:developer';

class BikeFirestoreService {
  final FirebaseFirestore _firestore;

  BikeFirestoreService(this._firestore);

  Future<List<Bike>> listBikes() async {
    final querySnapshot = await _firestore.collection('bikes').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Bike(
        id: doc.id,
        brand: data['brand'] ?? '',
        model: data['model'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        imageUrl: data['imageUrl'] ?? '',
      );
    }).toList();
  }

  Future<Bike?> getBikeById(String id) async {
    final docSnapshot = await _firestore.collection('bikes').doc(id).get();
    if (docSnapshot.exists) {
      // Convert document data to Bike object
      return null;
    } else {
      return null;
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> createBike(Bike bike) async {
    return await _firestore.collection('bikes').add(bike.toMap());
  }

  Future<void> updateBike(Bike bike) async {
    await _firestore.collection('bikes').doc(bike.id).update(bike.toMap());
  }

  Future<void> deleteBike(String id) async {
    await _firestore.collection('bikes').doc(id).delete();
  }
}
