import 'dart:convert';

import 'package:http/http.dart' as http;

import 'geo_location_model.dart';

class GeoLocationController {
  Future<GeoLocModel?> getGeoLocCordinates(String cityname) async {
    try {
      var res = await http.get(Uri.parse(
          "https://geocoding-api.open-meteo.com/v1/search?name=${cityname}&count=5&language=en&format=json"));
      if (res.statusCode == 200) {
        GeoLocModel geolocmodel = GeoLocModel.fromJson(json.decode(res.body));
        return geolocmodel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
