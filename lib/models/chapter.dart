class Chapter {
  int subjectId;
  String nameForId;
  String title;
  String? category;
  String? remoteUrl;
  String? localUrl;
  String? link1;
  String? link2;
  DateTime lastStudyDate;
  int studyPoint;
  int quizCount;

  Chapter({
    required this.subjectId,
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
      subjectId: chapter["subjectId"],
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
      "subjectId": subjectId,
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
