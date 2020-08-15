import 'package:BetterWetter/models/locationWeather.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherDisplayState extends Equatable {
  final LocationWeather locationWeather;

  WeatherDisplayState([this.locationWeather]);

  @override
  List<Object> get props => [locationWeather];
}

class WeatherDisplayInitial extends WeatherDisplayState {}

class WeatherDisplayLoading extends WeatherDisplayState {
  WeatherDisplayLoading(LocationWeather locationWeather)
      : super(locationWeather);
}

class WeatherDisplayError extends WeatherDisplayState {
  final String msg;

  WeatherDisplayError(this.msg, [LocationWeather locationWeather])
      : super(locationWeather);
}

class WeatherDisplayLoaded extends WeatherDisplayState {
  final Placemark placemark;
  WeatherDisplayLoaded(LocationWeather locationWeather, [this.placemark])
      : super(locationWeather);
}
