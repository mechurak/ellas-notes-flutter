import 'package:flutter/material.dart';

import '../models/chapter.dart';
import '../repositories/chapter_repository.dart';
import 'lecture_page.dart';

class ChapterPage extends StatefulWidget {
  final String subject;

  const ChapterPage({Key? key, required this.subject}) : super(key: key);

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
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
                  _chapterList(),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _chapterList() {
    List chapters = ChapterRepository().getChapters();
    return Expanded(
      child: ListView.separated(
        itemCount: chapters.length,
        itemBuilder: (BuildContext context, int index) {
          return _chapterTile(chapters[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _chapterTile(Chapter chapter) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return LecturePage(
                subjectId: chapter.subjectId,
                chapterNameForId: chapter.nameForId,
              );
            },
          ),
        );
      },
      title: Text(chapter.title),
      subtitle: Text(chapter.lastStudyDate.toString()),
    );
  }
}
