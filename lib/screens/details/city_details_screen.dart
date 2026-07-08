import 'package:flutter/material.dart';
import '../../models/city.dart';
import '../../services/weather_service.dart';
import '../../models/weather.dart';
import '../../utils/weather_helper.dart';
import '../../services/wiki_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../models/place.dart';
import '../../services/place_service.dart';
import '../../models/restaurant.dart';
import '../../services/restaurant_service.dart';
import '../../services/ai_service.dart';

class CityDetailsScreen extends StatefulWidget {
  final City city;

  const CityDetailsScreen({super.key, required this.city});

  @override
  State<CityDetailsScreen> createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  final WeatherService weatherService = WeatherService();

  Weather? weather;
  bool isLoading = true;

  final WikiService wikiService = WikiService();
  String? description;

  final PlaceService placeService = PlaceService();
  List<Place> attractions = [];

  final RestaurantService restaurantService = RestaurantService();
  List<Restaurant> restaurants = [];

  final AIService aiService = AIService();
  String? tripPlan;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      weather = await weatherService.getWeather(
        widget.city.latitude, 
        widget.city.longitude,
      );//for search city weather
    } catch (e) { print(e); }

    try {
      description = await wikiService.getDescription(
        widget.city.name,
      ); // for city description
    } catch (e) { print(e); }
    
    try {
      attractions = await placeService.getAttractions(
       widget.city.latitude, 
        widget.city.longitude,
      );// for attractions
    } catch (e) { print(e); }
      
    try {
      restaurants = await restaurantService.getRestaurants(
        widget.city.latitude,
        widget.city.longitude,
      ); // for reastaurants
    } catch (e) { print(e); }

    try{
      tripPlan = await aiService.generateTripPlan(
        city: widget.city.name,
        weather:
          "${weather!.temperature}°C, ${weatherDescription(weather!.weatherCode)}",
        attractions: attractions
          .map((e) => e.name)
          .take(5)
          .toList(),
        restaurants: restaurants
          .map((e) => e.name)
          .take(5)
          .toList(),
      );//for ai_trip
    } catch (e) {print(e);} 

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.city.name)),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: widget.city.imageUrl != null
                    ? Image.network(
                        widget.city.imageUrl!,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.location_city,
                        size: 90,
                        color: Colors.deepPurple,
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.city.displayName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Latitude"),
                subtitle: Text(widget.city.latitude.toString()),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.public),
                title: const Text("Longitude"),
                subtitle: Text(widget.city.longitude.toString()),
              ),
            ),
            const SizedBox(height: 20),

            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Text(
                        "${weather!.temperature}°C",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        weatherDescription(weather!.weatherCode),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.air),
                              Text("${weather!.windSpeed} km/h"),
                            ],
                          ),

                          Column(
                            children: [
                              const Icon(Icons.water_drop),
                              Text("${weather!.humidity}%"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 25),

            const Text(
              "Location",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      widget.city.latitude,
                      widget.city.longitude,
                    ),
                    initialZoom: 12,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: "com.example.city_scout",
                    ),

                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            widget.city.latitude,
                            widget.city.longitude,
                          ),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "About",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  description ?? "No description available.",
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Top Attractions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...attractions
            .take(10)
            .map(
              (place) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.place,
                      color: Colors.deepPurple,
                    ),
                    title: Text(place.name),
                  ),
                ),
              ),
                
            const SizedBox(height: 25),

            const Text(
              "Nearby Restaurants",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...restaurants.take(8).map(
              (restaurant) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.restaurant,
                    color: Colors.orange,
                  ),
                  title: Text(restaurant.name),
                ),
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              "🤖 AI Travel Planner",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  tripPlan ?? "Generating itinerary...",
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            
          ],//main children widget
        ),
      ),
    );
  }
}
