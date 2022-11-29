import 'package:flutter/material.dart';
import 'package:mvvm_plus/mvvm_plus.dart';

import '../../models/chapter.dart';
import '../../widgets/my_player.dart';
import '../../widgets/word_tile.dart';
import 'lecture_viewmodel.dart';

class LecturePage extends View<LectureViewModel> {
  final Chapter chapter;

  LecturePage({Key? key, required this.chapter}) : super(key: key, builder: () => LectureViewModel(chapter: chapter));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.nameForKey),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              chapter.remoteUrl != null ? MyPlayer(url: chapter.remoteUrl!) : const Text('no media'),
              _wordView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wordView() {
    double deviceHeight = MediaQuery.of(context).size.height;

    if (viewModel.words.value.isEmpty) {
      return SizedBox(
        height: deviceHeight * 0.8,
        child: const Center(
          child: Text("No data! Please try to refresh."),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: viewModel.words.value.length,
        itemBuilder: (BuildContext context, int index) {
          return WordTile(word: viewModel.words.value[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}