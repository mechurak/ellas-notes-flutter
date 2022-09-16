class DateUtil {
  static String getLastStudyDateStr(DateTime dateTime) {
    if (dateTime == DateTime.fromMillisecondsSinceEpoch(0)) {
      return '';
    }
    return '(last study: ${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')})';
  }
}