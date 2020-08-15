class Weather {
  final DateTime time;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final int clouds;
  final double uvIndex;
  final int pressure;
  final int visibility;

  final String name;
  final String desc;
  final String icon;

  Weather({
    this.time,
    this.temp,
    this.feelsLike,
    this.humidity,
    this.windDirection,
    this.windSpeed,
    this.clouds,
    this.uvIndex,
    this.pressure,
    this.visibility,
    this.name,
    this.desc,
    this.icon,
  });

  factory Weather.fromJson(
      Map<String, dynamic> data, Map<String, String> iconMap) {
    return Weather(
      time: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000, isUtc: true),
      feelsLike: data['feels_like'].toDouble(),
      humidity: data['humidity'],
      clouds: data['clouds'],
      temp: data['temp'].toDouble(),
      uvIndex: data['uvi'],
      pressure: data['pressure'],
      windSpeed: data['wind_speed'].toDouble(),
      windDirection: data['wind_deg'],
      visibility: data['visibility'],
      name: data['weather'][0]['main'],
      desc: data['weather'][0]['description'],
      icon: iconMap[data['weather'][0]['icon']],
    );
  }
}
