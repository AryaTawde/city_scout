import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String cityName;
  final double rating;
  final int attractions;

  const PlaceCard({
    super.key,
    required this.cityName,
    required this.rating,
    required this.attractions,
    });

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            cityName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text("⭐ Rating: $rating"),

          Text("📍 Attractions: $attractions"),
        ],
        )
      ), 
    );
  }
}