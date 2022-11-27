import 'package:ellas_notes_flutter/repositories/chapter_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvvm_plus/mvvm_plus.dart';

import '../../googlesheet/sheet_helper.dart';
import '../../models/chapter.dart';
import '../../models/subject.dart';

class ChapterViewModel extends ViewModel {
  final Subject subject;
  late final chapters = createProperty<List<Chapter>>([]);

  late final _repository = ChapterRepository();

  ChapterViewModel({required this.subject});

  @override
  Future<void> initState() async {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: 'loading...');

    super.initState();
    chapters.value = await _repository.getChapterListBySubjectKey(subject.key);

    EasyLoading.dismiss();
  }

  Future<void> refreshCurrentSubject() async {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: 'loading...');

    await SheetHelper.fetchSpreadsheet(subject.sheetId, subject.isPrivate);
    chapters.value = await _repository.getChapterListBySubjectKey(subject.key);

    EasyLoading.dismiss();
  }
}
