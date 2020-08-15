import './models.dart';

class LocationWeather {
  final WeatherCurrent current;
  final List<Weather> today;
  final List<WeatherDay> upcoming;

  LocationWeather({this.current, this.today, this.upcoming});
}
