import '../../../models/get_search_city.dart';

class WeatherHomeModel{
  bool isSearch = false;
  bool isready = false;

  late String searchedcity = "";

  List<SearchCityModel> resultlist = [];
}