import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFEF4444); // Red-500
const Color primaryColorDark = Color(0xFFB91C1C); // Red-700
const Color secondaryColor = Color(0xFF2563EB); // Blue-600
const Color backgroundLight = Color(0xFFF9FAFB);
const Color backgroundDark = Color(0xFF121212);
const Color surfaceLight = Colors.white;
const Color surfaceDark = Color(0xFF1E1E1E);
const Color errorColor = Color(0xFFB00020);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    background: backgroundLight,
    surface: surfaceLight,
    error: errorColor,
  ),
  scaffoldBackgroundColor: backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[200],
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColorDark,
  colorScheme: ColorScheme.dark(
    primary: primaryColorDark,
    secondary: secondaryColor,
    background: backgroundDark,
    surface: surfaceDark,
    error: errorColor,
  ),
  scaffoldBackgroundColor: backgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColorDark,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[800],
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData appTheme = lightTheme;

