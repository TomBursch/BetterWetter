import 'package:BetterWetter/models/weatherCurrent.dart';
import 'package:flutter/material.dart';

class SummaryWeatherWidget extends StatelessWidget {
  final WeatherCurrent current;

  const SummaryWeatherWidget({Key key, @required this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          (current.temp - 273.15).toStringAsFixed(0) + "°C",
          style: Theme.of(context).textTheme.headline1,
          textScaleFactor: 2,
        ),
        Text(current.desc ?? current.desc),
      ],
    );
  }
}
