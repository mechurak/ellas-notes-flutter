import 'package:flutter/material.dart';

import '../googlesheet/sheet_helper.dart';
import '../models/word.dart';
import '../repositories/lecture_repository.dart';
import '../theme/text_styles.dart';

class WordTile extends StatefulWidget {
  final Word word;

  const WordTile({Key? key, required this.word}) : super(key: key);

  @override
  State<WordTile> createState() => _WordTileState();
}

class _WordTileState extends State<WordTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SheetHelper.getRichText(widget.word.text),
              ),
              if (widget.word.hint != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(widget.word.hint!, style: TextStyles.hintTextStyle),
                ),
              if (widget.word.note != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(widget.word.note!, style: TextStyles.noteTextStyle),
                ),
              if (widget.word.memo != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(widget.word.memo!, style: TextStyles.memoTextStyle),
                )
            ],
          ),
        ),
        Text(widget.word.order.toString(), style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class WordTilePreviewApp extends StatelessWidget {
  const WordTilePreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    Word word = LectureRepository().getWords().last;

    return MaterialApp(
      title: "WordTile Preview",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WordTile Preview'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: WordTile(word: word),
        ),
      ),
    );
  }
}

void main() async {
  runApp(const WordTilePreviewApp());
}
