import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/service/searchcity/searchcity_model.dart';


class SearchcityController{
  
  Future<List<SearchCityModel>?> searchCity(String query) async
  {
    
    try{
      var res=await http.get(Uri.parse("http://api.weatherapi.com/v1/search.json?key=d771530ea2c04342a4a114808240807&q=${query}"));
      if(res.statusCode==200)
        {
          List<SearchCityModel> searchmodel=List<SearchCityModel>.from(json.decode(res.body).map((x)=>SearchCityModel.fromJson(x)));
          return searchmodel;
        }
    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }
  

  
  
}