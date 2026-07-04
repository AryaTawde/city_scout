import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  Future<Weather> getWeather(
      double latitude,
      double longitude,
      ) async {

    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?"
      "latitude=$latitude"
      "&longitude=$longitude"
      "&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final json = jsonDecode(response.body);

      return Weather.fromJson(json["current"]);

    } else {
      throw Exception("Failed to load weather");
    }
  }
}