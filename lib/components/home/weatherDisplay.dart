import 'dart:async';

import 'package:BetterWetter/bloc/home/bloc.dart';
import 'package:BetterWetter/bloc/settings/bloc.dart';
import 'package:BetterWetter/bloc/weatherDisplay/bloc.dart';
import 'package:BetterWetter/components/home/WeatherDisplay/today.dart';
import 'package:BetterWetter/components/home/WeatherDisplay/upcoming.dart';
import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'WeatherDisplay/current.dart';
import 'WeatherDisplay/summary.dart';

class WeatherDisplay extends StatefulWidget {
  final Placemark location;

  const WeatherDisplay({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  _WeatherDisplayState createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  WeatherDisplayBloc _bloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _bloc = WeatherDisplayBloc(
      location: widget.location,
    );
    _bloc.add(WeatherDisplayRefreshEvent(
        BlocProvider.of<SettingsBloc>(context).state.weatherService));
  }

  @override
  Widget build(BuildContext context) {
    return extended.NestedScrollViewRefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocConsumer<WeatherDisplayBloc, WeatherDisplayState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is WeatherDisplayLoaded) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
            if (widget.location == null)
              BlocProvider.of<HomeScreenBloc>(context).add(
                  HomeScreenLocalLocationChange(state.placemark?.locality ??
                      BWLocalizations.of(context).location));
          }
        },
        builder: (context, state) {
          if (state is WeatherDisplayLoaded || state.locationWeather != null)
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverOverlapInjector(
                  handle:
                      extended.NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 15),
                    SummaryWeatherWidget(
                        current: state.locationWeather.current),
                    const SizedBox(height: 35),
                    TodayWeatherWidget(
                      today: state.locationWeather.today,
                      current: state.locationWeather.current,
                    ),
                    const SizedBox(height: 15),
                    CurrentWeatherWidget(
                        current: state.locationWeather.current),
                    const SizedBox(height: 15),
                    UpcomingWeatherWidget(
                        upcoming: state.locationWeather.upcoming),
                  ]),
                ),
              ],
            );
          if (state is WeatherDisplayError)
            return extended.NestedScrollViewRefreshIndicator(
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: extended.NestedScrollView
                        .sliverOverlapAbsorberHandleFor(context),
                  ),
                  SliverToBoxAdapter(
                    child: Text(state.msg),
                  )
                ],
              ),
            );
          return Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() {
    if (!(_bloc.state is WeatherDisplayLoading)) {
      _bloc.add(WeatherDisplayRefreshEvent(
        BlocProvider.of<SettingsBloc>(context).state.weatherService,
        Localizations.localeOf(context).countryCode,
      ));
    }
    return _refreshCompleter.future;
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
