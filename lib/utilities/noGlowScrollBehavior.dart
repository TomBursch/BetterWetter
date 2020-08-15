import 'package:flutter/material.dart';

// #TODO delete this class and make No Scroll work without it
class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}