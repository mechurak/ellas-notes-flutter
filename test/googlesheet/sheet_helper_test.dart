import 'package:ellas_notes_flutter/googlesheet/sheet_helper.dart';
import 'package:ellas_notes_flutter/models/chapter.dart';
import 'package:ellas_notes_flutter/models/subject.dart';
import 'package:ellas_notes_flutter/models/word.dart';
import 'package:ellas_notes_flutter/repositories/chapter_repository.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:test/test.dart';

void main() {
  test('updateSubjectInfo() test', () async {
    var tempSubject = Subject(
      key: -1,
      sheetId: "1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE",
      title: "강성태 66일 영어회화",
      isPrivate: false,
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

  test('updateChaptersAndWords() test', () async {
    var tempSubject = Subject(
      key: 1,
      sheetId: "1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE",
      title: "강성태 66일 영어회화",
      isPrivate: false,
      lastUpdate: DateTime.now(),
      description: null,
      link: null,
      imageUrl: null,
    );

    const spreadsheetId = '1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE';
    Spreadsheet spreadsheet = await SheetHelper.getSpreadsheet(spreadsheetId);

    Map<String, Chapter> chapterMap = ChapterRepository().getFakeChaptersBySubjectKey(tempSubject.key);
    Set<String> remainedChapterSet = Set.from(chapterMap.keys);
    List<Word> words = [];

    print('chapterMap.length before: ${chapterMap.length}');
    print('remainedChapterSet.length before: ${remainedChapterSet.length}');
    print('words.length before: ${words.length}');

    SheetHelper.updateChaptersAndWords(chapterMap, remainedChapterSet, words, tempSubject, spreadsheet);

    print('chapterMap.length: ${chapterMap.length}');
    print('remainedChapterSet.length: ${remainedChapterSet.length}');
    print('words.length: ${words.length}');

    for (Chapter chapter in chapterMap.values) {
      print('${chapter.nameForKey} - quizCount: ${chapter.quizCount}, studyPoint: ${chapter.studyPoint}, lastStudyDate: ${chapter.lastStudyDate}');
    }
  });
}
