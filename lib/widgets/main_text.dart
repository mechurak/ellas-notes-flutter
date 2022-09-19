import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';

class MainText extends StatefulWidget {
  final String text;

  const MainText({Key? key, required this.text}) : super(key: key);

  @override
  State<MainText> createState() => _MainTextState();
}

class _MainTextState extends State<MainText> {
  final Set<int> _clickedStartIndices = {};

  @override
  Widget build(BuildContext context) {
    CellData cellData = CellData.fromJson(jsonDecode(widget.text));

    String tempStr = cellData.formattedValue!;
    List<TextSpan> children = [];

    if (tempStr.startsWith('##')) {
      TextSpan span = TextSpan(
        text: tempStr,
        style: const TextStyle(
          color: Colors.orange,
        ),
      );
      children.add(span);

      return RichText(
        text: TextSpan(
          text: '',
          children: children,
        ),
      );
    }

    if (cellData.textFormatRuns != null) {
      TextFormatRun curItem = cellData.textFormatRuns![0];
      curItem.startIndex = 0;

      for (int i = 1; i < cellData.textFormatRuns!.length; i++) {
        TextFormatRun nextItem = cellData.textFormatRuns![i];
        children.add(_getTextSpan(tempStr, curItem, nextItem));
        curItem = nextItem;
      }
      children.add(_getTextSpan(tempStr, curItem, null)); // last item
    } else {
      if (cellData.effectiveFormat?.textFormat?.bold == true) {
        children.add(_getWholeBoldSpan(tempStr));
      } else {
        TextSpan span = TextSpan(
          text: tempStr,
          style: const TextStyle(
            color: Colors.black,
          ),
        );
        children.add(span);
      }
    }

    return RichText(
      text: TextSpan(
        text: '',
        children: children,
      ),
    );
  }

  TextSpan _getTextSpan(String wholeText, TextFormatRun curItem, TextFormatRun? nextItem) {
    int? prevEndIndex = nextItem?.startIndex;
    var text = wholeText.substring(curItem.startIndex!, prevEndIndex);
    var bgColor = curItem.format?.underline == true ? Colors.yellow : null;
    var color = curItem.format?.italic == true ? Colors.purple : Colors.black;

    if (curItem.format?.bold == true) {
      if (!_clickedStartIndices.contains(curItem.startIndex!)) {
        bgColor = Colors.blue;
        color = Colors.blue;
      }
    }
    var tapRecognizer = TapGestureRecognizer();
    tapRecognizer.onTap = () {
      print('onTap $text');
      setState(() {
        if (_clickedStartIndices.contains(curItem.startIndex!)) {
          _clickedStartIndices.remove(curItem.startIndex!);
        } else {
          _clickedStartIndices.add(curItem.startIndex!);
        }
      });
    };
    var recognizer = curItem.format?.bold == true ? tapRecognizer : null;
    return TextSpan(
      text: wholeText.substring(curItem.startIndex!, prevEndIndex),
      style: TextStyle(
        color: color,
        backgroundColor: bgColor,
      ),
      recognizer: recognizer,
    );
  }

  TextSpan _getWholeBoldSpan(String text) {
    var bgColor;
    var color = Colors.black;
    if (!_clickedStartIndices.contains(0)) {
      bgColor = Colors.blue;
      color = Colors.blue;
    }
    var tapRecognizer = TapGestureRecognizer();
    tapRecognizer.onTap = () {
      print('onTap $text');
      setState(() {
        if (_clickedStartIndices.contains(0)) {
          _clickedStartIndices.remove(0);
        } else {
          _clickedStartIndices.add(0);
        }
      });
    };
    return TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        backgroundColor: bgColor,
      ),
      recognizer: tapRecognizer,
    );
  }
}
