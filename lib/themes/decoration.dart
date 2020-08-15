import 'package:flutter/material.dart';

abstract class BWDecoration {
  static BoxDecoration defaultBoxDecoration(BuildContext context) =>
      BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(4, 4),
            color: Colors.black26,
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          ),
        ],
      );
}
