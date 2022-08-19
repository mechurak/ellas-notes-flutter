import 'package:hive_flutter/hive_flutter.dart';

part 'subject.g.dart';

@HiveType(typeId: 1)
class Subject {
  @HiveField(0)
  int subjectId;

  @HiveField(1)
  String title;

  @HiveField(2)
  String sheetId;

  @HiveField(3)
  DateTime lastUpdate;

  @HiveField(4)
  String description;

  @HiveField(5)
  String link;

  @HiveField(6)
  String imageUrl;

  Subject({
    required this.subjectId,
    required this.title,
    required this.sheetId,
    required this.lastUpdate,
    required this.description,
    required this.link,
    required this.imageUrl,
  });

  factory Subject.fromMap(Map subject) {
    return Subject(
      subjectId: subject["subjectId"],
      title: subject["title"],
      sheetId: subject["sheetId"],
      lastUpdate: subject["lastUpdate"],
      description: subject["description"],
      link: subject["link"],
      imageUrl: subject["imageUrl"],
    );
  }

  Map toMap() {
    return {
      "subjectId": subjectId,
      "title": title,
      "sheetId": sheetId,
      "lastUpdate": lastUpdate,
      "description": description,
      "link": link,
      "imageUrl": imageUrl,
    };
  }
}
