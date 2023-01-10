import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:mvvm_plus/mvvm_plus.dart';

import '../../googlesheet/drive_helper.dart';
import '../../googlesheet/sheet_helper.dart';
import '../../models/subject.dart';
import '../../repositories/subject_repository.dart';

class HomeViewModel extends ViewModel {
  late final subjects = createProperty<List<Subject>>([]);
  late final isLoading = createProperty<bool>(true);

  late final _repository = SubjectRepository();
  late final DriveHelper _driveHelper;

  @override
  Future<void> initState() async {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: 'loading...');

    super.initState();
    _driveHelper = GetIt.instance.get<DriveHelper>();
    subjects.value = await _repository.getSubjectList();

    EasyLoading.dismiss();
  }

  Future<void> addSubject(String sheetId) async {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: 'loading...');
    await SheetHelper.fetchSpreadsheet(sheetId, false);

    Navigator.pop(context);

    EasyLoading.dismiss();
  }

  Future<void> refresh() async {
    subjects.value = await _repository.getSubjectList();
  }

  Future<void> googleSignIn() async {
    await _driveHelper.signIn();
  }
}