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
}
