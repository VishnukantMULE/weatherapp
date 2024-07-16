import 'package:flutter/cupertino.dart';
import 'package:weatherapp/screens/weather/search/citysearch_model.dart';
import 'package:weatherapp/service/api_services.dart';
import 'package:weatherapp/service/db_service/db_service.dart';

class CitysearchController with ChangeNotifier
{

  CitysearchModel model=CitysearchModel();
  TextEditingController searchController = TextEditingController();
  bool isReady=false;
  bool isrecentready=false;
  List<Map<String,dynamic>> recentsearch=[];

  CitysearchController(){
    fetchrecentSearch();
  }
  void fetchrecentSearch() async{
    recentsearch=await DbService().fetchDatafromDB();
    isrecentready=false;
    print("I am in controller");
    notifyListeners();
  }



  void getSearchResult(String searchQuery) {
    ApiServices().searchCity(searchQuery).then((searchVal) {
      model.resultList = searchVal!;
      isReady=false;
      notifyListeners();
    });
  }




}