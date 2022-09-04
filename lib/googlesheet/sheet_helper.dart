import 'dart:convert';

import 'package:ellas_notes_flutter/googlesheet/index_holder.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/subject.dart';
import '../models/word.dart';
import '../repositories/subject_repository.dart';
import '../secrets.dart';

class SheetHelper {
  static Word getWord(IndexHolder idx, List<CellData> cells, int subjectKey, int chapterKey) {
    String? hint = (idx.hint > 0 && cells.length > idx.hint) ? cells[idx.hint].formattedValue : null;
    String? note = (idx.note > 0 && cells.length > idx.note) ? cells[idx.note].formattedValue : null;
    String? memo = (idx.memo > 0 && cells.length > idx.memo) ? cells[idx.memo].formattedValue : null;
    String? quizTemp = (idx.quiz > 0 && cells.length > idx.quiz) ? cells[idx.quiz].formattedValue : null;
    int quiz = (quizTemp != null) ? int.parse(quizTemp) : 0;

    return Word(
      subjectKey: subjectKey,
      chapterKey: chapterKey,
      order: int.parse(cells[idx.order].formattedValue!),
      quizType: quiz,
      text: jsonEncode(cells[idx.text]),
      // jsonEncode : https://docs.flutter.dev/development/data-and-backend/json
      hint: hint,
      note: note,
      memo: memo,
    );
  }

  static RichText getRichText(String text) {
    CellData cellData = CellData.fromJson(jsonDecode(text));

    String tempStr = cellData.formattedValue!;
    List<TextSpan> children = [];

    if (tempStr.startsWith('##')) {
      TextSpan span = TextSpan(
        text: tempStr,
        style: const TextStyle(
          color: Colors.orange,
        ),
      );
      children.add(span);

      return RichText(
        text: TextSpan(
          text: '',
          children: children,
        ),
      );
    }

    if (cellData.textFormatRuns != null) {
      TextFormatRun curItem = cellData.textFormatRuns![0];
      curItem.startIndex = 0;

      for (int i = 1; i < cellData.textFormatRuns!.length; i++) {
        TextFormatRun nextItem = cellData.textFormatRuns![i];
        children.add(_getTextSpan(tempStr, curItem, nextItem));
        curItem = nextItem;
      }
      children.add(_getTextSpan(tempStr, curItem, null)); // last item
    } else {
      TextSpan span = TextSpan(
        text: tempStr,
        style: const TextStyle(
          color: Colors.black,
        ),
      );
      children.add(span);
    }

    return RichText(
      text: TextSpan(
        text: '',
        children: children,
      ),
    );
  }

  static TextSpan _getTextSpan(String wholeText, TextFormatRun curItem, TextFormatRun? nextItem) {
    int? prevEndIndex = nextItem?.startIndex;
    var bgColor = curItem.format?.underline == true ? Colors.yellow : null;
    var color = curItem.format?.italic == true ? Colors.purple : Colors.black;
    return TextSpan(
      text: wholeText.substring(curItem.startIndex!, prevEndIndex),
      style: TextStyle(
        color: color,
        backgroundColor: bgColor,
      ),
    );
  }

  static Future<bool> fetchSpreadsheet(String spreadsheetId) async {
    final Spreadsheet spreadsheet = await getSpreadsheet(spreadsheetId);
    String title = spreadsheet.properties!.title!;

    // Check 'doc_info' sheet and upsert subject
    Sheet? docInfoSheet = getDocInfoSheet(spreadsheet);
    if (docInfoSheet == null) {
      print("no 'doc_info' sheet!!!");
      return false;
    }
    Subject subject = await _createOrGetSubject(title, spreadsheetId);
    subject = updateSubjectInfo(subject, docInfoSheet);
    await SubjectRepository().updateSubject(subject);

    // TODO: Upsert chapters and words

    return true;
  }

  static Future<Spreadsheet> getSpreadsheet(String spreadsheetId) async {
    // Accessing Public Data with API Key : https://pub.dev/packages/googleapis_auth
    var client = clientViaApiKey(googleApiKey);

    const fields = [
      'sheets.properties',
      'sheets.data.rowData.values.formattedValue',
      'sheets.data.rowData.values.textFormatRuns',
      'sheets.data.rowData.values.effectiveFormat.textFormat.bold'
    ];

    final sheetsApi = SheetsApi(client);
    final Spreadsheet spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId, $fields: fields.join(','));
    return spreadsheet;
  }

  static Sheet? getDocInfoSheet(Spreadsheet spreadsheet) {
    // Check 'doc_info' sheet
    Sheet? docInfoSheet;
    for (Sheet sheet in spreadsheet.sheets!) {
      if ("doc_info" == sheet.properties?.title) {
        docInfoSheet = sheet;
        break;
      }
    }
    return docInfoSheet;
  }

  static Future<Subject> _createOrGetSubject(String title, String spreadsheetId) async {
    Box subjectBox = (await SubjectRepository().openBoxWithPreload())!;

    if (subjectBox.values.where((subject) => subject.sheetId == spreadsheetId).isNotEmpty) {
      return subjectBox.get(spreadsheetId);
    } else {
      print('new sheetId!. create subject for $title');
      return Subject(
        key: -1,
        sheetId: spreadsheetId,
        title: title,
        lastUpdate: DateTime.now(),
        description: null,
        link: null,
        imageUrl: null,
      );
    }
  }

  static Subject updateSubjectInfo(Subject subject, Sheet docInfoSheet) {
    GridData gridData = docInfoSheet.data![0]; // It doesn't query for multi-sections.

    List<RowData> rowDataList = gridData.rowData!;

    String? description;
    String? link;
    String? subjectForUrl;
    String? image;

    for (int i = 0; i < rowDataList.length; i++) {
      List<CellData>? cells = rowDataList[i].values;
      if (cells == null || cells.length < 2) {
        // print('unexpected cells.length: ${cells?.length}. row: ${i + 1}');
        continue;
      }

      switch (cells[0].formattedValue) {
        case 'key':
          break;
        case 'description':
          description = cells[1].formattedValue;
          break;
        case 'link':
          link = cells[1].formattedValue;
          break;
        case 'subjectForUrl':
          subjectForUrl = cells[1].formattedValue;
          break;
        case 'image':
          image = cells[1].formattedValue;
          break;
        default:
        // print('unexpected key. ${cells[0].formattedValue}. row: ${i + 1}');
      }
    }

    subject.description = description;
    subject.link = link;
    subject.imageUrl = image;

    return subject;
  }
}
