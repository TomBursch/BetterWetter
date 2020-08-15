import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreenState extends Equatable {
  final bool locationEnabled;
  final String selectedLocationName;
  final String localLocationName;
  final int currentPageIndex;
  final List<Placemark> savedPlaces;

  HomeScreenState({
    this.locationEnabled = false,
    this.selectedLocationName,
    this.localLocationName,
    this.currentPageIndex = 0,
    this.savedPlaces = const [],
  });

  HomeScreenState copyWith({
    bool locationEnabled,
    String selectedLocationName,
    String localLocationName,
    List<Placemark> savedPlaces,
    int currentPageIndex,
  }) =>
      HomeScreenState(
        locationEnabled: locationEnabled ?? this.locationEnabled,
        selectedLocationName: selectedLocationName ?? this.selectedLocationName,
        savedPlaces: savedPlaces ?? this.savedPlaces,
        localLocationName: localLocationName ?? this.localLocationName,
        currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      );

  @override
  List<Object> get props =>
      [
        locationEnabled,
        selectedLocationName,
      ] +
      savedPlaces;
}
