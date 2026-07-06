import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class PlaceService {

  Future<List<Place>> getAttractions(
      double lat,
      double lon,
      ) async {

    final query = """
[out:json];
node
(around:5000,$lat,$lon)
["tourism"="attraction"];
out;
""";

    final response = await http.post(
      Uri.parse("https://overpass-api.de/api/interpreter"),
      body: query,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed");
    }

    final json = jsonDecode(response.body);

    final List data = json["elements"];

    return data
        .map((e) => Place.fromJson(e))
        .toList();
  }
}