import 'package:BetterWetter/auth/keys.dart';
import 'package:BetterWetter/bloc/settings/bloc.dart';
import 'package:BetterWetter/themes/styles.dart';
import 'package:BetterWetter/utilities/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';

import 'l10n/bwLocalizationDelegate.dart';
import 'screens/home.dart';

class BetterWetterApp extends StatefulWidget {
  static final Storage prefrenceStorage = PreferenceStorage();
  static final Geolocator geolocator = Geolocator();
  static final Future<Enviroment> enviroment = EnviromentLoader.load();

  @override
  _BetterWetterAppState createState() => _BetterWetterAppState();
}

class _BetterWetterAppState extends State<BetterWetterApp> {
  SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = SettingsBloc(storage: BetterWetterApp.prefrenceStorage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocProvider<SettingsBloc>.value(
        value: _settingsBloc,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: _settingsBloc,
          builder: (context, state) => MaterialApp(
            title: 'BetterWetter',
            themeMode: state.themeMode,
            showPerformanceOverlay: state.showPerformanceOverlay,
            debugShowCheckedModeBanner: false,
            theme: BWThemes.appTheme,
            darkTheme: state.darkThemeModeOled
                ? BWThemes.appThemeBlack
                : BWThemes.appThemeDark,
            localizationsDelegates: [
              BWLocalizationsDelegate.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: BWLocalizationsDelegate.delegate.supportedLocales,
            onGenerateTitle: (BuildContext context) =>
                BWLocalizations.of(context).title,
            home: BlocListener<SettingsBloc, SettingsState>(
              bloc: _settingsBloc,
              listener: (context, state) {
                _setSystemUI(context);
              },
              child: HomeScreen(),
            ),
          ),
        ),
      ),
    );
  }

  void _setSystemUI(BuildContext context) {
    switch (_settingsBloc.state.themeMode) {
      case ThemeMode.system:
        final Brightness brightnessValue =
            MediaQuery.of(context).platformBrightness;
        if (brightnessValue == Brightness.dark)
          continue dark;
        else
          continue light;
        break;
      light:
      case ThemeMode.light:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: BWThemes.appTheme.appBarTheme.color,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: BWThemes.appTheme.backgroundColor,
          systemNavigationBarDividerColor: BWThemes.appTheme.backgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
        break;
      dark:
      case ThemeMode.dark:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: (_settingsBloc.state.darkThemeModeOled
                  ? BWThemes.appThemeBlack
                  : BWThemes.appThemeDark)
              .appBarTheme
              .color,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: (_settingsBloc.state.darkThemeModeOled
                  ? BWThemes.appThemeBlack
                  : BWThemes.appThemeDark)
              .backgroundColor,
          systemNavigationBarDividerColor:
              (_settingsBloc.state.darkThemeModeOled
                      ? BWThemes.appThemeBlack
                      : BWThemes.appThemeDark)
                  .backgroundColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ));
        break;
    }
  }

  @override
  void dispose() {
    _settingsBloc.close();
    super.dispose();
  }
}
