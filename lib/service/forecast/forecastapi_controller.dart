import 'dart:convert';

import 'package:http/http.dart' as http;

import 'forecastapi_model.dart';



class ForecastController{
  Future<ForecastModel?>? getForecastData(String cityname) async
  {
    try{
      var res= await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=d771530ea2c04342a4a114808240807&q=${cityname}&days=7"));
      if(res.statusCode==200)
        {
          ForecastModel forecastModel=ForecastModel.fromJson(json.decode(res.body));
          return forecastModel;
        }

    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }
}