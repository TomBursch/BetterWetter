import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisPageRoute<T> extends PageRouteBuilder<T> {
  SharedAxisPageRoute(
      {@required Widget Function(BuildContext) builder,
      SharedAxisTransitionType type = SharedAxisTransitionType.horizontal})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: type,
            );
          },
        );
}
