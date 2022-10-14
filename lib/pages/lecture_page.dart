import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/chapter.dart';
import '../repositories/chapter_repository.dart';
import '../repositories/lecture_repository.dart';
import '../widgets/my_player.dart';
import '../widgets/word_tile.dart';

class LecturePage extends StatefulWidget {
  final Chapter chapter;

  const LecturePage({Key? key, required this.chapter}) : super(key: key);

  @override
  State<LecturePage> createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  late double _deviceHeight, _deviceWidth;
  Box? _box;

  @override
  void initState() {
    super.initState();
    updateStudyDate(widget.chapter);
  }

  Future<void> updateStudyDate(Chapter chapter) async {
    chapter.lastStudyDate = DateTime.now();
    await ChapterRepository().updateChapter(chapter);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.nameForKey),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.chapter.remoteUrl != null ? MyPlayer(url: widget.chapter.remoteUrl!) : const Text('no media'),
                _wordView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _wordView() {
    return FutureBuilder(
      future: LectureRepository().openBoxWithPreload(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          return _wordList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _wordList() {
    List words =
        _box!.values.where((word) => (word.subjectKey == widget.chapter.subjectKey) && (word.chapterKey == widget.chapter.nameForKey)).toList();
    return Expanded(
      child: ListView.separated(
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return WordTile(word: words[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
