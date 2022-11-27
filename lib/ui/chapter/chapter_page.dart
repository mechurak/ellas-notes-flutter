import 'package:flutter/material.dart';
import 'package:mvvm_plus/mvvm_plus.dart';

import '../../models/chapter.dart';
import '../../models/subject.dart';
import '../../themes/custom_text_style.dart';
import '../../utils/date_util.dart';
import '../../pages/lecture_page.dart';
import 'chapter_viewmodel.dart';

class ChapterPage extends View<ChapterViewModel> {
  final Subject subject;
  late final double _deviceHeight, _deviceWidth;

  ChapterPage({Key? key, required this.subject}) : super(key: key, builder: () => ChapterViewModel(subject: subject));

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              viewModel.refreshCurrentSubject();
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
            primary: true,
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
    return _chapterList();
  }

  Widget _chapterList() {
    if (viewModel.chapters.value.isEmpty) {
      return SizedBox(
        height: _deviceHeight * 0.8,
        child: const Center(
          child: Text("No data! Please try to refresh."),
        ),
      );
    }

    Chapter recentChapter = viewModel.chapters.value.first;
    for (Chapter chapter in viewModel.chapters.value) {
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
      itemCount: viewModel.chapters.value.length,
      itemBuilder: (BuildContext context, int index) {
        return _chapterTile(viewModel.chapters.value[index], viewModel.chapters.value[index] == recentChapter);
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
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  chapter.nameForKey,
                  style: CustomTextStyle.nameForKey(context),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    lastStudy,
                    style: isFocused ? CustomTextStyle.lastStudyFocus(context) : CustomTextStyle.lastStudyNormal(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(chapter.title, style: Theme.of(context).textTheme.titleMedium),
            ),
            chapter.category != null ? Text(chapter.category!, style: CustomTextStyle.category(context)) : const Text(''),
          ],
        ),
      ),
    );
  }
}
