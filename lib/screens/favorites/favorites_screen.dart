import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/favorite_service.dart';
import '../../models/city.dart';
import '../../widgets/place_card.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoriteService favoriteService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Cities ❤️"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: favoriteService.getFavorites(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No favorite cities yet ❤️",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final cities = docs.map((doc) {

            final data = doc.data() as Map<String, dynamic>;

            return City(
              name: data["name"],
              displayName: data["displayName"],
              latitude: data["latitude"],
              longitude: data["longitude"],
              imageUrl: data["imageUrl"],
            );

          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: cities.length,

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),

            itemBuilder: (context, index) {
              return PlaceCard(
                city: cities[index],
              );
            },
          );
        },
      ),
    );
  }
}