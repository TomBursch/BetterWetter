import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class HomeScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeScreenLocationPermissionChange extends HomeScreenEvent {
  final bool newLocationEnabled;

  HomeScreenLocationPermissionChange(this.newLocationEnabled);

  @override
  List<Object> get props => [newLocationEnabled];
}

class HomeScreenLocationChange extends HomeScreenEvent {
  final int pageIndex;

  HomeScreenLocationChange(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class HomeScreenLocalLocationChange extends HomeScreenEvent {
  final String newName;

  HomeScreenLocalLocationChange(this.newName);

  @override
  List<Object> get props => [newName];
}

class HomeScreenPlacemarkLoaded extends HomeScreenEvent {
  final List<Placemark> placemark;

  HomeScreenPlacemarkLoaded(this.placemark);

  @override
  List<Object> get props => placemark;
}

class HomeScreenPlacemarkAdd extends HomeScreenEvent {
  final Placemark placemark;

  HomeScreenPlacemarkAdd(this.placemark);

  @override
  List<Object> get props => [placemark];
}

class HomeScreenPlacemarkRemove extends HomeScreenEvent {
  final Placemark placemark;

  HomeScreenPlacemarkRemove(this.placemark);

  @override
  List<Object> get props => [placemark];
}

class HomeScreenPlacemarkReorder extends HomeScreenEvent {
  final int oldIndex;
  final int newIndex;

  HomeScreenPlacemarkReorder({this.oldIndex, this.newIndex});

  @override
  List<Object> get props => [oldIndex, newIndex];
}
