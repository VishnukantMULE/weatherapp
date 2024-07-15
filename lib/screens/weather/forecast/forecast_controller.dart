import 'package:flutter/cupertino.dart';
import 'package:weatherapp/utils/date_formater.dart';

import '../../../service/api_services.dart';

// import '../../../service/api_services.dart';
// import '../../../utils/date_formater.dart';

class ForecastController with ChangeNotifier{
  final String cityname;

  Map<String, dynamic>? forecastData;
  Map<String, dynamic>? historyData;
  late int hrindex;
  List<Map<String, dynamic>> completeData = [];
  List<dynamic> hourlyData = [];


  ForecastController(this.cityname){
    hrindex=8;
    _getForecast();
  }

  Future<void> _getForecast() async {
    ApiServices forecastController = ApiServices();
    String currentDate = await DateFormater().CurrentDate();
    String lastweekdate = await DateFormater().lastWeekDate();

    var historydata = await forecastController.getHistoricData(
        cityname, lastweekdate, currentDate);
    var forecastdata =
    await forecastController.getForecastData(cityname);
      forecastData = forecastdata;
      historyData = historydata;
      combineData();
      notifyListeners();
  }



  void combineData() {
    completeData.clear();

    if (historyData != null &&
        historyData!['forecast'] != null &&
        historyData!['forecast']['forecastday'] != null) {
      print("History Dta Got");
      completeData.addAll(List<Map<String, dynamic>>.from(
          historyData!['forecast']['forecastday']));
    }
    if (forecastData != null &&
        forecastData!['forecast'] != null &&
        forecastData!['forecast']['forecastday'] != null) {
      print("Forecast Dta Got");

      completeData.addAll(List<Map<String, dynamic>>.from(
          forecastData!['forecast']['forecastday']));
    }
    hourlyData = completeData[hrindex]['hour'];
    notifyListeners();
  }


  void updateindex(int newindex) {

      hrindex = newindex;
      if (completeData.isNotEmpty) {
        hourlyData = completeData[hrindex]['hour'];
      }
      notifyListeners();

  }
}