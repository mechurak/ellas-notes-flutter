import '../models/word.dart';

class LectureRepository {
  final List<Word> _fakeWords = [
    Word(
      subjectId: 0,
      chapterNameForId: "2021-05-12",
      order: 1,
      quizType: 0,
      text: "test spelling 1",
      hint: "hint text 1",
      note: "note text 1",
      memo: "memo text 1",
    ),
    Word(
      subjectId: 0,
      chapterNameForId: "2021-05-12",
      order: 2,
      quizType: 0,
      text: "test spelling 2",
      hint: "hint text 2",
      note: "note text 2",
      memo: "memo text 2",
    ),
    Word(
      subjectId: 0,
      chapterNameForId: "2021-05-12",
      order: 3,
      quizType: 0,
      text: "test spelling 3",
      hint: "hint text 3",
      note: "note text 3",
      memo: "memo text 3",
    ),
  ];

  List<Word> getWords() {
    return _fakeWords + _fakeWords + _fakeWords;
  }
}
