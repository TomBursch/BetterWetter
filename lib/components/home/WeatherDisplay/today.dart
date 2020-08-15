import 'dart:math';

import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/models/weather.dart';
import 'package:BetterWetter/models/weatherCurrent.dart';
import 'package:BetterWetter/utilities/noGlowScrollBehavior.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayWeatherWidget extends StatelessWidget {
  final WeatherCurrent current;
  final List<Weather> today;

  const TodayWeatherWidget({Key key, @required this.today, this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView(
          controller: ScrollController(),
          primary: false,
          shrinkWrap: true,
          itemExtent: 75,
          scrollDirection: Axis.horizontal,
          children: _buildList(context),
        ),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    List<Widget> res = [
      for (final w in today.sublist(0, min(25, today.length)))
        _hourWidget(
          context,
          temp: (w.temp - 273.15).toStringAsFixed(0) + "°C",
          imageProvider: AssetImage('./assets/images/${w.icon}.png'),
          time: (today[0] != w)
              ? DateFormat.Hm().format(w.time.toLocal())
              : BWLocalizations.of(context).now,
        ),
    ];
    final int sunriseIndex =
        today.indexWhere((e) => e.time.isAfter(current.sunrise));
    if (sunriseIndex != -1)
      res.insert(
          sunriseIndex,
          _hourWidget(
            context,
            temp: "Sunrise",
            time: DateFormat.Hm().format(current.sunrise.toLocal()),
            imageProvider: AssetImage("./assets/images/sunrise.png"),
          ));

    final int sunsetIndex =
        today.lastIndexWhere((e) => e.time.isBefore(current.sunset));
    if (sunsetIndex != -1)
      res.insert(
          min(sunsetIndex + 2, today.length),
          _hourWidget(
            context,
            temp: "Sunset",
            time: DateFormat.Hm().format(current.sunset.toLocal()),
            imageProvider: AssetImage("./assets/images/sunset.png"),
          ));

    return res;
  }

  Widget _hourWidget(
    BuildContext context, {
    ImageProvider imageProvider,
    String time,
    String temp,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time),
          Image(
            image: imageProvider,
            alignment: Alignment.center,
            isAntiAlias: true,
            height: 50,
            width: 50,
          ),
          Text(temp),
        ],
      );
}
