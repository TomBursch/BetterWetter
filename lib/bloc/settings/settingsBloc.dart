import 'dart:async';
import 'package:BetterWetter/services/openWeatherMap.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:flutter/material.dart';
import 'package:BetterWetter/utilities/storage.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final PreferenceStorage storage;

  SettingsBloc({
    @required this.storage,
  })  : assert(storage != null),
        super(SettingsState(weatherService: OpenWeatherMap.instance)) {
    storage.readBool(key: "darkThemeMode").then((i) {
      add(SettingsUpdate(darkThemeModeOled: i ?? false));
    });
    storage.readInt(key: "themeMode").then((i) {
      add(SettingsUpdate(themeMode: ThemeMode.values[i ?? 0]));
    });
    storage.readInt(key: "weatherService").then((i) {
      add(SettingsUpdate(
          weatherService: WeatherService
              .services[(i ?? 0) % WeatherService.services.length]));
    });
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsUpdate) {
      if (event.themeMode != null) {
        storage.writeInt(key: "themeMode", value: event.themeMode.index);
      }

      if (event.darkThemeModeOled != null) {
        storage.writeBool(key: "darkThemeMode", value: event.darkThemeModeOled);
      }

      if (event.weatherService != null &&
          WeatherService.services.contains(event.weatherService)) {
        storage.writeInt(
          key: "weatherService",
          value: WeatherService.services.indexOf(event.weatherService),
        );
      }

      yield state.copyWith(
        themeMode: event.themeMode,
        darkThemeOled: event.darkThemeModeOled,
        weatherService: event.weatherService,
      );
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
