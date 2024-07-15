import 'package:flutter/material.dart';
import '../../../models/get_city_weather.dart';
import '../../../models/get_ip_geolocation.dart';
import '../../../models/get_search_city.dart';
import '../../../models/get_tip.dart';
import '../../../models/get_weather.dart';
import '../../../service/api_services.dart';

class WeatherController with ChangeNotifier {
  bool isReady = false;
  IpInfoModel ipInfoModelr = IpInfoModel();
  IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
  CityWeatherModel cityWeatherModel = CityWeatherModel();
  WeatherModel weatherModel = WeatherModel();

  WeatherController(String cityName) {
    _getCurrentLocWeather(cityName);
  }

  void _getCurrentLocWeather(String cityName) {
    isReady = true;
    ApiServices().getIpInfo().then((val) {
      if (val != null) {
        ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
        ApiServices().getIPGeoLocation(ipInfoModelr.ip.toString()).then((data) {
          ipIGeoLocModel = data!;
          String city = cityName.isEmpty ? ipIGeoLocModel.city.toString() : cityName;
          ApiServices().getCityWeather(city).then((wdata) {
            cityWeatherModel = wdata!;
            isReady = false;
            notifyListeners();
          });
        });
      } else {
        isReady = false;
      }
    });
  }

}
