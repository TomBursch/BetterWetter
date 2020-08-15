import 'dart:convert';

import 'package:BetterWetter/app.dart';
import 'package:BetterWetter/models/models.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class OpenWeatherMap extends WeatherService {
  static final OpenWeatherMap instance = OpenWeatherMap();

  @override
  String getName() => "Open Weather Map";

  final Map<String, String> iconMap = {
    "01d": "clear_d",
    "01n": "clear_n",
    "02d": "few_clouds_d",
    "02n": "few_clouds_n",
    "03d": "cloudy_d",
    "03n": "cloudy_n",
    "04d": "darkened_d",
    "04n": "darkened_n",
    "09d": "shower_d",
    "09n": "shower_n",
    "10d": "rain_d",
    "10n": "rain_n",
    "11d": "thunderstorm_d",
    "11n": "thunderstorm_n",
    "13d": "snow_d",
    "13n": "snow_n",
    "50d": "mist_d",
    "50n": "mist_n",
  };

  final String endpoint =
      "https://api.openweathermap.org/data/2.5/onecall?&exclude=minutely";

  OpenWeatherMap();

  @override
  WeatherService getInstance() => instance;

  @override
  Future<LocationWeather> getWeather(Position position, [String lang]) async {
    final res = await http.get(await constructEndPoint(position, lang));
    if (res.statusCode == 200) {
      final data = jsonDecode(
        res.body,
      );
      return LocationWeather(
        current: WeatherCurrent.fromJson(data["current"], iconMap),
        today: (data["hourly"] as List<dynamic>)
            .map((e) => Weather.fromJson(e, iconMap))
            .toList(),
        upcoming: (data["daily"] as List<dynamic>)
            .map((e) => WeatherDay.fromJson(e, iconMap))
            .toList(),
      );
    }
    return null;
  }

  Future<String> constructEndPoint(Position pos, [String lang]) async {
    return endpoint +
        "&appid=" +
        (await BetterWetterApp.enviroment).openWeatherApiKey +
        "&lat=${pos.latitude.toString()}&lon=${pos.longitude.toString()}" +
        (lang != null ? "&=$lang" : "");
  }
}
