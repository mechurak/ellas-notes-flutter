import 'dart:convert';

import 'package:ellas_notes_flutter/googlesheet/index_holder.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';

import '../models/word.dart';

class SheetHelper {
  static Word getWord(IndexHolder idx, List<CellData> cells, int subjectId) {
    String? hint = (idx.hint > 0 && cells.length > idx.hint) ? cells[idx.hint].formattedValue : null;
    String? note = (idx.note > 0 && cells.length > idx.note) ? cells[idx.note].formattedValue : null;
    String? memo = (idx.memo > 0 && cells.length > idx.memo) ? cells[idx.memo].formattedValue : null;
    String? quizTemp = (idx.quiz > 0 && cells.length > idx.quiz) ? cells[idx.quiz].formattedValue : null;
    int quiz = (quizTemp != null) ? int.parse(quizTemp) : 0;

    return Word(
      subjectId: subjectId,
      chapterNameForId: cells[idx.nameForId].formattedValue!,
      order: int.parse(cells[idx.order].formattedValue!),
      quizType: quiz,
      text: jsonEncode(cells[idx.text]),
      // jsonEncode : https://docs.flutter.dev/development/data-and-backend/json
      hint: hint,
      note: note,
      memo: memo,
    );
  }

  static RichText getRichText(String text) {
    CellData cellData = CellData.fromJson(jsonDecode(text));

    String tempStr = cellData.formattedValue!;
    List<TextSpan> children = [];

    if (cellData.textFormatRuns != null) {
      TextFormatRun curItem = cellData.textFormatRuns![0];
      curItem.startIndex = 0;

      for (int i = 1; i < cellData.textFormatRuns!.length; i++) {
        TextFormatRun nextItem = cellData.textFormatRuns![i];

        int prevEndIndex = nextItem.startIndex!;

        var bgColor = curItem.format?.underline == true ? Colors.yellow : null;
        var color = curItem.format?.italic == true ? Colors.purple : Colors.black;

        TextSpan span = TextSpan(
          text: tempStr.substring(curItem.startIndex!, prevEndIndex),
          style: TextStyle(
            color: color,
            backgroundColor: bgColor,
          ),
        );
        children.add(span);
        curItem = nextItem;
      }

      // last item
      var bgColor = curItem.format?.underline == true ? Colors.yellow : null;
      var color = curItem.format?.italic == true ? Colors.purple : null;
      TextSpan span = TextSpan(
        text: tempStr.substring(curItem.startIndex!),
        style: TextStyle(
          color: color,
          backgroundColor: bgColor,
        ),
      );
      children.add(span);
    } else {
      TextSpan span = TextSpan(
        text: tempStr,
        style: const TextStyle(
          color: Colors.black,
        ),
      );
      children.add(span);
    }

    return RichText(
      text: TextSpan(
        text: '',
        children: children,
      ),
    );
  }
}
