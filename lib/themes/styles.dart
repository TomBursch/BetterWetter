import 'package:flutter/material.dart';
import 'colors.dart';

export 'colors.dart';
export 'themes.dart';
export 'decoration.dart';

abstract class BWStyles {
  static const TextStyle h1TextStyleLight = const TextStyle(
    color: BWColors.textDark,
    letterSpacing: 4,
    fontSize: 50,
  );
  static const TextStyle h1TextStyleDark = const TextStyle(
    color: Colors.white,
    letterSpacing: 4,
    fontSize: 50,
  );

  static const TextStyle h2TextStyleLight = const TextStyle(
    color: BWColors.accent,
    letterSpacing: 4,
    fontSize: 30,
  );
  static const TextStyle h2TextStyleDark = const TextStyle(
    color: BWColors.accent,
    letterSpacing: 4,
    fontSize: 30,
  );

  static const TextStyle h3TextStyleLight = const TextStyle(
    color: BWColors.textDark,
    letterSpacing: 4,
    fontSize: 25,
  );
  static const TextStyle h3TextStyleDark = const TextStyle(
    color: Colors.white,
    letterSpacing: 4,
    fontSize: 25,
  );

  static const TextStyle h4TextStyleLight = const TextStyle(
      color: BWColors.accent,
      letterSpacing: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static const TextStyle h4TextStyleDark = const TextStyle(
      color: BWColors.accent,
      letterSpacing: 2,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle captionTextStyleLight = const TextStyle(
    color: BWColors.textDark,
    letterSpacing: .5,
    fontSize: 20,
  );
  static const TextStyle captionTextStyleDark = const TextStyle(
    color: BWColors.textLight,
    letterSpacing: .5,
    fontSize: 20,
  );

  static TextStyle overlineTextStyleLight = TextStyle(
    color: BWColors.textDark.withOpacity(1),
    letterSpacing: 2,
    fontSize: 20,
  );
  static TextStyle overlineTextStyleDark = TextStyle(
    color: BWColors.textLight.withOpacity(1),
    letterSpacing: 2,
    fontSize: 20,
  );

  static const TextStyle buttonTextStyleLight = const TextStyle(
    color: BWColors.textDark,
    letterSpacing: 0,
    fontSize: 15,
  );
  static const TextStyle buttonTextStyleDark = const TextStyle(
    color: BWColors.textLight,
    letterSpacing: 0,
    fontSize: 15,
  );

  static const TextStyle bodyTextStyleLight = const TextStyle(
    color: BWColors.textDark,
    letterSpacing: .5,
    fontSize: 18,
  );
  static const TextStyle bodyTextStyleDark = const TextStyle(
    color: BWColors.textLight,
    letterSpacing: .5,
    fontSize: 18,
  );

  static TextStyle hintTextStyleLight = TextStyle(
    color: BWColors.textDark.withOpacity(.4),
    letterSpacing: .5,
    fontSize: 18,
  );
  static TextStyle hintTextStyleDark = TextStyle(
    color: BWColors.textLight.withOpacity(.4),
    letterSpacing: .5,
    fontSize: 18,
  );

  //Specifc styles
  static const TextStyle gradientButtonTextStyle = const TextStyle(
    color: Colors.white,
    letterSpacing: 2,
    fontSize: 25,
  );
}
