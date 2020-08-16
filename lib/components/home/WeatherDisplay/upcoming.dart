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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
            child: Image(
              image: AssetImage('./assets/images/${weather.icon}.png'),
              isAntiAlias: true,
              fit: BoxFit.contain,
              height: 32,
            ),
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
