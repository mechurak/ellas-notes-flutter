import 'package:flutter/material.dart';

class EllasNotesThemeData {
  static ThemeData lightThemeData = themeData();

  static ThemeData themeData() {
    final base = ThemeData.light();
    return base.copyWith(
      textTheme: _buildEllasNotesTextTheme(base.textTheme),
    );
  }

  static TextTheme _buildEllasNotesTextTheme(TextTheme base) {
    return base.apply(
      fontFamily: "CookieRun",
    );
  }
}
