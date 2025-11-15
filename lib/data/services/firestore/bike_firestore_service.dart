import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_shop_2/domain/bike/bike.dart';

import 'dart:developer';

class BikeFirestoreService {
  final FirebaseFirestore _firestore;

  BikeFirestoreService(this._firestore);

  @override
  Future<List<Bike>> listBikes() async {
    final querySnapshot = await _firestore.collection('bikes').get();
    print("Bikes fetched: ${querySnapshot.docs.length}");
    inspect(querySnapshot);
    return [];
  }

  @override
  Future<Bike?> getBikeById(String id) async {
    final docSnapshot = await _firestore.collection('bikes').doc(id).get();
    if (docSnapshot.exists) {
      // Convert document data to Bike object
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<void> createBike(Bike bike) async {
    final docRef = await _firestore.collection('bikes').add(bike.toMap());
    print("Bike created with ID: ${docRef.id}");
    inspect(docRef);
  }

  @override
  Future<void> updateBike(Bike bike) async {
    await _firestore.collection('bikes').doc(bike.id).update(bike.toMap());
    print("Bike updated with ID: ${bike.id}");
  }

  @override
  Future<void> deleteBike(String id) async {
    await _firestore.collection('bikes').doc(id).delete();
    print("Bike deleted with ID: $id");
  }
}
