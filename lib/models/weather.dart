class Weather {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final int humidity;

  Weather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(
    temperature: (json["temperature_2m"] as num).toDouble(),
    windSpeed: (json["wind_speed_10m"] as num).toDouble(),
    weatherCode: json["weather_code"],
    humidity: json["relative_humidity_2m"],
  );
}
}