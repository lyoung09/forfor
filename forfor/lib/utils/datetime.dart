import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/src/intl/date_format.dart';

class DatetimeFunction {
  String ago(Timestamp t) {
    String x = timeago
        .format(t.toDate())
        .replaceAll("minutes", "분")
        .replaceAll("a minute", "1분")
        .replaceAll("a moment", "방금")
        .replaceAll("a month", "한 달")
        .replaceAll("month", "한달")
        .replaceAll("a day", "1일")
        .replaceAll("ago", "전")
        .replaceAll("about", "")
        .replaceAll("an hour", "한시간")
        .replaceAll("hours", "시간")
        .replaceAll("days", "일")
        .replaceAll("one year", "1년")
        .replaceAll("day", "일")
        .replaceAll("years", "년");
    return x;
  }

  String readTimeStamp(DateTime date) {
    DateTime t = DateTime.now();

    if (date.hour != t.hour) {
      var output1 = DateFormat('hh mm a').format(date);
      return output1;
    } else {
      var output1 = DateFormat('hh mm a').format(date);
      var format = new DateFormat.Hm(); // My Format 08:00

      return output1;
    }
  }

  String diffDay(DateTime date) {
    final now = DateTime.now();
    DateTime t = DateTime(now.year, now.month, now.day + 1);

    if (date.day != t.day) {
      var output1 = DateFormat('yyyy-MM-dd').format(date);
      return output1;
    }
    if (date.year != t.year) {
      var output1 = DateFormat('yyyy-MM-dd').format(date);
      return output1;
    }
    if (date.month != t.month) {
      var output1 = DateFormat('yyyy-MM-dd').format(date);
      return output1;
    }
    if (date.hour != t.hour) {
      return "";
    } else {
      return "";
    }
  }
}
