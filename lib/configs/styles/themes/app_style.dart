import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ThemeConfigs.lightPrimary,
  scaffoldBackgroundColor: ThemeConfigs.lightBackground,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: ThemeConfigs.lightText),
    bodyMedium: TextStyle(color: ThemeConfigs.lightText),
  ),
  colorScheme: ColorScheme.light(
    primary: ThemeConfigs.lightPrimary, //màu chính (
    onPrimary: Colors.black, //màu text/icon nằm trên primary
    surface: ThemeConfigs.lightBackground, //	màu nền
    onSurface: ThemeConfigs.lightText, //màu chữ/icon nằm trên nền
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: ThemeConfigs.darkPrimary,
  scaffoldBackgroundColor: ThemeConfigs.darkBackground,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: ThemeConfigs.darkText),
    bodyMedium: TextStyle(color: ThemeConfigs.darkText),
  ),
  colorScheme: ColorScheme.dark(
    primary: ThemeConfigs.darkPrimary,
    onPrimary: Colors.white,
    surface: ThemeConfigs.darkBackground,
    onSurface: ThemeConfigs.darkText,
  ),
);
