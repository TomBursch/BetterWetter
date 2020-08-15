import 'package:BetterWetter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'current.dart';

class UpcomingWeatherWidget extends StatelessWidget {
  final List<WeatherDay> upcoming;

  const UpcomingWeatherWidget({Key key, @required this.upcoming})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [for (final w in upcoming) _buildDay(context, w)],
    );
  }

  Widget _buildDay(BuildContext context, WeatherDay weather) {
    return ExpansionTile(
      title: Row(
        children: [
          Image(
            image: AssetImage('./assets/images/${weather.icon}.png'),
            alignment: Alignment.center,
            isAntiAlias: true,
            height: 50,
            width: 50,
          ),
          Expanded(
            child: Text(
              DateFormat.EEEE().format(weather.time),
            ),
          ),
          Text((weather.temp - 273.15).toStringAsFixed(0) +
              "°/" +
              (weather.tempNight - 273.15).toStringAsFixed(0) +
              "°"),
        ],
      ),
      children: [
        CurrentWeatherWidget(current: weather),
      ],
    );
  }
}
