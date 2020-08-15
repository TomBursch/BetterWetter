import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Enviroment {
  final String openWeatherApiKey;

  Enviroment({this.openWeatherApiKey = ""});

  factory Enviroment.fromJson(Map<String, dynamic> jsonMap) {
    return new Enviroment(openWeatherApiKey: jsonMap["open_weather_api_key"]);
  }
}

class EnviromentLoader {
  static final String path = "./env.json";

  EnviromentLoader();
  static Future<Enviroment> load() {
    return rootBundle.loadStructuredData<Enviroment>(path, (jsonStr) async {
      final secret = Enviroment.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
