import 'package:flutter/material.dart';
import '../../models/city.dart';
import '../../services/weather_service.dart';
import '../../models/weather.dart';
import '../../utils/weather_helper.dart';

class CityDetailsScreen extends StatefulWidget {
  final City city;

  const CityDetailsScreen({
    super.key,
    required this.city,
  });

  @override
  State<CityDetailsScreen> createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  final WeatherService weatherService = WeatherService();

  Weather? weather;
  bool isLoading = true;

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
      );
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.city.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Icon(
                Icons.location_city,
                size: 90,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.city.displayName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
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
              const Center(
                child: CircularProgressIndicator(),
              )
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

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Column(
                          children: [
                            Icon(Icons.air),
                            Text("${weather!.windSpeed} km/h"),
                          ],
                        ),

                        Column(
                          children: [
                            Icon(Icons.water_drop),
                            Text("${weather!.humidity}%"),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}