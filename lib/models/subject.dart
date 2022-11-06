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
  bool isPrivate;

  @HiveField(4)
  DateTime lastUpdate;

  @HiveField(5)
  String? description;

  @HiveField(6)
  String? link;

  @HiveField(7)
  String? imageUrl;

  Subject({
    required this.key,
    required this.sheetId,
    required this.title,
    required this.isPrivate,
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
      isPrivate: subject["isPrivate"],
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
      "isPrivate": isPrivate,
      "lastUpdate": lastUpdate,
      "description": description,
      "link": link,
      "imageUrl": imageUrl,
    };
  }
}
