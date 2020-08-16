import 'weather.dart';

class WeatherCurrent extends Weather {
  final DateTime sunrise;
  final DateTime sunset;

  WeatherCurrent({
    DateTime time,
    this.sunrise,
    this.sunset,
    double temp,
    double feelsLike,
    int humidity,
    int windDirection,
    double windSpeed,
    int clouds,
    double uvIndex,
    int pressure,
    int visibility,
    String name,
    String desc,
    String icon,
  }) : super(
          time: time,
          temp: temp,
          feelsLike: feelsLike,
          humidity: humidity,
          windDirection: windDirection,
          windSpeed: windSpeed,
          clouds: clouds,
          uvIndex: uvIndex,
          pressure: pressure,
          visibility: visibility,
          name: name,
          desc: desc,
          icon: icon,
        );
}
