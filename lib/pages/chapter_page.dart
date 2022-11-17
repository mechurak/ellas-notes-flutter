import 'dart:async';

import 'package:ellas_notes_flutter/googlesheet/sheet_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/chapter.dart';
import '../models/subject.dart';
import '../repositories/chapter_repository.dart';
import '../utils/date_util.dart';
import 'lecture_page.dart';

class ChapterPage extends StatefulWidget {
  final Subject subject;

  const ChapterPage({Key? key, required this.subject}) : super(key: key);

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late double _deviceHeight, _deviceWidth;
  List<Chapter>? chapters;

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              EasyLoading.instance.maskType = EasyLoadingMaskType.black;
              EasyLoading.show(status: 'loading...');
              await SheetHelper.fetchSpreadsheet(widget.subject.sheetId, widget.subject.isPrivate);
              setState(() {});
              EasyLoading.dismiss();
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _chapterView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chapterView() {
    return FutureBuilder(
      future: ChapterRepository().getChapterListBySubjectKey(widget.subject.key),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data;
          return _chapterList();
        } else {
          return SizedBox(
            height: _deviceHeight,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _chapterList() {
    if (chapters!.isEmpty) {
      return SizedBox(
        height: _deviceHeight * 0.8,
        child: const Center(
          child: Text("No data! Please try to refresh."),
        ),
      );
    }

    Chapter recentChapter = chapters!.first;
    for (Chapter chapter in chapters!) {
      if (chapter.lastStudyDate.compareTo(recentChapter.lastStudyDate) == 1) {
        recentChapter = chapter;
      }
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      // limit height
      primary: false,
      // disable scrolling
      itemCount: chapters!.length,
      itemBuilder: (BuildContext context, int index) {
        return _chapterTile(chapters![index], chapters![index] == recentChapter);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  Widget _chapterTile(Chapter chapter, bool isFocused) {
    String lastStudy = DateUtil.getLastStudyDateStr(chapter.lastStudyDate);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return LecturePage(
                chapter: chapter,
              );
            },
          ),
        ).then(onGoBack);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(chapter.nameForKey),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    lastStudy,
                    style: isFocused ? const TextStyle(color: Colors.red, fontStyle: FontStyle.italic) : null,
                  ),
                ),
              ],
            ),
            Text(chapter.title, style: const TextStyle(fontSize: 16)),
            chapter.category != null ? Text(chapter.category!) : const Text(''),
          ],
        ),
      ),
    );
  }
}
