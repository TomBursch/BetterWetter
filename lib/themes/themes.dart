import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

abstract class BWThemes {
  static ThemeData appTheme = ThemeData(
    canvasColor: BWColors.backgroundLight,
    brightness: Brightness.light,
    primaryColor: BWColors.primary,
    primaryColorLight: BWColors.primaryLight,
    primaryColorDark: BWColors.primary,
    accentColor: BWColors.accent,
    backgroundColor: BWColors.backgroundLight,
    buttonTheme: defaultButtonTheme(),
    iconTheme: defaultIconTheme,
    textTheme: defaultTextTheme(),
    scaffoldBackgroundColor: BWColors.backgroundLight,
    appBarTheme: AppBarTheme(elevation: 5, color: BWColors.backgroundLight),
    inputDecorationTheme: defaultInputDecorationTheme(),
    textSelectionHandleColor: BWColors.accent,
    textSelectionColor: BWColors.accent,
    dividerTheme: defaultDividerTheme,
    bottomSheetTheme: defaultBottomSheetTheme,
    primaryTextTheme: defaultTextTheme(),
    accentTextTheme: defaultTextTheme(),
    cardColor: BWColors.greyLight,
    cupertinoOverrideTheme:
        const CupertinoThemeData(brightness: Brightness.light),
  );

  static ButtonThemeData defaultButtonTheme(
          {Color accent = BWColors.accent, Color enabled = BWColors.primary}) =>
      ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          buttonColor: accent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)));

  static IconThemeData defaultIconTheme = IconThemeData(
    color: BWColors.accent,
  );

  static InputDecorationTheme defaultInputDecorationTheme({
    Color accent = BWColors.accent,
    Color enabled = BWColors.primary,
    Brightness brightness,
  }) =>
      InputDecorationTheme(
        hintStyle: brightness == Brightness.dark
            ? BWStyles.hintTextStyleDark
            : BWStyles.hintTextStyleLight,
        counterStyle: brightness == Brightness.dark
            ? BWStyles.hintTextStyleDark
            : BWStyles.hintTextStyleLight,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20, 15.0),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide(color: enabled),
          gapPadding: 1,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide(color: Colors.red),
          gapPadding: 1,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide(color: Colors.red),
          gapPadding: 1,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          gapPadding: 1,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gapPadding: 1,
          borderSide: BorderSide(color: accent),
        ),
      );

  static InputDecorationTheme minimalisticInputDecorationTheme(
          BuildContext context) =>
      InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
        hintStyle: Theme.of(context).textTheme.bodyText2.apply(
            color: Theme.of(context).textTheme.bodyText2.color.withOpacity(.4)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
      );

  static InputDecorationTheme messageInputDecorationTheme(
      BuildContext context) {
    final _defaultBorder = OutlineInputBorder(
      gapPadding: 1,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Theme.of(context).dividerColor),
    );
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      hintStyle: Theme.of(context).textTheme.bodyText2.apply(
          color: Theme.of(context).textTheme.bodyText2.color.withOpacity(.4)),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      border: _defaultBorder,
      enabledBorder: _defaultBorder,
      disabledBorder: _defaultBorder,
      errorBorder: _defaultBorder,
      focusedBorder: _defaultBorder,
      focusedErrorBorder: _defaultBorder,
    );
  }

  static InputDecorationTheme collapsedInputDecorationTheme =
      InputDecorationTheme(
    contentPadding: EdgeInsets.zero,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    isDense: true,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    border: InputBorder.none,
    disabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    errorBorder: InputBorder.none,
  );

  static DividerThemeData defaultDividerTheme =
      DividerThemeData(color: Colors.black54, thickness: .5);

  static TextTheme defaultTextTheme({
    Color accent = BWColors.accent,
    Brightness brightness = Brightness.light,
  }) =>
      brightness == Brightness.light
          ? TextTheme(
              headline5: BWStyles.bodyTextStyleLight,
              headline6: BWStyles.bodyTextStyleLight.apply(color: accent),
              subtitle1: BWStyles.bodyTextStyleLight,
              bodyText1: BWStyles.bodyTextStyleLight.apply(color: accent),
              bodyText2: BWStyles.bodyTextStyleLight, //body
              caption: BWStyles.captionTextStyleLight,
              headline4: BWStyles.h4TextStyleLight,
              headline3: BWStyles.h3TextStyleLight,
              headline2: BWStyles.h2TextStyleLight,
              headline1: BWStyles.h1TextStyleLight,
              overline: BWStyles.overlineTextStyleLight,
              subtitle2: BWStyles.bodyTextStyleLight,
              button: BWStyles.buttonTextStyleLight,
            )
          : TextTheme(
              headline5: BWStyles.bodyTextStyleDark,
              headline6: BWStyles.bodyTextStyleDark.apply(color: accent),
              subtitle1: BWStyles.bodyTextStyleDark,
              bodyText1: BWStyles.bodyTextStyleDark.apply(color: accent),
              bodyText2: BWStyles.bodyTextStyleDark, //body
              caption: BWStyles.captionTextStyleDark,
              headline4: BWStyles.h4TextStyleDark,
              headline3: BWStyles.h3TextStyleDark,
              headline2: BWStyles.h2TextStyleDark,
              headline1: BWStyles.h1TextStyleDark,
              overline: BWStyles.overlineTextStyleDark,
              subtitle2: BWStyles.bodyTextStyleDark,
              button: BWStyles.buttonTextStyleDark,
            );

  static BottomSheetThemeData defaultBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: BWColors.backgroundLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
    ),
  );

  static ThemeData appThemeCustomAccent(BuildContext context, Color accent) {
    return Theme.of(context).copyWith(
      accentColor: accent,
      iconTheme: defaultIconTheme.copyWith(color: accent),
      inputDecorationTheme: defaultInputDecorationTheme(
        accent: accent,
        enabled: Theme.of(context).brightness == Brightness.dark
            ? BWColors.primaryLight
            : BWColors.primary,
        brightness: Theme.of(context).brightness,
      ),
      textSelectionHandleColor: accent,
      cursorColor: accent,
      textSelectionColor: accent,
      toggleableActiveColor: accent,
      textTheme: defaultTextTheme(
          accent: accent, brightness: Theme.of(context).brightness),
      buttonTheme: defaultButtonTheme(accent: accent),
    );
  }

  static ThemeData appThemeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: BWColors.primaryLight,
    primaryColorLight: BWColors.primary,
    primaryColorDark: BWColors.primary,
    accentColor: BWColors.accentDark,
    canvasColor: BWColors.backgroundDark,
    cardColor: BWColors.greyDark,
    backgroundColor: BWColors.backgroundDark,
    textTheme: defaultTextTheme(
        accent: BWColors.accentDark, brightness: Brightness.dark),
    scaffoldBackgroundColor: BWColors.backgroundDark,
    appBarTheme:
        AppBarTheme(elevation: 5, color: BWColors.backgroundDarkSecondary),
    inputDecorationTheme: defaultInputDecorationTheme(
      enabled: BWColors.primaryLight,
      accent: BWColors.accentDark,
      brightness: Brightness.dark,
    ),
    textSelectionHandleColor: BWColors.accentDark,
    textSelectionColor: BWColors.accentDark,
    dividerTheme: defaultDividerTheme.copyWith(color: Colors.white60),
    primaryTextTheme: defaultTextTheme(
        accent: BWColors.accentDark, brightness: Brightness.dark),
    accentTextTheme: defaultTextTheme(
        accent: BWColors.accentDark, brightness: Brightness.dark),
    bottomSheetTheme: defaultBottomSheetTheme.copyWith(
        backgroundColor: BWColors.backgroundDark),
    iconTheme: defaultIconTheme.copyWith(color: BWColors.accentDark),
    buttonTheme: defaultButtonTheme(accent: BWColors.accentDark),
    cupertinoOverrideTheme:
        const CupertinoThemeData(brightness: Brightness.dark),
  );

  static ThemeData appThemeBlack = appThemeDark.copyWith(
    canvasColor: Colors.black,
    cardColor: BWColors.backgroundDark,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    bottomSheetTheme:
        defaultBottomSheetTheme.copyWith(backgroundColor: Colors.black),
  );
}
