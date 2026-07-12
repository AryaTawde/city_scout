import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/city.dart';

class FavoriteService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addFavorite(City city) async {
    final uid = auth.currentUser!.uid;

    await firestore
        .collection("users")
        .doc(uid)
        .collection("favorites")
        .doc(city.name)
        .set({
      "name": city.name,
      "displayName": city.displayName,
      "latitude": city.latitude,
      "longitude": city.longitude,
      "imageUrl": city.imageUrl,
    });
  }

  Future<void> removeFavorite(String cityName) async {
    final uid = auth.currentUser!.uid;

    await firestore
        .collection("users")
        .doc(uid)
        .collection("favorites")
        .doc(cityName)
        .delete();
  }

  Stream<QuerySnapshot> getFavorites() {
    final uid = auth.currentUser!.uid;

    return firestore
        .collection("users")
        .doc(uid)
        .collection("favorites")
        .snapshots();
  }

  Future<bool> isFavorite(String cityName) async {
    final uid = auth.currentUser!.uid;

    final doc = await firestore
        .collection("users")
        .doc(uid)
        .collection("favorites")
        .doc(cityName)
        .get();

      return doc.exists;
  }
}