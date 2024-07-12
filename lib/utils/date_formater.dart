import 'package:intl/intl.dart';

class DateFormater {
  String DateFormaterfunction(String datestring) {
    DateTime datetime = DateFormat("yyyy-MM-dd HH:mm").parse(datestring);

    String formateddate = DateFormat("d MMMM").format(datetime);

    return formateddate;
  }

  String DateFormateforforecast(String date) {
    DateTime datetime = DateFormat("yyyy-MM-dd").parse(date);

    String formateddate = DateFormat("d MMM").format(datetime);

    return formateddate;
  }

  String CurrentDate() {
    DateTime now = new DateTime.now();
    DateTime newdate = DateTime(now.year, now.month, now.day - 1);
    String dateis = DateFormat("yyyy-MM-dd").format(newdate);
    // String dateis= DateFormat("yyyy-MM-dd").format(now);
    return dateis;
  }

  String lastWeekDate() {
    String currentdate = CurrentDate();
    DateTime datetime = DateFormat("yyyy-MM-dd").parse(currentdate);
    DateTime newdate =
        DateTime(datetime.year, datetime.month, datetime.day - 7);
    String formateddate = DateFormat("yyyy-MM-dd").format(newdate);
    return formateddate;
  }

  String getTimeAMPM(String datetime) {
    DateTime dt = DateFormat("yyyy-MM-dd HH:mm").parse(datetime);
    String formattedTime = DateFormat("hh:mm a").format(dt);

    return formattedTime;
  }
}
