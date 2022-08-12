import 'package:flutter/material.dart';

import '../models/word.dart';
import '../repositories/lecture_repository.dart';

class LecturePage extends StatefulWidget {
  final int subjectId;
  final String chapterNameForId;

  const LecturePage(
      {Key? key, required this.subjectId, required this.chapterNameForId})
      : super(key: key);

  @override
  State<LecturePage> createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapterNameForId),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _wordList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _wordList() {
    List words = LectureRepository().getWords();
    return Expanded(
      child: ListView.separated(
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return _wordTile(words[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _wordTile(Word word) {
    return ListTile(
      onTap: () {},
      title: Text(word.text),
      subtitle: word.note != null ? Text(word.note!) : null,
    );
  }
}
