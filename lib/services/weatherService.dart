import 'package:BetterWetter/models/locationWeather.dart';
import 'package:BetterWetter/services/openWeatherMap.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherService {
  static final List<WeatherService> services = [
    OpenWeatherMap.instance,
  ];

  String getName();

  WeatherService getInstance();

  Future<LocationWeather> getWeather(Position position, [String lang]);
}
