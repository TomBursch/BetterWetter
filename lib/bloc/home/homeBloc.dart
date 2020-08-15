import 'dart:convert';

import 'package:BetterWetter/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final Position location;
  HomeScreenBloc({this.location}) : super(HomeScreenState()) {
    checkLocationSettings();
    loadPlaces();
  }

  void checkLocationSettings() async {
    GeolocationStatus geolocationStatus =
        await BetterWetterApp.geolocator.checkGeolocationPermissionStatus();
    this.add(HomeScreenLocationPermissionChange(
        geolocationStatus != GeolocationStatus.disabled));
  }

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is HomeScreenLocationPermissionChange) {
      yield state.copyWith(locationEnabled: event.newLocationEnabled);
    }
    if (event is HomeScreenLocationChange) {
      if (event.pageIndex == 0 && state.locationEnabled) {
        yield state.copyWith(
          selectedLocationName: state.localLocationName,
          currentPageIndex: event.pageIndex,
        );
      } else {
        final index =
            state.locationEnabled ? event.pageIndex - 1 : event.pageIndex;
        yield state.copyWith(
          selectedLocationName: state.savedPlaces[index].locality,
          currentPageIndex: event.pageIndex,
        );
      }
    }
    if (event is HomeScreenLocalLocationChange) {
      if (state.currentPageIndex == 0 && state.locationEnabled) {
        yield state.copyWith(
          localLocationName: event.newName,
          selectedLocationName: event.newName,
        );
      } else
        yield state.copyWith(localLocationName: event.newName);
    }
    if (event is HomeScreenPlacemarkLoaded) {
      yield state.copyWith(savedPlaces: event.placemark);
    }
    if (event is HomeScreenPlacemarkAdd) {
      yield state.copyWith(
          savedPlaces: List<Placemark>.from(state.savedPlaces)
            ..add(event.placemark));
      savePlaces();
    }
    if (event is HomeScreenPlacemarkRemove) {
      yield state.copyWith(
          savedPlaces: List<Placemark>.from(state.savedPlaces)
            ..remove(event.placemark));
      savePlaces();
    }
    if (event is HomeScreenPlacemarkReorder) {
      final l = List<Placemark>.from(state.savedPlaces);
      final temp = l.removeAt(event.oldIndex);
      l.insert(event.newIndex, temp);
      yield state.copyWith(
        savedPlaces: l,
      );
      savePlaces();
    }
  }

  Future<void> savePlaces() async {
    final placemark = state.savedPlaces;
    return BetterWetterApp.prefrenceStorage
        .write(key: "places", value: jsonEncode(placemark));
  }

  Future<void> loadPlaces() async {
    final source = await BetterWetterApp.prefrenceStorage.read(key: "places");
    if (source?.isEmpty ?? true) return;
    final data = jsonDecode(source) as List<dynamic>;
    this.add(HomeScreenPlacemarkLoaded(Placemark.fromMaps(data)));
  }
}
