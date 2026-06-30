import 'package:flutter/material.dart';
import '../models/city.dart';

class PlaceCard extends StatelessWidget {
  final City city;

  const PlaceCard({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                city.image,
                style: const TextStyle(fontSize: 45),
              ),

              const SizedBox(height: 10),

              Text(
                city.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(city.rating.toString()),
                ],
              ),

              const SizedBox(height: 8),

              Text("${city.attractions} Attractions"),

              const SizedBox(height: 8),

              Text(
                city.food,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                city.culture,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}