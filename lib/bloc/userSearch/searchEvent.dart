import 'package:geolocator/geolocator.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchSelect extends SearchEvent {
  final Placemark placemark;

  SearchSelect(this.placemark);

  @override
  List<Object> get props => [placemark];
}

class SearchTerm extends SearchEvent {
  final String searchTerm;

  SearchTerm(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
