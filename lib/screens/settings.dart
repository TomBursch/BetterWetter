import 'package:BetterWetter/bloc/settings/bloc.dart';
import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/services/weatherService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              title: Text(BWLocalizations.of(context).settings),
              iconTheme: Theme.of(context).iconTheme,
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  FlatButton(
                    child: Text(BWLocalizations.of(context).privacy),
                    onPressed: null,
                  ),
                  Divider(
                    color: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                    child: Text(BWLocalizations.of(context).info),
                    onPressed: () => showLicensePage(
                      context: context,
                      applicationName: BWLocalizations.of(context).title,
                      applicationLegalese: "Copyright Tom Bursch",
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).accentColor,
                  ),
                  BlocBuilder<SettingsBloc, SettingsState>(
                    bloc: BlocProvider.of<SettingsBloc>(context),
                    builder: (context, state) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            BWLocalizations.of(context).weatherService +
                                ": " +
                                state.weatherService.getName(),
                          ),
                          onPressed: WeatherService.services.length > 1
                              ? () =>
                                  BlocProvider.of<SettingsBloc>(context).add(
                                    SettingsUpdate(
                                      weatherService: WeatherService.services[
                                          (WeatherService.services.indexOf(
                                                      state.weatherService) +
                                                  1) %
                                              WeatherService.services.length],
                                    ),
                                  )
                              : null,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        FlatButton(
                          child: Text(
                            "Theme: " +
                                (state.themeMode.index == 0
                                    ? "System"
                                    : state.themeMode.index == 1
                                        ? "Light"
                                        : "Dark"),
                          ),
                          onPressed: () =>
                              BlocProvider.of<SettingsBloc>(context).add(
                            SettingsUpdate(
                              themeMode: ThemeMode
                                  .values[(state.themeMode.index + 1) % 3],
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                        ),
                        FlatButton(
                          child: Text(
                            "Dark Theme: " +
                                (state.darkThemeModeOled ? "OLED" : "Dim"),
                          ),
                          onPressed: () =>
                              BlocProvider.of<SettingsBloc>(context).add(
                            SettingsUpdate(
                                darkThemeModeOled: !state.darkThemeModeOled),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
