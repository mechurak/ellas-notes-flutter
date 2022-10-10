import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EllasNotesThemeData {
  static ThemeData lightThemeData = themeData();

  static ThemeData themeData() {
    final base = ThemeData.light();
    return base.copyWith(
      textTheme: _buildEllasNotesTextTheme(base.textTheme),
    );
  }

  static TextTheme _buildEllasNotesTextTheme(TextTheme base) {
    return base.copyWith(
      titleLarge: GoogleFonts.robotoSlab(textStyle: base.titleLarge), // main text
      bodyMedium: GoogleFonts.nanumGothic(textStyle: base.bodyMedium), // note
    );
  }
}
