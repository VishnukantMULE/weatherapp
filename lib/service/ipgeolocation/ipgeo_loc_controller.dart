import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/service/ipinfo/ipinfo_model.dart';

import 'ipgeo_loc_model.dart';
class IpgeoLocController{
  IpInfoModel ipinfomodel=IpInfoModel();
  Future<IpIGeoLocModel?> getIPGeoLocation( String ipaddress)
  async{
    try{
      var res=await http.get(Uri.parse("https://api.ipgeolocation.io/ipgeo?apiKey=2f058980b09849ac9e9b15b9b744575e&ip=${ipaddress}"));
      if(res.statusCode==200)
        {
          IpIGeoLocModel ipGeoLocModel=IpIGeoLocModel.fromJson(json.decode(res.body));
          return ipGeoLocModel;
        }
    }
    catch(e)
    {
      print(e.toString());
    }
    return null;
  }
}