import 'package:flutter/material.dart';
import '../../../models/get_city_weather.dart';
import '../../../models/get_ip_geolocation.dart';
import '../../../models/get_search_city.dart';
import '../../../models/get_tip.dart';
import '../../../models/get_weather.dart';
import '../../../service/api_services.dart';

class WeatherController with ChangeNotifier {
  bool isSearch = false;
  bool isReady = false;
  String searchedCity = "";

  TextEditingController searchController = TextEditingController();

  IpInfoModel ipInfoModelr = IpInfoModel();
  IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
  CityWeatherModel cityWeatherModel = CityWeatherModel();
  WeatherModel weatherModel = WeatherModel();

  List<SearchCityModel> resultList = [];

  WeatherController() {
    _getCurrentLocWeather();
  }

  void getSearchResult(String searchQuery) {
    ApiServices().searchCity(searchQuery).then((searchVal) {
      resultList = searchVal!;
      notifyListeners();
    });
  }

  void _getCurrentLocWeather() {
    isReady = true;
    ApiServices().getIpInfo().then((val) {
      if (val != null) {
        ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
        ApiServices().getIPGeoLocation(ipInfoModelr.ip.toString()).then((data) {
          ipIGeoLocModel = data!;
          String city = searchedCity == "" ? ipIGeoLocModel.city.toString() : searchedCity;
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

  void setNewCity(String city) {
    searchedCity = city;
    _getCurrentLocWeather();
    isSearch = false;
    notifyListeners();
  }

  void toggleSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }
}
