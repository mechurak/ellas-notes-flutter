import 'package:googleapis/sheets/v4.dart';

class TextStyleCodec {
  static const codeHide = 1;  // bold
  static const codeAccent = 2;  // underline
  static const codeImportant = 4;  // italic
  static const codeSpace = 8;  // white space
  static const codeSymbol = 16;  // ?!.
  static const codeSpeaker = 32;  // "^.*: ", ex. "John: "


  static List<int> getStyleCodeList(CellData cellData) {
    String plainText = cellData.formattedValue!;

    int code = 0;
    if (cellData.effectiveFormat?.textFormat?.bold == true) code += codeHide;
    if (cellData.effectiveFormat?.textFormat?.italic == true) code += codeImportant;
    List<int> retList = List.filled(plainText.length, code);

    if (cellData.textFormatRuns != null) {
      TextFormatRun curItem = cellData.textFormatRuns![0];
      curItem.startIndex = 0;

      for (int i = 1; i < cellData.textFormatRuns!.length; i++) {
        TextFormatRun nextItem = cellData.textFormatRuns![i];

        code = retList[curItem.startIndex!];
        if (curItem.format?.bold == true) code += codeHide;
        if (curItem.format?.underline == true) code += codeAccent;
        if (curItem.format?.italic == true) code += codeImportant;

        for (int j = curItem.startIndex!; j < nextItem.startIndex!; j++ ) {
          retList[j] = code;
        }

        curItem = nextItem;
      }

      code = retList[curItem.startIndex!];
      if (curItem.format?.bold == true) code += codeHide;
      if (curItem.format?.underline == true) code += codeAccent;
      if (curItem.format?.italic == true) code += codeImportant;

      for (int j = curItem.startIndex!; j < plainText.length; j++ ) {
        retList[j] = code;
      }
    }

    int speakerColonIndex = plainText.indexOf((':'));  // ex. "John: "
    if (speakerColonIndex != -1 && speakerColonIndex < 10) {
      for (int i = 0; i < speakerColonIndex + 1; i++ ) {
        retList[i] += codeSpeaker;
      }
    }

    return retList;
  }
}