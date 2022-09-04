import 'package:hive_flutter/hive_flutter.dart';

part 'word.g.dart';

@HiveType(typeId: 3)
class Word {
  @HiveField(0)
  String sheetId;

  @HiveField(1)
  String chapterNameForId;

  @HiveField(2)
  int order;

  @HiveField(3)
  int quizType;

  @HiveField(4)
  String text;

  @HiveField(5)
  String? hint;

  @HiveField(6)
  String? note;

  @HiveField(7)
  String? memo;

  @HiveField(8)
  String? link;

  Word({
    required this.sheetId,
    required this.chapterNameForId,
    required this.order,
    required this.quizType,
    required this.text,
    this.hint,
    this.note,
    this.memo,
    this.link,
  });

  @override
  String toString() {
    return 'Word{sheetId: $sheetId, chapterNameForId: $chapterNameForId, order: $order, quizType: $quizType, text: $text, hint: $hint, note: $note, memo: $memo, link: $link}';
  }
}
