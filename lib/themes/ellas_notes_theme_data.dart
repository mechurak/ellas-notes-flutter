import 'package:flutter/material.dart';

class EllasNotesThemeData {
  static ThemeData lightThemeData = themeData();

  static ThemeData themeData() {
    final base = ThemeData.light();
    return base;
    // TODO: Add fonts
    // return base.copyWith(
    //   textTheme: _buildEllasNotesTextTheme(base.textTheme),
    // );
  }

  static TextTheme _buildEllasNotesTextTheme(TextTheme base) {
    return base.copyWith(
      // titleLarge: GoogleFonts.robotoSlab(textStyle: base.titleLarge), // main text
      // bodyMedium: GoogleFonts.nanumGothic(textStyle: base.bodyMedium), // note
    );
  }
}
