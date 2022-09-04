import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../googlesheet/sheet_helper.dart';
import '../models/chapter.dart';
import '../models/word.dart';
import '../repositories/lecture_repository.dart';

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
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.nameForId),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
        _box!.values.where((word) => (word.sheetId == widget.chapter.sheetId) && (word.chapterNameForId == widget.chapter.nameForId)).toList();
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SheetHelper.getRichText(word.text),
      )
    ];
    if (word.hint != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(word.hint!, style: const TextStyle(fontStyle: FontStyle.italic)),
        ),
      );
    }
    if (word.note != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(word.note!, style: const TextStyle(fontSize: 12)),
        ),
      );
    }
    if (word.memo != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(word.memo!, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
        ),
      );
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4), //const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        Text(word.order.toString(), style: const TextStyle(fontSize: 12, fontFeatures: [FontFeature.superscripts()])),
      ],
    );
  }
}
