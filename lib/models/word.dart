class Word {
  int subjectId;
  String chapterNameForId;
  int order;
  int quizType;

  String text;
  String? hint;
  String? note;
  String? memo;
  String? link;

  Word({
    required this.subjectId,
    required this.chapterNameForId,
    required this.order,
    required this.quizType,
    required this.text,
    this.hint,
    this.note,
    this.memo,
    this.link,
  });
}
