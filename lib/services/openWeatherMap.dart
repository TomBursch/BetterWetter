import 'dart:convert';

import 'package:BetterWetter/app.dart';
import 'package:BetterWetter/models/models.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class OpenWeatherMap extends WeatherService {
  static final OpenWeatherMap instance = OpenWeatherMap._();

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

  OpenWeatherMap._();

  @override
  WeatherService getInstance() => instance;

  @override
  Future<LocationWeather> getWeather(Position position, [String lang]) async {
    final res = await http.get(await constructEndPoint(position, lang));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return LocationWeather(
        timezoneOffset: Duration(seconds: data['timezone_offset']),
        current: WeatherCurrent(
          time: DateTime.fromMillisecondsSinceEpoch(
              data['current']['dt'] * 1000,
              isUtc: true),
          feelsLike: data['current']['feels_like'].toDouble(),
          humidity: data['current']['humidity'],
          clouds: data['current']['clouds'],
          temp: data['current']['temp'].toDouble(),
          uvIndex: data['current']['uvi'],
          pressure: data['current']['pressure'],
          sunrise: data['current'].containsKey('sunrise')
              ? DateTime.fromMillisecondsSinceEpoch(
                  data['current']['sunrise'] * 1000,
                  isUtc: true)
              : null,
          sunset: data['current'].containsKey('sunset')
              ? DateTime.fromMillisecondsSinceEpoch(
                  data['current']['sunset'] * 1000,
                  isUtc: true)
              : null,
          windSpeed: data['current']['wind_speed'].toDouble(),
          windDirection: data['current']['wind_deg'],
          visibility: data['current']['visibility'],
          name: data['current']['weather'][0]['main'],
          desc: data['current']['weather'][0]['description'],
          icon: iconMap[data['current']['weather'][0]['icon']],
        ),
        today: (data["hourly"] as List<dynamic>)
            .map((data) => Weather(
                  time: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000,
                      isUtc: true),
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
                ))
            .toList(),
        upcoming: (data["daily"] as List<dynamic>)
            .map((data) => WeatherDay(
                  time: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000,
                      isUtc: true),
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
                      ? DateTime.fromMillisecondsSinceEpoch(
                          data['sunrise'] * 1000,
                          isUtc: true)
                      : null,
                  sunset: data.containsKey('sunset')
                      ? DateTime.fromMillisecondsSinceEpoch(
                          data['sunset'] * 1000,
                          isUtc: true)
                      : null,
                  visibility: data['visibility'],
                  name: data['weather'][0]['main'],
                  desc: data['weather'][0]['description'],
                  icon: iconMap[data['weather'][0]['icon']],
                ))
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
        (lang != null ? "&lang=$lang" : "");
  }
}
