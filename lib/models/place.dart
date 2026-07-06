class Place {
  final String name;

  final double latitude;

  final double longitude;

  Place({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json["tags"]?["name"] ?? "Unknown Place",
      latitude: json["lat"],
      longitude: json["lon"],
    );
  }
}