// ignore_for_file: non_constant_identifier_names

class WeatherModel {
  final double temp;
  final int humidity;
  final String description;
  final String icon;

  WeatherModel({
    required this.temp,
    required this.humidity,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final main = json["main"];
    final weather = json["weather"][0];

    return WeatherModel(
      temp: (main["temp"] ?? 0).toDouble(),
      humidity: (main["humidity"] ?? 0).toInt(),
      description: weather["description"] ?? "",
      icon: weather["icon"] ?? "",
    );
  }
}
