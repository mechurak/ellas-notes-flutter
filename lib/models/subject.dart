import 'package:hive_flutter/hive_flutter.dart';

part 'subject.g.dart';

@HiveType(typeId: 1)
class Subject {
  @HiveField(0)
  int key;

  @HiveField(1)
  String sheetId;

  @HiveField(2)
  String title;

  @HiveField(3)
  DateTime lastUpdate;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? link;

  @HiveField(6)
  String? imageUrl;

  Subject({
    required this.key,
    required this.sheetId,
    required this.title,
    required this.lastUpdate,
    required this.description,
    required this.link,
    required this.imageUrl,
  });

  factory Subject.fromMap(Map subject) {
    return Subject(
      key: subject["key"],
      sheetId: subject["sheetId"],
      title: subject["title"],
      lastUpdate: subject["lastUpdate"],
      description: subject["description"],
      link: subject["link"],
      imageUrl: subject["imageUrl"],
    );
  }

  Map toMap() {
    return {
      "key": key,
      "sheetId": sheetId,
      "title": title,
      "lastUpdate": lastUpdate,
      "description": description,
      "link": link,
      "imageUrl": imageUrl,
    };
  }
}
