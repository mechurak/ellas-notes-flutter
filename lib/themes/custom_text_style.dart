import 'package:ellas_notes_flutter/themes/color_styles.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle hint(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      color: ColorStyles.darkGray,
    );
    // return GoogleFonts.nanumBrushScript(textStyle: Theme.of(context).textTheme.titleLarge);
  }

  static TextStyle memo(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorStyles.darkGray,
        );
  }
}
