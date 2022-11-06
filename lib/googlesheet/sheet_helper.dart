import 'dart:convert';

import 'package:ellas_notes_flutter/repositories/lecture_repository.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import '../models/chapter.dart';
import '../models/subject.dart';
import '../models/word.dart';
import '../repositories/chapter_repository.dart';
import '../repositories/subject_repository.dart';
import '../secrets.dart';
import 'index_holder.dart';

class SheetHelper {
  static Chapter getChapter(IndexHolder idx, List<CellData> cells, int subjectKey) {
    String? category = (idx.metaCategory > 0 && cells.length > idx.metaCategory) ? cells[idx.metaCategory].formattedValue : null;
    String? remoteUrl = (idx.metaRemoteUrl > 0 && cells.length > idx.metaRemoteUrl) ? cells[idx.metaRemoteUrl].formattedValue : null;
    String? link1 = (idx.metaLink1 > 0 && cells.length > idx.metaLink1) ? cells[idx.metaLink1].formattedValue : null;
    String? link2 = (idx.metaLink2 > 0 && cells.length > idx.metaLink2) ? cells[idx.metaLink2].formattedValue : null;

    return Chapter(
      subjectKey: subjectKey,
      nameForKey: cells[idx.nameForId].formattedValue!,
      title: cells[idx.metaTitle].formattedValue!,
      category: category,
      remoteUrl: remoteUrl,
      localUrl: null,
      link1: link1,
      link2: link2,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    );
  }

  static Word getWord(IndexHolder idx, List<CellData> cells, int subjectKey) {
    String? hint = (idx.hint > 0 && cells.length > idx.hint) ? cells[idx.hint].formattedValue : null;
    String? note = (idx.note > 0 && cells.length > idx.note) ? cells[idx.note].formattedValue : null;
    String? memo = (idx.memo > 0 && cells.length > idx.memo) ? cells[idx.memo].formattedValue : null;
    String? quizTemp = (idx.quiz > 0 && cells.length > idx.quiz) ? cells[idx.quiz].formattedValue : null;
    int quiz = (quizTemp != null) ? int.parse(quizTemp) : 0;
    String chapterKey = cells[idx.nameForId].formattedValue!;

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

  static Future<bool> fetchSpreadsheet(String spreadsheetId) async {
    print('fetchSpreadsheet(). sheetId: $spreadsheetId');
    final Spreadsheet spreadsheet = await getSpreadsheet(spreadsheetId);
    print('spreadsheet: $spreadsheet');
    String title = spreadsheet.properties!.title!;
    print('title: $title');
    await ChapterRepository().openBoxWithPreload();
    await LectureRepository().openBoxWithPreload();

    // Check 'doc_info' sheet and upsert subject
    Sheet? docInfoSheet = getDocInfoSheet(spreadsheet);
    if (docInfoSheet == null) {
      print("no 'doc_info' sheet!!!");
      return false;
    }
    Subject subject = await _createOrGetSubject(title, spreadsheetId);
    subject = updateSubjectInfo(subject, docInfoSheet);
    await SubjectRepository().updateSubject(subject);

    Map<String, Chapter> chapterMap = await ChapterRepository().getChaptersBySubjectKey(subject.key);
    Set<String> remainedChapterSet = Set.from(chapterMap.keys);
    List<Word> words = [];
    updateChaptersAndWords(chapterMap, remainedChapterSet, words, subject, spreadsheet);
    await ChapterRepository().updateChapters(subject.key, chapterMap.values);
    await LectureRepository().updateWords(subject.key, words);

    return true;
  }

  static Future<Spreadsheet> getSpreadsheet(String spreadsheetId) async {
    // Accessing Public Data with API Key : https://pub.dev/packages/googleapis_auth
    var client = clientViaApiKey(googleApiKey);

    const fields = [
      'properties',
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
    Subject? prevSubject = await SubjectRepository().getSubjectBySheetId(spreadsheetId);
    if (prevSubject != null) {
      return prevSubject;
    } else {
      print('new sheetId!. create subject for $title');
      return Subject(
        key: -1,
        sheetId: spreadsheetId,
        title: title,
        isPrivate: false,  // TODO: Distinguish public and private spreadsheet
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

  static void updateChaptersAndWords(
    Map<String, Chapter> chapterMap,
    Set<String> remainedChapterSet,
    List<Word> words,
    Subject subject,
    Spreadsheet spreadsheet,
  ) {
    for (Sheet sheet in spreadsheet.sheets!) {
      SheetProperties sheetProperties = sheet.properties!;
      String sheetTitle = sheetProperties.title!;
      if (sheetTitle.startsWith('doc_info') || sheetTitle.endsWith('_temp')) {
        print('skip $sheetTitle sheet');
        continue;
      }

      int frozenRowCount = sheetProperties.gridProperties!.frozenRowCount!;
      if (frozenRowCount != 2) {
        print('unexpected frozenRowCount: $frozenRowCount!!!');
        // TODO: Let user know the error
      }

      GridData gridData = sheet.data![0]; // We don't query for multi section.
      IndexHolder indexHolder = IndexHolder();

      List<RowData> rowDataList = gridData.rowData!;
      Chapter? curChapter;
      for (int i = 0; i < rowDataList.length; i++) {
        List<CellData> cells = rowDataList[i].values!;

        if (i < frozenRowCount) {
          indexHolder.setColumnIndices(rowDataList[i]);
        } else if (cells[indexHolder.order].formattedValue == null) {
          print("order is null. row: $i");
        } else if (cells[indexHolder.order].formattedValue == "0") {
          Chapter chapterFromSheet = getChapter(indexHolder, cells, subject.key);
          // print(chapterFromSheet);
          curChapter = chapterMap[chapterFromSheet.nameForKey];
          if (curChapter != null) {
            curChapter.title = chapterFromSheet.title;
            curChapter.category = chapterFromSheet.category;
            curChapter.remoteUrl = chapterFromSheet.remoteUrl;
            curChapter.link1 = chapterFromSheet.link1;
            curChapter.link2 = chapterFromSheet.link2;
            curChapter.quizCount = 0; // Reset quizCount

            remainedChapterSet.remove(chapterFromSheet.nameForKey);
          } else {
            curChapter = chapterFromSheet;
            chapterMap[chapterFromSheet.nameForKey] = curChapter;
          }
        } else {
          Word word = SheetHelper.getWord(indexHolder, cells, subject.key);
          if (word.quizType > 0 && curChapter != null && word.chapterKey == curChapter.nameForKey) {
            curChapter.quizCount += 1;
          }
          words.add(word);
        }
      }
    }

    for (String chapterKey in remainedChapterSet) {
      print('Remove ${chapterMap[chapterKey]!.nameForKey}');
      chapterMap.remove(chapterKey);
    }
  }
}
