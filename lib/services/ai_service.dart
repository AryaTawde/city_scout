import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_keys.dart';

class AIService {
  final model = GenerativeModel(
    model: "gemini-2.5-flash",
    apiKey: ApiKeys.geminiApiKey,
  );

  Future<String> generateTripPlan({
    required String city,
    required String weather,
    required List<String> attractions,
    required List<String> restaurants,
  }) async {
    final prompt = """
You are an expert travel guide.

Create a beautiful one-day travel itinerary for $city.

Current Weather:
$weather

Nearby Attractions:
${attractions.join(", ")}

Nearby Restaurants:
${restaurants.join(", ")}

Requirements:
- Morning, Afternoon and Evening sections
- Recommend food where appropriate
- Keep it under 250 words
- Use bullet points
- Friendly tone
""";

    final response = await model.generateContent([
      Content.text(prompt),
    ]);

    return response.text ?? "No itinerary generated.";
  }
}