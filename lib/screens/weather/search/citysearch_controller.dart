import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weatherapp/screens/weather/search/citysearch_model.dart';
import 'package:weatherapp/service/api_services.dart';

class CitysearchController with ChangeNotifier
{
  CitysearchModel model=CitysearchModel();
  TextEditingController searchController = TextEditingController();
  bool isReady=false;




  void getSearchResult(String searchQuery) {
    ApiServices().searchCity(searchQuery).then((searchVal) {
      model.resultList = searchVal!;
      isReady=false;
      notifyListeners();
    });
  }




}