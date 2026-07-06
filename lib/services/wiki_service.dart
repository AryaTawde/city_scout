import 'dart:convert';
import 'package:http/http.dart' as http;

class WikiService {
  Future<String?> getDescription(String city) async {
    final url = Uri.parse(
      "https://en.wikipedia.org/api/rest_v1/page/summary/$city",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(response.body);

    return json["extract"];
  }
}