import 'package:flutter/material.dart';
import '../models/city.dart';
import '../screens/details/city_details_screen.dart';
import '../services/favorite_service.dart';

class PlaceCard extends StatefulWidget {
  final City city;

  const PlaceCard({super.key, required this.city});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  final FavoriteService favoriteService = FavoriteService();

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    isFavorite = await favoriteService.isFavorite(
      widget.city.name
      );

    setState(() {});
  }

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
                city: widget.city
                ),
            ),
          );
        },

        child: Stack(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.city.imageUrl != null
                          ? Image.network(
                              widget.city.imageUrl!,
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
                      widget.city.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      widget.city.displayName,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),

                    const Spacer(),

                    Text("📍 ${widget.city.latitude.toStringAsFixed(2)}"),

                    Text("🌍 ${widget.city.longitude.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  if (isFavorite) {
                    await favoriteService.removeFavorite(widget.city.name);
                  } else {
                    await favoriteService.addFavorite(widget.city);
                  }
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}