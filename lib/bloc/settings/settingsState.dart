import 'package:BetterWetter/services/weatherService.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final bool darkThemeModeOled;
  final bool showPerformanceOverlay;
  final WeatherService weatherService;

  SettingsState({
    this.themeMode = ThemeMode.light,
    this.darkThemeModeOled = false,
    this.showPerformanceOverlay = false,
    this.weatherService,
  });

  SettingsState copyWith({
    ThemeMode themeMode,
    bool showPerformanceOverlay,
    bool showIntroduction,
    bool darkThemeOled,
    WeatherService weatherService,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        darkThemeModeOled: darkThemeOled ?? this.darkThemeModeOled,
        showPerformanceOverlay:
            showPerformanceOverlay ?? this.showPerformanceOverlay,
        weatherService: weatherService ?? this.weatherService,
      );

  @override
  List<Object> get props =>
      [themeMode, darkThemeModeOled, showPerformanceOverlay, weatherService];
}
