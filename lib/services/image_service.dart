import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  Future<String?> getCityImage(String cityName) async {
    final url = Uri.parse(
      "https://en.wikipedia.org/w/api.php?"
      "action=query"
      "&generator=search"
      "&gsrsearch=$cityName skyline"
      "&gsrlimit=1"
      "&prop=pageimages"
      "&piprop=original"
      "&format=json"
      "&origin=*",
    );

    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if (data["query"] == null) return null;

    final pages = data["query"]["pages"] as Map<String, dynamic>;

    final page = pages.values.first;

    return page["original"]?["source"];
  }
}