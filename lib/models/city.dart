class City {
  final String name;
  final String displayName;
  final double latitude;
  final double longitude;

  final double rating;
  final int attractions;
  final String image;
  final String food;
  final String culture;

  String? imageUrl;

  City({
    required this.name,
    this.displayName = "",
    this.latitude = 0,
    this.longitude = 0,

    this.rating = 0,
    this.attractions = 0,
    this.image = "",
    this.food = "",
    this.culture = "",

    this.imageUrl,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json["name"] ?? "",
      displayName: json["display_name"] ?? "",
      latitude: double.parse(json["lat"]),
      longitude: double.parse(json["lon"]),
    );
  }
}