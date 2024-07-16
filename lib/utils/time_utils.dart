import 'package:intl/intl.dart';
import 'package:weatherapp/utils/date_formater.dart';

class TimeUtils {
  String currentTime() {
    DateTime datetime = new DateTime.now();
    String formattedTime = DateFormat("hh:mm a").format(datetime);
    return formattedTime;
  }

  bool compareTime(String time2) {
    DateFormat dateFormat = DateFormat("hh:mm a");
    DateTime dateTime1 = dateFormat.parse(currentTime());
    DateTime dateTime2 = dateFormat.parse(time2);
    int hour1 = dateTime1.hour;
    String period1 = dateFormat.format(dateTime1).split(' ')[1];
    int hour2 = dateTime2.hour;
    String period2 = dateFormat.format(dateTime2).split(' ')[1];
    return (hour1 == hour2) && (period1 == period2);
  }

   String TimeDifference(String dateStr) {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      DateTime dateTime = dateFormat.parse(dateStr);
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime);

      return "${difference.inDays} days ago";
    } catch (e) {
      // Log the error and return a fallback message
      print("Error parsing date: $dateStr");
      return "Invalid date";
    }
  }
}
