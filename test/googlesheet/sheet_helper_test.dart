import 'dart:convert';

import 'package:ellas_notes_flutter/googlesheet/sheet_helper.dart';
import 'package:ellas_notes_flutter/models/subject.dart';
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

  test('updateSubjectInfo() test', () async {
    var tempSubject = Subject(
      sheetId: "1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE",
      title: "강성태 66일 영어회화",
      lastUpdate: DateTime.now(),
      description: null,
      link: null,
      imageUrl: null,
    );

    const spreadsheetId = '1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE';

    Spreadsheet spreadsheet = await SheetHelper.getSpreadsheet(spreadsheetId);
    Sheet docInfoSheet = SheetHelper.getDocInfoSheet(spreadsheet)!;


    Subject newSubject = SheetHelper.updateSubjectInfo(tempSubject, docInfoSheet);


    print('description: ${newSubject.description}');
    print('link: ${newSubject.link}');
    print('imageUrl: ${newSubject.imageUrl}');
    expect(newSubject.description, '당신의 영어가 습관이 되게에 충분한 시간');
  });
}
