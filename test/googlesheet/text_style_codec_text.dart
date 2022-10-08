import 'dart:convert';

import 'package:ellas_notes_flutter/googlesheet/text_style_codec.dart';
import 'package:ellas_notes_flutter/models/word.dart';
import 'package:ellas_notes_flutter/repositories/lecture_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/sheets/v4.dart';

void main() {
  test('getStyleCodeList() test', ()  {
    Word word = LectureRepository().fakeWordSample;
    CellData cellData = CellData.fromJson(jsonDecode(word.text));
    var ret = TextStyleCodec.getStyleCodeList(cellData);
    print(ret);
  });
}