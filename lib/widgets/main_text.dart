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
  int _prevBoldStart = -1;
  int _prevUnderlineStart = -1;
  int _prevItalicStart = -1;
  int _prevStart = 0;

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
      TextSpan? curTextSpan;

      for (int i = 1; i < cellData.textFormatRuns!.length; i++) {
        TextFormatRun nextItem = cellData.textFormatRuns![i];
        curTextSpan = _getTextSpan(tempStr, curItem, nextItem);
        if (curTextSpan != null) {
          children.add(curTextSpan);
        }
        curItem = nextItem;
      }
      curTextSpan = _getTextSpan(tempStr, curItem, null); // last item
      if (curTextSpan != null) {
        children.add(curTextSpan);
      }
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

  TextSpan? _getTextSpan(String wholeText, TextFormatRun curItem, TextFormatRun? nextItem) {
    int? prevEndIndex = nextItem?.startIndex;
    var text = wholeText.substring(curItem.startIndex!, prevEndIndex);
    var bgColor = curItem.format?.underline == true ? Colors.yellow : null;
    var color = curItem.format?.italic == true ? Colors.purple : Colors.black;

    bool shouldBeNull = false;
    bool? hasBold = curItem.format?.bold;
    if (hasBold == true) {
      // 1. _ -> (B)
      // 2. B -> (B)
      if (_prevBoldStart == -1) {
        _prevBoldStart = curItem.startIndex!;
      }

      // 2. (B) -> B : null 리턴 해야 함
      // 3. (B) -> _ : 요번에 리턴 해야 함
      if (nextItem?.format?.bold == true) {
        shouldBeNull = true;
      }
    } else {
      _prevBoldStart = -1;
    }

    if (_prevBoldStart == -1 || _clickedStartIndices.contains(_prevBoldStart)) {
      return TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          backgroundColor: bgColor,
        ),
      );
    } else {
      // Hide
      if (shouldBeNull) {
        return null;
      } else {
        var tapRecognizer = TapGestureRecognizer();
        int startIndex = _prevBoldStart;
        tapRecognizer.onTap = () {
          print('onTap $startIndex');
          setState(() {
            if (_clickedStartIndices.contains(startIndex)) {
              _clickedStartIndices.remove(startIndex);
            } else {
              _clickedStartIndices.add(startIndex);
            }
          });
        };
        bgColor = Colors.blue;
        color = Colors.blue;
        return TextSpan(
          text: wholeText.substring(startIndex, prevEndIndex),
          style: TextStyle(
            color: color,
            backgroundColor: bgColor,
          ),
          recognizer: tapRecognizer,
        );
      }
    }
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
