import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';

import '../googlesheet/text_style_codec.dart';

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
    List<int> codes = TextStyleCodec.getStyleCodeList(cellData);

    // Annotate Hide section and remove HIDE mask
    Map<int, int> hideSectionMap = {}; // <startIndex, endIndex>
    int prevHideStart = -1;
    for (int i = 0; i < codes.length; i++) {
      if (codes[i] & TextStyleCodec.codeHide == TextStyleCodec.codeHide) {
        if (prevHideStart == -1) {
          prevHideStart = i;
        }
        codes[i] -= TextStyleCodec.codeHide;
      } else {
        if (prevHideStart != -1) {
          hideSectionMap[prevHideStart] = i;
          prevHideStart = -1;
        }
      }
    }
    if (prevHideStart != -1) {
      hideSectionMap[prevHideStart] = codes.length;
    }

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

    int start = 0;
    int end = 0;
    while (end < tempStr.length) {
      bool shouldHide = hideSectionMap.containsKey(start) && !_clickedStartIndices.contains(start);
      if (shouldHide) {
        end = hideSectionMap[start]!;
        var text = tempStr.substring(start, end);
        var bgColor = Colors.blue;
        var color = Colors.blue;
        TapGestureRecognizer? tapRecognizer;
        tapRecognizer = TapGestureRecognizer();
        int startIndex = start;
        tapRecognizer.onTap = () {
          setState(() {
            if (_clickedStartIndices.contains(startIndex)) {
              _clickedStartIndices.remove(startIndex);
            } else {
              _clickedStartIndices.add(startIndex);
            }
          });
        };
        children.add(
          TextSpan(
            text: text,
            style: TextStyle(
              color: color,
              backgroundColor: bgColor,
            ),
            recognizer: tapRecognizer,
          ),
        );
        start = end;
      } else {
        while (end < tempStr.length && codes[start] == codes[end]) {
          if (hideSectionMap.containsKey(end) && !_clickedStartIndices.contains(end)) break;
          end++;
        }

        var text = tempStr.substring(start, end);
        var bgColor = codes[start] & TextStyleCodec.codeAccent == TextStyleCodec.codeAccent ? Colors.yellow : null;
        var color = codes[start] & TextStyleCodec.codeImportant == TextStyleCodec.codeImportant ? Colors.purple : Colors.black;
        if (codes[start] & TextStyleCodec.codeSpeaker == TextStyleCodec.codeSpeaker) {
          color = Colors.orange;
        }

        children.add(
          TextSpan(
            text: text,
            style: TextStyle(
              color: color,
              backgroundColor: bgColor,
            ),
          ),
        );
        start = end;
      }
    }

    return RichText(
      text: TextSpan(
        text: '',
        children: children,
      ),
    );
  }
}
