import 'dart:convert';

import 'package:ellas_notes_flutter/googlesheet/index_holder.dart';
import 'package:ellas_notes_flutter/googlesheet/sheet_helper.dart';
import 'package:ellas_notes_flutter/models/word.dart';
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

  int? frozenRowCount = day56Sheet?.properties?.gridProperties?.frozenRowCount;
  if (frozenRowCount != 2) {
    print("unexpected frozenRowCount: $frozenRowCount");
    return;
  }

  IndexHolder indexHolder = IndexHolder();
  GridData gridData = day56Sheet!.data![0];
  List<RowData> rowDataList = gridData.rowData!;
  for (int i = 0; i < rowDataList.length; i++) {
    List<CellData> cells = rowDataList[i].values!;

    if (i < frozenRowCount!) {
      indexHolder.setColumnIndices(rowDataList[i]);
    } else if (cells[indexHolder.order].formattedValue == null) {
      print("order is null. row: $i");
    } else if (cells[indexHolder.order].formattedValue == "0") {
      // TODO: Add Chapter
    } else {
      Word word = SheetHelper.getWord(indexHolder, cells, -1, -1);
      print(word);
    }
  }
}
