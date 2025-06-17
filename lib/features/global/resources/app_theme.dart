import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(scrolledUnderElevation: 0),
      useMaterial3: true,
    );
  }
}
