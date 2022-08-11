class Subject {
  String title;
  String sheetId;
  DateTime lastUpdate;
  String description;
  String link;
  String imageUrl;

  Subject({
    required this.title,
    required this.sheetId,
    required this.lastUpdate,
    required this.description,
    required this.link,
    required this.imageUrl,
  });

  factory Subject.fromMap(Map subject) {
    return Subject(
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
      "title": title,
      "sheetId": sheetId,
      "lastUpdate": lastUpdate,
      "description": description,
      "link": link,
      "imageUrl": imageUrl,
    };
  }
}
