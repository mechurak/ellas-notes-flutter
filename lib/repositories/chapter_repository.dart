import '../models/chapter.dart';

class ChapterRepository {
  final List<Chapter> _fakeChapters = [
    Chapter(
      subjectId: 1,
      nameForId: "2021-05-12",
      title: "발음 강세 Unit 553. 체중",
      category: "Maintaining Our Health",
      remoteUrl:
          "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210512_063000_6b6f5fd4_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.now(),
      studyPoint: 90,
      quizCount: 2,
    ),
    Chapter(
      subjectId: 1,
      nameForId: "2021-05-13",
      title: "발음 강세 Unit 554. 운동",
      category: "Maintaining Our Health",
      remoteUrl:
          "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210513_063000_26343de3_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.now(),
      studyPoint: 92,
      quizCount: 3,
    )
  ];

  List<Chapter> getChapters() {
    return _fakeChapters + _fakeChapters + _fakeChapters;
  }
}
