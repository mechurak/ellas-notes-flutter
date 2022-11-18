import 'package:flutter/material.dart';

import '../models/word.dart';
import '../repositories/lecture_repository.dart';
import '../themes/custom_text_style.dart';
import 'main_text.dart';

class WordTile extends StatefulWidget {
  final Word word;

  const WordTile({Key? key, required this.word}) : super(key: key);

  @override
  State<WordTile> createState() => _WordTileState();
}

class _WordTileState extends State<WordTile> {
  @override
  Widget build(BuildContext context) {
    bool isFirstItem = (widget.word.order % 10) == 1;

    return Container(
      decoration: isFirstItem
          ? const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 16),
              ),
            )
          : null,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MainText(text: widget.word.text),
                ),
                if (widget.word.hint != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(widget.word.hint!, style: CustomTextStyle.hint(context)),
                  ),
                if (widget.word.note != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(widget.word.note!, style: CustomTextStyle.note(context)),
                  ),
                if (widget.word.memo != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(widget.word.memo!, style: CustomTextStyle.memo(context)),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(widget.word.order.toString(), style: const TextStyle(fontSize: 9)),
          ),
        ],
      ),
    );
  }
}

class WordTilePreviewApp extends StatelessWidget {
  const WordTilePreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Word word = LectureRepository().getWords().last;
    // Word word = LectureRepository().fakeWordWithBold;
    Word word = LectureRepository().fakeWordSample;

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
