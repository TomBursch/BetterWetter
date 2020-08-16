import 'dart:convert';

import 'package:BetterWetter/app.dart';
import 'package:BetterWetter/models/models.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AccuWeather extends WeatherService {
  static final AccuWeather instance = AccuWeather._();

  @override
  String getName() => "AccuWeather";

  final Map<int, String> iconMap = {
    1: "clear_d",
    2: "clear_d",
    3: "clear_d",
    4: "clear_d",
    5: "few_clouds_d",
    6: "few_clouds_d",
    7: "cloudy_d",
    8: "darkened_d",
    11: "mist_d",
    12: "shower_d",
    13: "rain_d",
    14: "rain_d",
    15: "thunderstorm_d",
    16: "thunderstorm_d",
    17: "thunderstorm_d",
    18: "shower_d",
    19: "snow_d",
    20: "snow_d",
    21: "snow_d",
    22: "snow_d",
    23: "snow_d",
    24: "snow_d",
    25: "snow_d",
    26: "snow_d",
    29: "snow_d",
    30: "clear_d",
    31: "clear_n",
    32: "wind",
    33: "clear_n",
    34: "clear_n",
    35: "clear_n",
    36: "few_clouds_n",
    37: "few_clouds_n",
    38: "cloudy_n",
    39: "rain_n",
    40: "rain_n",
    41: "thunderstorm_n",
    42: "thunderstorm_n",
    43: "snow_n",
    44: "snow_n",
  };

  final String endpoint = "http://dataservice.accuweather.com/";

  AccuWeather._();

  @override
  WeatherService getInstance() => instance;

  @override
  Future<LocationWeather> getWeather(Position position, [String lang]) async {
    WeatherCurrent current;
    List<WeatherDay> upcoming;
    List<Weather> today;

    http.Response res =
        await http.get(await constructEndPointLocation(position));
    if (res.statusCode == 200) {
      dynamic data = jsonDecode(res.body);
      final String pos = data['Key'];
      final int timezoneOffsetHours = data['TimeZone']['GmtOffset'].round();
      debugPrint(pos);

      if (pos == null || pos.isEmpty) return null;

      res = await http.get(await constructEndPointCurrent(pos, lang));
      if (res.statusCode == 200) {
        data = jsonDecode(res.body);
        current = WeatherCurrent(
          time: DateTime.fromMillisecondsSinceEpoch(data['EpochTime'] * 1000,
              isUtc: true),
          feelsLike: data['RealFeelTemperature']['Metric']['Value'],
          humidity: data['RelativeHumidity'],
          clouds: data['CloudCover'],
          temp: data['Temperature']['Metric']['Value'],
          uvIndex: data['UVIndex'],
          pressure: data['Pressure']['Metric']['Value'],
          windSpeed: data['Wind']['Speed']['Metric']['Value'],
          windDirection: data['Wind']['Direction']['Degrees'],
          visibility: data['Visibility']['Metric']['Value'],
          name: data['WeatherText'],
          desc: data['WeatherText'],
          icon: iconMap[data['WeatherIcon']],
        );

        res = await http.get(await constructEndPointToday(pos, lang));
        if (res.statusCode == 200) {
          data = jsonDecode(res.body);
          today = (data as List<dynamic>)
              .map((data) => Weather(
                    time: DateTime.fromMillisecondsSinceEpoch(
                        data['EpochTime'] * 1000,
                        isUtc: true),
                    feelsLike: data['RealFeelTemperature']['Metric']['Value'],
                    humidity: data['RelativeHumidity'],
                    clouds: data['CloudCover'],
                    temp: data['Temperature']['Value'],
                    uvIndex: data['UVIndex'],
                    pressure: data['Pressure']['Value'],
                    windSpeed: data['Wind']['Speed']['Value'],
                    windDirection: data['Wind']['Direction']['Degrees'],
                    visibility: data['Visibility']['Metric']['Value'],
                    name: data['IconPhrase'],
                    desc: data['IconPhrase'],
                    icon: iconMap[data['WeatherIcon']],
                  ))
              .toList();

          res = await http.get(await constructEndPointUpcoming(pos, lang));
          if (res.statusCode == 200) {
            data = jsonDecode(res.body);
            upcoming = (data["DailyForecasts"] as List<dynamic>)
                .map((data) => WeatherDay(
                      time: DateTime.fromMillisecondsSinceEpoch(
                          data['EpochTime'] * 1000,
                          isUtc: true),
                      feelsLike: data['RealFeelTemperature']['Maximum']
                          ['Value'],
                      feelsLikeMin: data['RealFeelTemperature']['Minimum']
                          ['Value'],
                      clouds: data['Day']['CloudCover'],
                      temp: data['Temperature']['Maximum']['Value'],
                      tempMin: data['Temperature']['Minimum']['Value'],
                      windSpeed: data['Day']['Wind']['Speed']['Value'],
                      windDirection: data['Day']['Wind']['Direction']
                          ['Degrees'],
                      name: data['Day']['ShortPhrase'],
                      desc: data['Day']['LongPhrase'],
                      icon: iconMap[data['Day']['WeatherIcon']],
                    ))
                .toList();

            if (current != null && today != null && upcoming != null)
              return LocationWeather(
                timezoneOffset: Duration(hours: timezoneOffsetHours),
                current: current,
                today: today,
                upcoming: upcoming,
              );
          }
        }
      }
    }
    return null;
  }

  Future<String> constructEndPointLocation(Position pos) async {
    return endpoint +
        "locations/v1/cities/geoposition/search" +
        "?apikey=${(await BetterWetterApp.enviroment).accuWeatherApiKey}" +
        "&q=${pos.latitude},${pos.longitude}";
  }

  Future<String> constructEndPointCurrent(String pos, [String lang]) async {
    return endpoint +
        "currentconditions/v1/$pos" +
        "?apikey=${(await BetterWetterApp.enviroment).accuWeatherApiKey}" +
        "&details=true" +
        (lang != null ? "&language=$lang" : "");
  }

  Future<String> constructEndPointToday(String pos, [String lang]) async {
    return endpoint +
        "forecasts/v1/hourly/12hour/$pos" +
        "?apikey=${(await BetterWetterApp.enviroment).accuWeatherApiKey}" +
        "&metric=true" +
        "&details=true" +
        (lang != null ? "&language=$lang" : "");
  }

  Future<String> constructEndPointUpcoming(String pos, [String lang]) async {
    return endpoint +
        "forecasts/v1/daily/5day/$pos" +
        "?apikey=${(await BetterWetterApp.enviroment).accuWeatherApiKey}" +
        "&metric=true" +
        "&details=true" +
        (lang != null ? "&language=$lang" : "");
  }
}
