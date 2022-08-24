import 'dart:convert';

import 'package:ellas_notes_flutter/secrets.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

const _spreadsheetId = '1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE';
const _fields = [
  'sheets.properties',
  'sheets.data.rowData.values.formattedValue',
  'sheets.data.rowData.values.textFormatRuns',
  'sheets.data.rowData.values.effectiveFormat.textFormat.bold'
];

void main() async {
  // Accessing Public Data with API Key : https://pub.dev/packages/googleapis_auth
  var client = clientViaApiKey(googleApiKey);

  final sheetsApi = SheetsApi(client);
  final ss = await sheetsApi.spreadsheets.get(_spreadsheetId, $fields: _fields.join(','));
  print(ss);

  List<Sheet> sheets = ss.sheets!;
  Sheet? day56Sheet;
  for (Sheet sheet in sheets) {
    print(sheet.properties?.title);
    if ("DAY 56~65" == sheet.properties?.title) {
      print("Found DAY 56~65");
      day56Sheet = sheet;
    }
  }

  GridData gridData = day56Sheet!.data![0];
  List<RowData> rowDataList = gridData.rowData!;
  for (RowData row in rowDataList) {
    List<CellData> cells = row.values!;

    for (CellData cell in cells) {
      if (cell.formattedValue != null) {
        print(cell.formattedValue);
      }
      if (cell.textFormatRuns != null) {
        print(jsonEncode(cell.textFormatRuns));  // jsonEncode : https://docs.flutter.dev/development/data-and-backend/json
      }
    }
  }
}
