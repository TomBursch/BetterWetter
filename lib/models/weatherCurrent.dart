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

  factory WeatherCurrent.fromJson(
      Map<String, dynamic> data, Map<String, String> iconMap) {
    return WeatherCurrent(
      time: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000, isUtc: true),
      feelsLike: data['feels_like'].toDouble(),
      humidity: data['humidity'],
      clouds: data['clouds'],
      temp: data['temp'].toDouble(),
      uvIndex: data['uvi'],
      pressure: data['pressure'],
      sunrise: data.containsKey('sunrise')
          ? DateTime.fromMillisecondsSinceEpoch(data['sunrise'] * 1000,
              isUtc: true)
          : null,
      sunset: data.containsKey('sunset')
          ? DateTime.fromMillisecondsSinceEpoch(data['sunset'] * 1000,
              isUtc: true)
          : null,
      windSpeed: data['wind_speed'].toDouble(),
      windDirection: data['wind_deg'],
      visibility: data['visibility'],
      name: data['weather'][0]['main'],
      desc: data['weather'][0]['description'],
      icon: iconMap[data['weather'][0]['icon']],
    );
  }
}
