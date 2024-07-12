// import 'package:flutter/cupertino.dart';
// import 'package:weatherapp/screens/weather/home/weather_home_model.dart';
//
// import '../../../models/get_city_weather.dart';
// import '../../../models/get_ip_geolocation.dart';
// import '../../../models/get_tip.dart';
// import '../../../models/get_weather.dart';
// import '../../../service/api_services.dart';
//
// class WeatherHomeController{
//
//   WeatherHomeModel _weatherhomemodel =WeatherHomeModel();
//   IpInfoModel ipInfoModelr = IpInfoModel();
//   IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
//   CityWeatherModel cityWeatherModel = CityWeatherModel();
//   WeatherModel weatherModel = WeatherModel();
//
//
//   TextEditingController searchcontroller = TextEditingController();
//
//   void _getcurrentlocweather() {
//     _weatherhomemodel.isready = true;
//     ApiServices().getIpInfo().then((val) {
//       if (val != null) {
//         ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
//         ApiServices().getIPGeoLocation(ipInfoModelr.ip.toString()).then((data) {
//           ipIGeoLocModel = data!;
//           String city = _weatherhomemodel.searchedcity == ""
//               ? ipIGeoLocModel.city.toString()
//               : _weatherhomemodel.searchedcity;
//           ApiServices().getCityWeather(city).then((wdata) {
//             cityWeatherModel = wdata!;
//             setState(() {});
//           });
//         });
//       }
//       isready = false;
//     });
//   }
//
//
//
//
// }