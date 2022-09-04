import 'package:hive_flutter/hive_flutter.dart';

part 'chapter.g.dart';

@HiveType(typeId: 2)
class Chapter {
  @HiveField(0)
  int key;

  @HiveField(1)
  int subjectKey;

  @HiveField(2)
  String nameForId;

  @HiveField(3)
  String title;

  @HiveField(4)
  String? category;

  @HiveField(5)
  String? remoteUrl;

  @HiveField(6)
  String? localUrl;

  @HiveField(7)
  String? link1;

  @HiveField(8)
  String? link2;

  @HiveField(9)
  DateTime lastStudyDate;

  @HiveField(10)
  int studyPoint;

  @HiveField(11)
  int quizCount;

  Chapter({
    required this.key,
    required this.subjectKey,
    required this.nameForId,
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
      key: chapter["key"],
      subjectKey: chapter["subjectKey"],
      nameForId: chapter["nameForId"],
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
      "key": key,
      "subjectKey": subjectKey,
      "nameForId": nameForId,
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
}
