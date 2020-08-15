import 'package:BetterWetter/models/weather.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {}

class SettingsUpdate extends SettingsEvent {
  final ThemeMode themeMode;
  final bool darkThemeModeOled;
  final WeatherService weatherService;

  SettingsUpdate({this.themeMode, this.darkThemeModeOled, this.weatherService});

  @override
  List<Object> get props => [themeMode, darkThemeModeOled, weatherService];
}
