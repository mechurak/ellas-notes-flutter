import 'package:hive_flutter/hive_flutter.dart';

import '../models/word.dart';

class LectureRepository {
  static const String wordBox = 'word';

  final List<Word> _fakeWords = [
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 1,
      quizType: 0,
      text: '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"## 001: I\u0027m"}',
      hint: '나는 ~이다',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 2,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m John Carter.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":3}]}',
      hint: '저는 존 카터입니다.',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 3,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m glad / you came.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":3},{"format":{"bold":true},"startIndex":11},{"format":{},"startIndex":19}]}',
      hint: '나는 기뻐요 / 당신이 와서.',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 4,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m here / to return this book.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":3},{"format":{"bold":true},"startIndex":11},{"format":{},"startIndex":30}]}',
      hint: '나는 여기 있어요 / 이 책을 반납하려고.',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 11,
      quizType: 0,
      text: '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"## 002: I\u0027m sorry ( to+동사 / about )"}',
      hint: '나는 유감이다 (~해서 / ~에 관해)',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 12,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m sorry / to disturb you.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":9},{"format":{"bold":true},"startIndex":12},{"format":{"bold":true,"italic":true},"startIndex":15},{"format":{"bold":true,"italic":true,"underline":true},"startIndex":17},{"format":{"bold":true},"startIndex":22},{"format":{},"startIndex":26}]}',
      hint: '나는 미안해요 / 당신을 방해해서.',
      note: "disturb /dɪˈstɜrb/ 방해하다, 폐를 끼치다",
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 13,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m sorry / to hear that.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":9},{"format":{"bold":true},"startIndex":12},{"format":{},"startIndex":24}]}',
      hint: '나는 유감이에요 / 그것을 듣게 되어.',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 14,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m sorry / about the delay.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":9},{"format":{"bold":true},"startIndex":12},{"format":{"bold":true,"italic":true},"startIndex":22},{"format":{"bold":true,"italic":true,"underline":true},"startIndex":24},{"format":{},"startIndex":27}]}',
      hint: '나는 미안해 / 늦어서.',
      note: "delay /dɪˈleɪ/ 지연, 연기",
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 21,
      quizType: 0,
      text: '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"## 003: I\u0027m sure"}',
      hint: '나는 확신한다',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 22,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m sure / it\u0027ll be OK.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":8},{"format":{"bold":true},"startIndex":11},{"format":{},"startIndex":22}]}',
      hint: '나는 확신해요 / 괜찮을 거라고.',
      note: null,
      memo: null,
    ),
    Word(
      subjectKey: 1,
      chapterKey: "DAY 01 a",
      order: 23,
      quizType: 0,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I\u0027m sure / we can win first prize.","textFormatRuns":[{"format":{"italic":true}},{"format":{},"startIndex":8},{"format":{"bold":true},"startIndex":11},{"format":{"bold":true,"italic":true},"startIndex":18},{"format":{"bold":true},"startIndex":21},{"format":{},"startIndex":33}]}',
      hint: '나는 확신해요 / 우리가 1등 상을 탈 수 있을 거라고.',
      note: 'delay /dɪˈleɪ/ 지연, 연기',
      memo: '/dɪˈleɪ/. test memo. this is long test memo.\n with new line character.',
    ),
    Word(
      subjectKey: 1,
      chapterKey: 'DAY 63 a',
      order: 23,
      quizType: 1,
      text:
          '{"effectiveFormat":{"textFormat":{"bold":false}},"formattedValue":"I feel like everyone likes me.","textFormatRuns":[{"format":{"italic":true}},{"format":{"bold":true,"italic":true},"startIndex":2},{"format":{},"startIndex":11}]}',
      hint: '모든 사람이 나를 좋아하는 것 같아. (I f___ l___)',
      note: 'everyone 은 단수 취급',
      memo: '테스트 메모. 아주 긴 테스트 메모.\n/dɪˈleɪ/. test memo. this is long test memo.\n with new line character.',
    ),
  ];

  final Word fakeWordWithBold = Word(
    subjectKey: 1,
    chapterKey: 'DAY 65 b',
    order: 51,
    quizType: 0,
    text: '{"effectiveFormat":{"textFormat":{"bold":true}},"formattedValue":"A: Did I? I\'m so sorry."}',
    hint: '그랬나요? 정말 죄송합니다.',
  );

  Future<Box?> openBoxWithPreload() async {
    if (await Hive.boxExists(wordBox)) {
      print("openBoxWithPreload(). word box exists. do nothing");
      Box box = await Hive.openBox(wordBox);
      return box;
    } else {
      print("openBoxWithPreload(). First time openBox for word box");
      Box box = await Hive.openBox(wordBox);
      for (Word word in _fakeWords) {
        box.add(word);
      }
      return box;
    }
  }

  Future<void> updateWords(int subjectKey, Iterable<Word> words) async {
    Box box = Hive.box(wordBox);

    // Remove previous words
    final Map<dynamic, dynamic> wordMap = box.toMap();
    List<dynamic> desiredKeys = [];
    wordMap.forEach((key, value) {
      if (value.subjectKey == subjectKey) {
        desiredKeys.add(key);
      }
    });
    box.deleteAll(desiredKeys);

    box.addAll(words);
  }

  List<Word> getWords() {
    return _fakeWords;
  }
}
