import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;

  List? questions;
  int _currentQuestionCount = 0;

  BuildContext context;

  GamePageProvider({required this.context}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    var response = await _dio.get(
      "",
      queryParameters: {
        "amount": 10,
        "type": "boolean",
        "difficulty": "easy",
      },
    );
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }
}
