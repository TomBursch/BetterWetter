import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class BWLocalizations {
  BWLocalizations();

  static Future<BWLocalizations> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? true)
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return BWLocalizations();
    });
  }

  static BWLocalizations of(BuildContext context) {
    return Localizations.of<BWLocalizations>(context, BWLocalizations);
  }

  String get title => Intl.message(
        'BetterWetter',
        name: 'title',
        desc: 'Title for the BetterWetter application',
      );

  String get add => Intl.message('Add', name: "add");
  String get cancel => Intl.message('Cancel', name: "cancel");
  String get back => Intl.message('Back', name: "back");
  String get save => Intl.message('Save', name: "save");
  String get location => Intl.message('Location', name: "location");
  String get faq => Intl.message('FAQ', name: "faq");
  String get done => Intl.message('Done', name: "done");
  String get delete => Intl.message('Delete', name: "delete");
  String get remove => Intl.message('Remove', name: "remove");
  String get privacy => Intl.message('Privacy', name: "privacy");
  String get error => Intl.message('Error', name: "error");
  String get edit => Intl.message('Edit', name: "edit");
  String get date => Intl.message('Date', name: "date");
  String get you => Intl.message('You', name: "you");
  String get info => Intl.message('Info', name: "info");
  String get yes => Intl.message('Yes', name: "yes");
  String get no => Intl.message('No', name: "no");
  String get maybe => Intl.message('Maybe', name: "maybe");
  String get search => Intl.message('Search', name: "search");
  String get home => Intl.message('Home', name: "home");
  String get website => Intl.message('Website', name: "website");
  String get settings => Intl.message('Settings', name: "settings");
  String get now => Intl.message('Now', name: "now");
  String get sunrise => Intl.message('Sunrise', name: "sunrise");
  String get sunset => Intl.message('Sunset', name: "sunset");

  String get weatherService =>
      Intl.message('Weather Service', name: "weatherService");

  String get feelsLike => Intl.message('Feels like', name: "feelsLike");
  String get humidity => Intl.message('Humidity', name: "humidity");
  String get uvIndex => Intl.message('UV Index', name: "uvIndex");
  String get windspeed => Intl.message('Windspeed', name: "windspeed");
  String get pressure => Intl.message('Pressure', name: "pressure");
  String get visibility => Intl.message('Visibility', name: "visibility");
  String get clouds => Intl.message('Clouds', name: "clouds");
}

class BWLocalizationsDelegate extends LocalizationsDelegate<BWLocalizations> {
  const BWLocalizationsDelegate();
  static const delegate = BWLocalizationsDelegate();

  final Iterable<Locale> supportedLocales = const [
    Locale('en'),
    Locale('de'),
  ];

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.map((l) => l.languageCode).contains(locale.languageCode);

  @override
  Future<BWLocalizations> load(Locale locale) => BWLocalizations.load(locale);

  @override
  bool shouldReload(BWLocalizationsDelegate old) => false;
}
