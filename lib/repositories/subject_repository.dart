import 'package:hive/hive.dart';

import '../models/subject.dart';

class SubjectRepository {
  static const String subjectBox = 'subject';

  final List<Subject> _initialSubjects = [
    Subject(
      key: 0,
      sheetId: "1veQzV0fyYHO_4Lu2l33ZRXbjy47_q8EI1nwVAQXJcVQ",
      title: "정면돌파 스피킹 template",
      isPrivate: false,
      lastUpdate: DateTime.now(),
      description: "하루에 한 표현씩 Speed 실전 스피킹!",
      link: "https://home.ebse.co.kr/10mins_lee2/main",
      imageUrl: "https://static.ebs.co.kr/images/public/courses/2021/02/19/20/ER2017H0SPE01ZZ/8f8797ce-8085-4a0f-9681-4df159c3de17.jpg",
    ),
    Subject(
      key: 1,
      sheetId: "1YA_EvZm_bLULp80tz0wJoM94K-YUa9jJ0BtBpQ6J7sE",
      title: "강성태 66일 영어회화",
      isPrivate: false,
      lastUpdate: DateTime.now(),
      description: "당신의 영어가 습관이 되게에 충분한 시간",
      link: "https://gongsin.com/courses/intro/c/show?cate=%EC%98%81%EC%96%B4%ED%9A%8C%ED%99%94",
      imageUrl: "https://image.kyobobook.co.kr/images/book/xlarge/006/x9791130679006.jpg",
    ),
    Subject(
      key: 2,
      sheetId: "1FaIhdmMIa77CoZCkhVly1rPrSdRs6Fg3ZIR5ofGu7hw",
      title: "귀트영 template",
      isPrivate: false,
      lastUpdate: DateTime.now(),
      description: "이현석&안젤라와 함께하는 대한민국 대표 영어 리스닝 프로그램",
      link: "https://home.ebs.co.kr/listene/main",
      imageUrl: "https://image.kyobobook.co.kr/images/book/xlarge/697/x3904000048697.jpg",
    ),
    Subject(
      key: 3,
      sheetId: "11BUANox4QzWGo0ZAzgUg1BeZ6JKISp1CunHJyBJQrsU",
      title: "강성태 영단어 어원편",
      isPrivate: false,
      lastUpdate: DateTime.now(),
      description: "암기하지 않아도 암기되는 공신들의 영단어 공부 비법",
      link: "https://gongsin.com/courses/intro/w/show?cate=%EC%98%81%EB%8B%A8%EC%96%B4",
      imageUrl: "https://image.kyobobook.co.kr/images/book/xlarge/884/x9788974572884.jpg",
    ),
    Subject(
      key: 4,
      sheetId: "1mh1Kr6fav5c719bJrSA0-nlkVLZeBOKxzDYMzhh5LRg",
      title: "딱 이만큼 영어회화",
      isPrivate: false,
      lastUpdate: DateTime.now(),
      description: "딱 3개월 만에 영어 프리토킹! 딱 이만큼 영어회화, 딱영어",
      link: "https://class101.net/plus/ko/products/5f3ddef9e6c171001dc3d074",
      imageUrl: "https://image.kyobobook.co.kr/images/book/xlarge/141/x9791130631141.jpg",
    ),
  ];

  Future<Box?> openBoxWithPreload() async {
    if (await Hive.boxExists(subjectBox)) {
      print("openBoxWithPreload().subject box exists. do nothing");
      Box box = await Hive.openBox(subjectBox);
      return box;
    } else {
      print("openBoxWithPreload(). First time openBox for subject box");
      Box box = await Hive.openBox(subjectBox);
      for (Subject subject in _initialSubjects) {
        int key = await box.add(subject);
        subject.key = key;
        box.put(key, subject);
        print('- add key: $key, subject: ${subject.title}');
      }
      return box;
    }
  }

  Future<List<Subject>> getSubjectList() async {
    Box box = (await openBoxWithPreload())!;
    List subjects = box.values.toList();
    List<Subject> retList = List.from(subjects);
    return retList;
  }

  Future<void> updateSubject(Subject subject) async {
    Box box = Hive.box(subjectBox);
    if (subject.key == -1) {
      int key = await box.add(subject);
      subject.key = key;
      box.put(key, subject);
    } else {
      box.put(subject.key, subject);
    }
  }

  Future<Subject?> getSubjectBySheetId(String sheetId) async {
    Box box = Hive.box(subjectBox);
    Iterable<dynamic> subjects = box.values.where((subject) => subject.sheetId == sheetId);
    if (subjects.isNotEmpty) {
      // TODO: Check multiple case
      return subjects.first as Subject;
    }
    return null;
  }

  List<Subject> getSubjects() {
    return _initialSubjects + _initialSubjects + _initialSubjects;
  }
}
