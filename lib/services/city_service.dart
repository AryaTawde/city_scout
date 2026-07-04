import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/city.dart';

class CityService {

  Future<List<City>> searchCity(String city) async {

    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$city&format=json&limit=5",
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "CityScout",
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
      .map((json) => City.fromJson(json))
      .toList();

    } else {

      throw Exception("Failed to fetch city");
    }
  }
}