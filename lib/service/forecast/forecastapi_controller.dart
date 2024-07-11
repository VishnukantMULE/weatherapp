import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ForecastController {
  Future<Map<String, dynamic>?> getForecastData(String cityname) async {
    try {
      var res = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=d771530ea2c04342a4a114808240807&q=${cityname}&days=7"));
      if (res.statusCode == 200) {

        return json.decode(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Map<String,dynamic>?> getHistoricData(String cityname,String fromDate,String toDate) async
  {
    try{
      print("Trying to get Historical :    http://api.weatherapi.com/v1/history.json?key=d771530ea2c04342a4a114808240807&days=7&q=$cityname&dt=$fromDate&end_dt=$toDate");

      var res=await http.get(Uri.parse("http://api.weatherapi.com/v1/history.json?key=d771530ea2c04342a4a114808240807&days=7&q=$cityname&dt=$fromDate&end_dt=$toDate"));
      if( res.statusCode==200)
        {
          return json.decode(res.body);
        }
      else{
        print("i  am in else");
      }
    }
    catch(e)
    {
      print(e.toString());
    }
    
    return null;
  }





}
