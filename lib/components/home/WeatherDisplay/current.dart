import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/models/weatherCurrent.dart';
import 'package:BetterWetter/themes/styles.dart';
import 'package:flutter/material.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherCurrent current;

  const CurrentWeatherWidget({Key key, @required this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BWDecoration.defaultBoxDecoration(context),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        primary: false,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        shrinkWrap: true,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 5),
        children: [
          if (current.feelsLike != null)
            gridItem(
              context,
              BWLocalizations.of(context).feelsLike,
              (current.feelsLike - 273.15).toStringAsFixed(0) + "°C",
              Icon(Icons.face),
            ),
          if (current.humidity != null)
            gridItem(
              context,
              BWLocalizations.of(context).humidity,
              current.humidity.toString() + "%",
              Icon(Icons.filter_drama),
            ),
          if (current.uvIndex != null)
            gridItem(
              context,
              BWLocalizations.of(context).uvIndex,
              current.uvIndex.toStringAsFixed(0),
              Icon(Icons.brightness_low),
            ),
          if (current.windSpeed != null)
            gridItem(
              context,
              BWLocalizations.of(context).windspeed,
              current.windSpeed.toStringAsPrecision(1) + "m/s",
              Icon(Icons.flag),
            ),
          if (current.feelsLike != null)
            gridItem(
              context,
              BWLocalizations.of(context).pressure,
              current.pressure.toString() + "hPa",
              Icon(Icons.unfold_less),
            ),
          if (current.visibility != null)
            gridItem(
              context,
              BWLocalizations.of(context).visibility,
              current.visibility.toString() + "m",
              Icon(Icons.crop_original),
            ),
        ],
      ),
    );
  }

  Widget gridItem(
      BuildContext context, String title, String text, Widget icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              Text(text),
            ],
          ),
        ),
        icon
      ],
    );
  }
}
