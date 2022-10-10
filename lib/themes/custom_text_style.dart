import 'package:ellas_notes_flutter/themes/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle hint(BuildContext context) {
    return GoogleFonts.nanumBrushScript(textStyle: Theme.of(context).textTheme.titleLarge);
  }

  static TextStyle memo(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorStyles.darkGray,
        );
  }
}
