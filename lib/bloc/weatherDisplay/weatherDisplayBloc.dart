import 'package:BetterWetter/app.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'bloc.dart';

class WeatherDisplayBloc
    extends Bloc<WeatherDisplayEvent, WeatherDisplayState> {
  final Placemark location;

  WeatherDisplayBloc({this.location}) : super(WeatherDisplayInitial());

  @override
  Stream<WeatherDisplayState> mapEventToState(
      WeatherDisplayEvent event) async* {
    if (event is WeatherDisplayRefreshEvent) {
      yield WeatherDisplayLoading(state.locationWeather);
      try {
        final pos = location?.position ??
            await BetterWetterApp.geolocator
                .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        if (pos != null) {
          final res = await event.weatherService.getWeather(pos, event.lang);
          if (res != null) {
            final placemark = location ??
                (await BetterWetterApp.geolocator
                    .placemarkFromPosition(pos))[0];
            yield WeatherDisplayLoaded(res, placemark);
          } else
            yield WeatherDisplayError("Error");
        } else
          yield WeatherDisplayError("Error");
      } catch (e) {
        yield WeatherDisplayError(e.toString());
      }
    }
  }
}
