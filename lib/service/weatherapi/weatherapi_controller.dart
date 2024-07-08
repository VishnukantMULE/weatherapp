import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/service/weatherapi/weatherapi_model.dart';

class WeatherapiController {
  Future<WeatherModel?>? getcurrentWeather(
      String latitude, String longitude) async {
    try {
      var res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=70ae403dedd8f258ee457633ea3cfa6a"));
      if (res.statusCode == 200) {
        WeatherModel weatherModel=WeatherModel.fromJson(json.decode(res.body));
        return weatherModel;

      }
      else
        {
          print("Failed .....");
        }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
