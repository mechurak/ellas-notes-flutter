import 'package:hive/hive.dart';

import '../models/subject.dart';

class SubjectRepository {
  static const String subjectBox = 'subject';

  final List<Subject> _initialSubjects = [
    Subject(
      subjectId: 1,
      title: "정면돌파 스피킹 template",
      sheetId: "1veQzV0fyYHO_4Lu2l33ZRXbjy47_q8EI1nwVAQXJcVQ",
      lastUpdate: DateTime.now(),
      description: "하루에 한 표현씩 Speed 실전 스피킹!",
      link: "https://home.ebse.co.kr/10mins_lee2/main",
      imageUrl: "https://static.ebs.co.kr/images/public/courses/2021/02/19/20/ER2017H0SPE01ZZ/8f8797ce-8085-4a0f-9681-4df159c3de17.jpg",
    ),
    Subject(
      subjectId: 2,
      title: "강성태 66일 영어회화",
      sheetId: "1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE",
      lastUpdate: DateTime.now(),
      description: "당신의 영어가 습관이 되게에 충분한 시간",
      link: "https://gongsin.com/courses/intro/c/show?cate=%EC%98%81%EC%96%B4%ED%9A%8C%ED%99%94",
      imageUrl: "https://image.kyobobook.co.kr/images/book/xlarge/006/x9791130679006.jpg",
    ),
    Subject(
      subjectId: 3,
      title: "귀트영 template",
      sheetId: "1FaIhdmMIa77CoZCkhVly1rPrSdRs6Fg3ZIR5ofGu7hw",
      lastUpdate: DateTime.now(),
      description: "이현석&안젤라와 함께하는 대한민국 대표 영어 리스닝 프로그램",
      link: "https://home.ebs.co.kr/listene/main",
      imageUrl: "https://image.kyobobook.co.kr/images/book/xlarge/697/x3904000048697.jpg",
    ),
  ];

  Future<Box?> openBoxWithPreload() async {
    if (await Hive.boxExists(subjectBox)) {
      print("openBoxWithPreload().subject box exists. do nothing");
      Box box = await Hive.openBox(subjectBox);
      return box;
    } else {
      print("openBoxWithPreload(). First time openBox");
      Box box = await Hive.openBox(subjectBox);
      // final Box box = Hive.box(subjectBox);
      for (Subject subject in _initialSubjects) {
        box.put(subject.sheetId, subject);
      }
      return box;
    }
  }

  List<Subject> getSubjects() {
    return _initialSubjects + _initialSubjects + _initialSubjects;
  }
}
