import 'dart:convert';

import 'package:http/http.dart' as http;

import 'getcityweather_model.dart';

class GetcityweatherController{

  Future<CityWeatherModel?> getCityWeather(String cityname) async{
    try{
      var res=await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=d771530ea2c04342a4a114808240807&q=${cityname}"));
      if(res.statusCode==200){
        CityWeatherModel cityWeatherModel=CityWeatherModel.fromJson(json.decode(res.body));
        return cityWeatherModel;
      }
    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }

}