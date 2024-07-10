import 'package:intl/intl.dart';

class DateFormater{


  String DateFormaterfunction(String datestring)
  {
    DateTime datetime=DateFormat("yyyy-mm-dd HH:mm").parse(datestring);

    String formateddate=DateFormat("d MMMM").format(datetime);

    return formateddate;
  }


  String DateFormateforforecast(String date)
  {
    DateTime datetime=DateFormat("yyyy-mm-dd").parse(date);

    String formateddate=DateFormat("d MMM").format(datetime);

    return formateddate;
  }


  String CurrentDate()
  {
    DateTime now = new DateTime.now();
    String dateis=DateFormat("yyyy-mm-dd").format(now);
    return dateis;
  }
  String lastWeekDate()
  {
    String currentdate=CurrentDate();
    DateTime datetime=DateFormat("yyyy-mm-dd").parse(currentdate);
    DateTime newdate= DateTime(datetime.year,datetime.month,datetime.day-7);
    String formateddate=DateFormat("yyyy-mm-dd").format(newdate);
    return formateddate;

  }


}