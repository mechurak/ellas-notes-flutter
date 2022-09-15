import 'package:hive_flutter/hive_flutter.dart';

part 'chapter.g.dart';

@HiveType(typeId: 2)
class Chapter {
  @HiveField(0)
  int subjectKey;

  @HiveField(1)
  String nameForKey;

  @HiveField(2)
  String title;

  @HiveField(3)
  String? category;

  @HiveField(4)
  String? remoteUrl;

  @HiveField(5)
  String? localUrl;

  @HiveField(6)
  String? link1;

  @HiveField(7)
  String? link2;

  @HiveField(8)
  DateTime lastStudyDate;

  @HiveField(9)
  int studyPoint;

  @HiveField(10)
  int quizCount;

  Chapter({
    required this.subjectKey,
    required this.nameForKey,
    required this.title,
    required this.category,
    required this.remoteUrl,
    required this.localUrl,
    required this.link1,
    required this.link2,
    required this.lastStudyDate,
    required this.studyPoint,
    required this.quizCount,
  });

  factory Chapter.fromMap(Map chapter) {
    return Chapter(
      subjectKey: chapter["subjectKey"],
      nameForKey: chapter["nameForKey"],
      title: chapter["title"],
      category: chapter["category"],
      remoteUrl: chapter["remoteUrl"],
      localUrl: chapter["localUrl"],
      link1: chapter["link1"],
      link2: chapter["link2"],
      lastStudyDate: chapter["lastStudyDate"],
      studyPoint: chapter["studyPoint"],
      quizCount: chapter["quizCount"],
    );
  }

  Map toMap() {
    return {
      "subjectKey": subjectKey,
      "nameForKey": nameForKey,
      "title": title,
      "category": category,
      "remoteUrl": remoteUrl,
      "localUrl": localUrl,
      "link1": link1,
      "link2": link2,
      "lastStudyDate": lastStudyDate,
      "studyPoint": studyPoint,
      "quizCount": quizCount,
    };
  }

  @override
  String toString() {
    return 'Chapter{subjectKey: $subjectKey, nameForKey: $nameForKey, title: $title}';
  }
}
