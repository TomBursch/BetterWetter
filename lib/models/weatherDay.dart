import 'package:BetterWetter/models/models.dart';

class WeatherDay extends WeatherCurrent {
  final double tempMin;
  final double tempMax;
  final double tempNight;
  final double tempMorn;
  final double tempEve;
  final double feelsLikeMin;
  final double feelsLikeMax;
  final double feelsLikeNight;
  final double feelsLikeMorn;
  final double feelsLikeEve;

  WeatherDay({
    DateTime time,
    double temp,
    this.tempMin,
    this.tempMax,
    this.tempNight,
    this.tempMorn,
    this.tempEve,
    this.feelsLikeMin,
    this.feelsLikeMax,
    this.feelsLikeNight,
    this.feelsLikeMorn,
    this.feelsLikeEve,
    double feelsLike,
    int humidity,
    int windDirection,
    double windSpeed,
    int clouds,
    double uvIndex,
    String name,
    String desc,
    String icon,
    DateTime sunrise,
    DateTime sunset,
    int pressure,
    int visibility,
  }) : super(
          time: time,
          temp: temp,
          feelsLike: feelsLike,
          humidity: humidity,
          windDirection: windDirection,
          windSpeed: windSpeed,
          clouds: clouds,
          uvIndex: uvIndex,
          name: name,
          desc: desc,
          icon: icon,
          sunrise: sunrise,
          sunset: sunset,
          pressure: pressure,
          visibility: visibility,
        );

  factory WeatherDay.fromJson(
      Map<String, dynamic> data, Map<String, String> iconMap) {
    return WeatherDay(
      time: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000, isUtc: true),
      feelsLike: data['feels_like']['day'].toDouble(),
      feelsLikeNight: data['feels_like']['night'].toDouble(),
      humidity: data['humidity'],
      temp: data['temp']['day'].toDouble(),
      tempNight: data['temp']['night'].toDouble(),
      windDirection: data['wind_deg'],
      windSpeed: data['wind_speed'].toDouble(),
      uvIndex: data['uvi'].toDouble(),
      clouds: data['clouds'],
      pressure: data['pressure'],
      sunrise: data.containsKey('sunrise')
          ? DateTime.fromMillisecondsSinceEpoch(data['sunrise'] * 1000,
              isUtc: true)
          : null,
      sunset: data.containsKey('sunset')
          ? DateTime.fromMillisecondsSinceEpoch(data['sunset'] * 1000,
              isUtc: true)
          : null,
      visibility: data['visibility'],
      name: data['weather'][0]['main'],
      desc: data['weather'][0]['description'],
      icon: iconMap[data['weather'][0]['icon']],
    );
  }
}
