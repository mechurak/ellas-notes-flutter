import 'package:ellas_notes_flutter/themes/color_styles.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle mainText(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!;
  }

  static TextStyle hint(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorStyles.darkGrey,
        );
  }

  static TextStyle note(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      color: ColorStyles.lightGrey,
      fontFamilyFallback: ["sans-serif"],  //
    );
  }

  static TextStyle memo(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      color: ColorStyles.blueGrey,
      fontFamilyFallback: ["sans-serif"],
    );
  }
}
