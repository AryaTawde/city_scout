import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/restaurant.dart';

class RestaurantService {

  Future<List<Restaurant>> getRestaurants(
    double lat,
    double lon,
  ) async {

    final query = """
    [out:json][timeout:25];
    (
      node["amenity"="restaurant"](around:2000,$lat,$lon);
    );
    out body 20;
    """;

    final response = await http
    .post(
      Uri.parse("https://lz4.overpass-api.de/api/interpreter"),
      body: query,
    )
    .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
      "Failed: ${response.statusCode}\n${response.body}",
      );
    }

    final json = jsonDecode(response.body);

    final List data = json["elements"];

    return data
        .map((e) => Restaurant.fromJson(e))
        .toList();
  }
}