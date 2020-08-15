import 'package:geolocator/geolocator.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  final String searchTerm;

  SearchState({this.searchTerm = ""});

  @override
  List<Object> get props => <Object>[searchTerm];
}

class SearchStateLoading extends SearchState {
  SearchStateLoading({String searchTerm}) : super(searchTerm: searchTerm);
}

class SearchStateOverview extends SearchState {
  SearchStateOverview({String searchTerm}) : super(searchTerm: searchTerm);
}

class SearchStateResult extends SearchState {
  final List<Placemark> placemark;

  SearchStateResult({String searchTerm = "", this.placemark = const []})
      : super(searchTerm: searchTerm);

  @override
  List<Object> get props => <Object>[searchTerm] + placemark;

  SearchStateResult copyWith({String searchTerm, List<Placemark> placemark}) =>
      SearchStateResult(
        searchTerm: searchTerm ?? this.searchTerm,
        placemark: placemark ?? this.placemark,
      );
}

class SearchStateSelected extends SearchState {
  final Placemark selected;

  SearchStateSelected({this.selected});

  @override
  List<Object> get props => [selected];
}
