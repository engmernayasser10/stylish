import 'package:flutter/material.dart';
import 'package:stylish/core/theme/dark_theme.dart';
import 'package:stylish/core/theme/light_theme.dart';

abstract class AppTheme {
  static ThemeData get getLightTheme => LightTheme.theme;
  static ThemeData get getDarkTheme => DarkTheme.theme;
}
