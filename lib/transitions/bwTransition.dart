import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sharedAxisPageRoute.dart';

PageRoute<T> bwTransition<T>(
        {BuildContext context,
        Widget Function(BuildContext) builder,
        PageRoute<T> Function(Widget Function(BuildContext))
            androidPageRoute}) =>
    Platform.isIOS
        ? CupertinoPageRoute<T>(builder: builder)
        : androidPageRoute != null
            ? androidPageRoute(builder)
            : SharedAxisPageRoute<T>(builder: builder);
