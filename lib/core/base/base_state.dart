import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);
  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
  Size get size => MediaQuery.of(context).size;
  double get height => size.height;
  double get width => size.width;
  EdgeInsets get padding => MediaQuery.of(context).padding;
} 