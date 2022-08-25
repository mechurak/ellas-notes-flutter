import 'package:googleapis/sheets/v4.dart';

class IndexHolder {
  int nameForId = 0; // both
  int order = 1; // both
  int text = 2;
  int hint = -1; // optional
  int note = -1; // optional
  int memo = -1; // optional
  int quiz = -1;

  int metaTitle = 2;
  int metaCategory = -1; // optional
  int metaRemoteUrl = -1; //optional
  int metaLink1 = -1; // optional
  int metaLink2 = -1; // optional

  void setColumnIndices(RowData rowData) {
    List<CellData> cells = rowData.values!;
    for (int i = 0; i < cells.length; i++) {
      String? formattedValue = cells[i].formattedValue;
      switch (formattedValue) {
        case "date":
        case "day":
        case "lecture":
          nameForId = i;
          break;
        case "order":
          order = i;
          break;
        case "text":
          text = i;
          break;
        case "hint":
          hint = i;
          break;
        case "note":
          note = i;
          break;
        case "memo":
          memo = i;
          break;
        case "quiz":
          quiz = i;
          break;
        case "title":
          metaTitle = i;
          break;
        case "category":
          metaCategory = i;
          break;
        case "remoteUrl":
          metaRemoteUrl = i;
          break;
        case "link1":
          metaLink1 = i;
          break;
        case "link2":
          metaLink2 = i;
          break;
        default:
          print("unknown keyword ($formattedValue). skip it. cell[$i]");
          break;
      }
    }
  }

  @override
  String toString() {
    return 'IndexHolder{nameForId: $nameForId, order: $order, text: $text, hint: $hint, note: $note, memo: $memo, quiz: $quiz, metaTitle: $metaTitle, metaCategory: $metaCategory, metaRemoteUrl: $metaRemoteUrl, metaLink1: $metaLink1, metaLink2: $metaLink2}';
  }
}
