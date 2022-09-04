import 'package:hive_flutter/hive_flutter.dart';

part 'subject.g.dart';

@HiveType(typeId: 1)
class Subject {
  @HiveField(0)
  String sheetId;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime lastUpdate;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? link;

  @HiveField(5)
  String? imageUrl;

  Subject({
    required this.sheetId,
    required this.title,
    required this.lastUpdate,
    required this.description,
    required this.link,
    required this.imageUrl,
  });

  factory Subject.fromMap(Map subject) {
    return Subject(
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
      "sheetId": sheetId,
      "title": title,
      "lastUpdate": lastUpdate,
      "description": description,
      "link": link,
      "imageUrl": imageUrl,
    };
  }
}
