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
}
