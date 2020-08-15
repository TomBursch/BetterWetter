import 'dart:async';
import 'package:BetterWetter/app.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchStateResult());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTerm) {
      yield SearchStateLoading(searchTerm: event.searchTerm);
      if (event.searchTerm.isNotEmpty) {
        List<Placemark> query = const [];
        try {
          query = await BetterWetterApp.geolocator
              .placemarkFromAddress(state.searchTerm);
        } catch (e) {}
        yield SearchStateResult(searchTerm: state.searchTerm, placemark: query);
      } else {
        yield SearchStateResult();
      }
    }
    if (event is SearchSelect) {
      yield SearchStateSelected(selected: event.placemark);
    }
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
