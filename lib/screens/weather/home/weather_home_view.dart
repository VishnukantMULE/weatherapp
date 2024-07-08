import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weatherapp/service/geolocation/geo_location_controller.dart';
import 'package:weatherapp/service/getcityweather/getcityweather_controller.dart';
import 'package:weatherapp/service/getcityweather/getcityweather_model.dart';
import 'package:weatherapp/service/ipgeolocation/ipgeo_loc_controller.dart';
import 'package:weatherapp/service/ipinfo/ipinfo_controller.dart';
import 'package:weatherapp/service/ipinfo/ipinfo_model.dart';
import 'package:weatherapp/service/weatherapi/weatherapi_model.dart';

import '../../../service/geolocation/geo_location_model.dart';
import '../../../service/ipgeolocation/ipgeo_loc_model.dart';

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({super.key});

  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  bool isready = false;
  IpInfoModel ipInfoModelr = IpInfoModel();
  IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
  CityWeatherModel cityWeatherModel = CityWeatherModel();
  GeoLocModel geoLocModel = GeoLocModel();
  WeatherModel weatherModel = WeatherModel();

  _getcurrentlocweather() {
    isready = true;
    IpinfoController().getIpInfo().then((val) {
      if (val != null && val is IpInfoModel) {
        ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
        print("Ip get");
        IpgeoLocController()
            .getIPGeoLocation(ipInfoModelr.ip.toString())
            .then((data) {
          print("City Get ");

          ipIGeoLocModel = data!;
          GetcityweatherController()
              .getCityWeather(ipIGeoLocModel.city.toString())
              .then((wdata) {
                cityWeatherModel=wdata!;
                print("City temperature data is ${cityWeatherModel.current?.tempC?.toDouble()}");
                setState(() {

                });
          });
        });
      } else {
        print("Failed ");
      }
      isready = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getcurrentlocweather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff29b6f6),
        appBar: AppBar(
          backgroundColor: Color(0xff29b6f6),
          leading: Icon(
            MdiIcons.mapMarker,
            size: 35,
            color: Colors.white,
          ),
          title: Row(
            children: [
              Text(
                'Thane   ',
                style:
                    TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
          actions: [
            Icon(
              MdiIcons.bellAlert,
              size: 35,
              color: Colors.white,
            )
          ],
        ),
        body: isready == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: [
                    Center(
                      // child: Text(ipInfoModelr.ip.toString()),
                      child: Text("hjjjjj"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text('clic')),
                    // Text(ipIGeoLocModel.city.toString()),
                  ],
                ),
              ));
  }
}
