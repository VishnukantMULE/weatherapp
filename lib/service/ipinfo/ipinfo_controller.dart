import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ipinfo_model.dart';

class IpinfoController{
  Future<IpInfoModel?> getIpInfo() async{
    try{
      var res=await http.get(Uri.parse('https://api.ipify.org/?format=json'));
      if(res.statusCode==200)
        {
          IpInfoModel ipInfoModel=IpInfoModel.fromJson(json.decode(res.body));
          print(res.body);
          return ipInfoModel;
        }
      else
        {
          print("Ip response failed");

        }
      
    }
    catch(e)
    {
      print(e.toString());
    }
    print("Failed Evrything");
    return null;
    
  }
}