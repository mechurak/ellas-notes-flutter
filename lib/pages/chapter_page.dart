import 'package:ellas_notes_flutter/repositories/chapter_repository.dart';
import 'package:flutter/material.dart';

import '../models/chapter.dart';

class ChapterPage extends StatelessWidget {
  final String subject;
  late double _deviceHeight, _deviceWidth;

  ChapterPage({required this.subject});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
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
      onTap: () {},
      title: Text(chapter.title),
      subtitle: Text(chapter.lastStudyDate.toString()),
    );
  }
}
