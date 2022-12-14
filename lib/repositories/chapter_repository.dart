import 'package:hive_flutter/hive_flutter.dart';

import '../models/chapter.dart';

class ChapterRepository {
  static const String chapterBox = 'chapter';

  final List<Chapter> _fakeChapters = [
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-09",
      title: "616강 모바일 교통",
      category: "Mobile Services (2)",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210809_063000_243250eb_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-10",
      title: "617강 모바일 학습",
      category: "Mobile Services (2)",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210810_063000_73e2e3a9_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-11",
      title: "618강 모바일 음원/영상",
      category: "Mobile Services (2)",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210811_063000_1b8c893e_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-12",
      title: "619강 모바일 지도/네비게이션",
      category: "Mobile Services (2)",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210812_063000_11250f4b_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-13",
      title: "620강 모바일 게임",
      category: "Mobile Services (2)",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210813_063000_c87fbd1c_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-16",
      title: "621강 휴대폰 주변기기",
      category: "Cell Phones",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210816_063000_bd5b1263_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-17",
      title: "622강 휴대폰 케이스",
      category: "Cell Phones",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210817_063000_423c046a_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-18",
      title: "623강 휴대폰 배터리",
      category: "Cell Phones",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210818_063000_af7ce770_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-19",
      title: "624강 휴대폰 고장",
      category: "Cell Phones",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210819_063000_b166cbc6_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 0,
      nameForKey: "2021-08-20",
      title: "625강 휴대폰 분실",
      category: "Cell Phones",
      remoteUrl: "https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210820_063000_31436ce8_m10.mp4",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 3,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 01 a",
      title: "1. I'm",
      category: "Day 1",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1sYqITi1gLCpeqDiLlwOELyGA0xQIeq1l",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 01 b",
      title: "1. I'm sorry to disturb you.",
      category: "Day 1",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1KoXZTIsHDvswOrvqkp3zO77IqKr35J5_",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 02 a",
      title: "2. It's",
      category: "Day 2",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1RWTqAibsLgBRmdNhb2CqtNgW1tZKNB5t",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 02 b",
      title: "2. It's nice to meet you.",
      category: "Day 2",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1CNmP0riHfbbZCs3i8SlDNk2SicFCA9M7",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 03 a",
      title: "3. Do you",
      category: "Day 3",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1Feoa4LKwqK27xFZNQqPBHrRqb2ZZYXRL",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 03 b",
      title: "3. Do you have a minute?",
      category: "Day 3",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1bSasGD5JFwYkF8-1hGCRQUqOgmtHY7ty",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 04 a",
      title: "4. I'll",
      category: "Day 4",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1DQuNT2b_qXmuLIGg-oNAcNYbo0XStS6H",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 04 b",
      title: "4. I'll take two pieces",
      category: "Day 4",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1weAAJeM17KzyAY5tAohSP8SlWIC8fPlb",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 05 a",
      title: "5. That's",
      category: "Day 5",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1FxG1F0lBR8zkMfeLDpmF0LoNfQpTy5Me",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
    Chapter(
      subjectKey: 1,
      nameForKey: "DAY 05 temp",
      title: "5. That's",
      category: "Day 5",
      remoteUrl: "https://docs.google.com/uc?export=open&id=1FxG1F0lBR8zkMfeLDpmF0LoNfQpTy5Me",
      localUrl: null,
      link1: null,
      link2: null,
      lastStudyDate: DateTime.fromMillisecondsSinceEpoch(0),
      studyPoint: 0,
      quizCount: 0,
    ),
  ];

  Future<Box?> openBoxWithPreload() async {
    if (await Hive.boxExists(chapterBox)) {
      print("openBoxWithPreload().chapter box exists. do nothing");
      Box box = await Hive.openBox(chapterBox);
      return box;
    } else {
      print("openBoxWithPreload(). First time openBox for chapter box");
      Box box = await Hive.openBox(chapterBox);
      for (Chapter chapter in _fakeChapters) {
        box.add(chapter);
        print('- add chapter - nameForId: ${chapter.nameForKey}, title: ${chapter.title}');
      }
      return box;
    }
  }

  Future<Map<String, Chapter>> getChaptersBySubjectKey(int subjectKey) async {
    Box box = Hive.box(chapterBox);
    Iterable chapters = box.values.where((chapter) => chapter.subjectKey == subjectKey);
    Map<String, Chapter> retMap = {};
    for (Chapter chapter in chapters) {
      retMap[chapter.nameForKey] = chapter;
    }
    return retMap;
  }

  Map<String, Chapter> getFakeChaptersBySubjectKey(int subjectKey) {
    Iterable chapters = _fakeChapters.where((chapter) => chapter.subjectKey == subjectKey);
    Map<String, Chapter> retMap = {};
    for (Chapter chapter in chapters) {
      retMap[chapter.nameForKey] = chapter;
    }
    return retMap;
  }

  Future<void> updateChapters(int subjectKey, Iterable<Chapter> chapters) async {
    Box box = Hive.box(chapterBox);

    // Remove previous chapters
    final Map<dynamic, dynamic> chapterMap = box.toMap();
    List<dynamic> desiredKeys = [];
    chapterMap.forEach((key, value) {
      if (value.subjectKey == subjectKey) {
        desiredKeys.add(key);
      }
    });
    box.deleteAll(desiredKeys);

    box.addAll(chapters);
  }

  Future<void> updateChapter(Chapter chapter) async {
    Box box = Hive.box(chapterBox);
    for (var key in box.keys) {
      var curChapter = box.get(key);
      if (chapter.nameForKey == curChapter.nameForKey && chapter.subjectKey == curChapter.subjectKey) {
        print("Update $chapter");
        box.put(key, chapter);
        return;
      }
    }
    print("updateChapter(). !!!! failed to update $chapter");
  }

  Future<List<Chapter>> getChapterListBySubjectKey(int subjectKey) async {
    Box box = (await openBoxWithPreload())!;
    List chapters = box.values.where((chapter) => chapter.subjectKey == subjectKey).toList();
    List<Chapter> retList = List.from(chapters);
    retList.sort((b, a) => a.nameForKey.compareTo(b.nameForKey)); // DESC
    return retList;
  }

  List<Chapter> getChapters() {
    return _fakeChapters;
  }
}
