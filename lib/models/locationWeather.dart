import './models.dart';

class LocationWeather {
  final Duration timezoneOffset;
  final WeatherCurrent current;
  final List<Weather> today;
  final List<WeatherDay> upcoming;

  LocationWeather({
    this.timezoneOffset = const Duration(),
    this.current,
    this.today,
    this.upcoming,
  });
}
