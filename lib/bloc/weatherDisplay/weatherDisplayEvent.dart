import 'package:BetterWetter/services/weatherService.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherDisplayEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherDisplayRefreshEvent extends WeatherDisplayEvent {
  final String lang;
  final WeatherService weatherService;

  WeatherDisplayRefreshEvent(this.weatherService, [this.lang]);
  @override
  List<Object> get props => [weatherService, lang];
}
