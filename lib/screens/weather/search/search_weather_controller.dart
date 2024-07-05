import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'geoLocationModel.dart';

class SearchWeatherController {
  TextEditingController searchInputController = TextEditingController();
  List<Results> geoList = [];

  Future<List<Results>> getGeoCoordinates(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      geoList.clear();
      for (var i in data['results']) {
        Results result = Results.fromJson(i);
        geoList.add(result);
      }
      print(response.body);
      return geoList;
    } else {
      print('Failed');
      return [];
    }
  }
}
