import 'dart:math';

import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/models/models.dart';
import 'package:BetterWetter/utilities/noGlowScrollBehavior.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayWeatherWidget extends StatelessWidget {
  final LocationWeather locationWeather;

  const TodayWeatherWidget({Key key, @required this.locationWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView(
          controller: ScrollController(),
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: _buildList(context),
        ),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    final today =
        locationWeather.today.sublist(1, min(25, locationWeather.today.length));
    List<Widget> res = [
      for (final w in today)
        _hourWidget(
          context,
          temp: (w.temp - 273.15).toStringAsFixed(0) + "°C",
          imageProvider: AssetImage('./assets/images/${w.icon}.png'),
          time: (today[0] != w)
              ? DateFormat.Hm()
                  .format(w.time.add(locationWeather.timezoneOffset))
              : BWLocalizations.of(context).now,
        ),
    ];
    int offset = 0;
    if (locationWeather.current != null)
      offset = _insertSun(context, res, today, locationWeather.current);
    if (locationWeather.upcoming[1] != null)
      _insertSun(context, res, today, locationWeather.upcoming[1], offset);

    return res;
  }

  int _insertSun(
    BuildContext context,
    List<Widget> list,
    List<Weather> today,
    WeatherCurrent weather, [
    int offset = 0,
  ]) {
    final int sunriseIndex =
        today.indexWhere((e) => e.time.isAfter(weather.sunrise));
    if (sunriseIndex > 0 && sunriseIndex < today.length) {
      list.insert(
          sunriseIndex + offset,
          _hourWidget(
            context,
            temp: BWLocalizations.of(context).sunrise,
            time: DateFormat.Hm()
                .format(weather.sunrise.add(locationWeather.timezoneOffset)),
            imageProvider: AssetImage("./assets/images/sunrise.png"),
          ));
      offset++;
    }
    final int sunsetIndex =
        today.lastIndexWhere((e) => e.time.isBefore(weather.sunset)) + 1;
    if (sunsetIndex > -1 && sunsetIndex < today.length) {
      list.insert(
          sunsetIndex + offset,
          _hourWidget(
            context,
            temp: BWLocalizations.of(context).sunset,
            time: DateFormat.Hm()
                .format(weather.sunset.add(locationWeather.timezoneOffset)),
            imageProvider: AssetImage("./assets/images/sunset.png"),
          ));
      offset++;
    }

    return offset;
  }

  Widget _hourWidget(
    BuildContext context, {
    ImageProvider imageProvider,
    String time,
    String temp,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              textScaleFactor: .9,
              style: TextStyle(
                color:
                    Theme.of(context).textTheme.bodyText2.color.withOpacity(.6),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Image(
                  image: imageProvider,
                  isAntiAlias: true,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              temp,
              textScaleFactor: .9,
              style: TextStyle(
                color:
                    Theme.of(context).textTheme.bodyText2.color.withOpacity(.6),
              ),
            ),
          ],
        ),
      );
}
