import '../models/subject.dart';

class SubjectRepository {
  final List<Subject> _initialSubjects = [
    Subject(
      title : "정면돌파 스피킹 template",
      sheetId : "1veQzV0fyYHO_4Lu2l33ZRXbjy47_q8EI1nwVAQXJcVQ",
      lastUpdate : DateTime.now(),
      description : "하루에 한 표현씩 Speed 실전 스피킹!",
      link : "https://home.ebse.co.kr/10mins_lee2/main",
      imageUrl : "https://static.ebs.co.kr/images/public/courses/2021/02/19/20/ER2017H0SPE01ZZ/8f8797ce-8085-4a0f-9681-4df159c3de17.jpg",
    ),
    Subject(
        title : "입트영 60 (일상생활편) template",
        sheetId : "1GeK1Kz8GycGMYviq52sqV3-WKoI8Gw7llSOvJekp01s",
        lastUpdate : DateTime.now(),
        description : "영어가 더 유창해지는 <입이 트이는 영어> 베스트 컬렉션",
        link : "https://book.naver.com/bookdb/book_detail.nhn?bid:16744854",
        imageUrl : "https://image.kyobobook.co.kr/images/book/xlarge/937/x9788954753937.jpg"
    ),
    Subject(
        title : "귀트영 template",
        sheetId : "1FaIhdmMIa77CoZCkhVly1rPrSdRs6Fg3ZIR5ofGu7hw",
        lastUpdate : DateTime.now(),
        description : "이현석&안젤라와 함께하는 대한민국 대표 영어 리스닝 프로그램",
        link : "https://home.ebs.co.kr/listene/main",
        imageUrl : "https://image.kyobobook.co.kr/images/book/xlarge/697/x3904000048697.jpg"
    ),
  ];

  List<Subject> getSubjects() {
    return _initialSubjects + _initialSubjects + _initialSubjects;
  }
}