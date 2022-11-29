import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvvm_plus/mvvm_plus.dart';

import '../../models/chapter.dart';
import '../../models/word.dart';
import '../../repositories/lecture_repository.dart';

class LectureViewModel extends ViewModel {
  final Chapter chapter;
  late final words = createProperty<List<Word>>([]);

  late final _repository = LectureRepository();

  LectureViewModel({required this.chapter});

  @override
  Future<void> initState() async {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: 'loading...');

    super.initState();
    words.value = await _repository.getWordsBySubjectAndChapter(chapter.subjectKey, chapter.nameForKey);

    EasyLoading.dismiss();
  }

  @override
  void dispose() {
    // TODO: Update lastStudyDate of the chapter
    // Future<void> updateStudyDate(Chapter chapter) async {
    //   chapter.lastStudyDate = DateTime.now();
    //   await ChapterRepository().updateChapter(chapter);
    // }
    super.dispose();
  }
}