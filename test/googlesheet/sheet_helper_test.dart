import 'dart:convert';

import 'package:ellas_notes_flutter/googlesheet/sheet_helper.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:test/test.dart';

void main() {
  test('CellData test', () {
    String text = """
{
  "effectiveFormat": {
    "textFormat": {
      "bold": true
    }
  },
  "formattedValue": "go vegetarian",
  "textFormatRuns": [
    {
      "format": {
        "underline": true
      }
    },
    {
      "format": {},
      "startIndex": 2
    },
    {
      "format": {
        "underline": true
      },
      "startIndex": 7
    },
    {
      "format": {},
      "startIndex": 9
    }
  ]
}
""";

    RichText richText = SheetHelper.getRichText(text);
    print(richText);
  });
}
