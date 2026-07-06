import 'package:flutter/material.dart';
import '../models/city.dart';
import '../screens/details/city_details_screen.dart';

class PlaceCard extends StatelessWidget {
  final City city;

  const PlaceCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      
      child: InkWell(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CityDetailsScreen(
            city: city,
          ),
        ),
      );
      },
      
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: city.imageUrl != null
                    ? Image.network(
                        city.imageUrl!,
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 110,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.location_city,
                          size: 55,
                          color: Colors.deepPurple,
                        ),
                      ),
              ),

              const SizedBox(height: 12),

              Text(
                city.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                city.displayName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),

              const Spacer(),

              Text("📍 ${city.latitude.toStringAsFixed(2)}"),

              Text("🌍 ${city.longitude.toStringAsFixed(2)}"),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
