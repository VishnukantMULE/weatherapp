import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:weatherapp/theme/colors.dart';
import 'package:weatherapp/utils/date_formater.dart';
import '../../../models/get_city_weather.dart';
import '../../../models/get_ip_geolocation.dart';
import '../../../models/get_search_city.dart';
import '../../../models/get_tip.dart';
import '../../../models/get_weather.dart';
import '../../../service/api_services.dart';
import '../forecast/forecast_view.dart';

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({super.key});

  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  bool isSearch = false;
  bool isready = false;
  late String searchedcity="";

  TextEditingController searchcontroller = TextEditingController();


  IpInfoModel ipInfoModelr = IpInfoModel();
  IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
  CityWeatherModel cityWeatherModel = CityWeatherModel();

  WeatherModel weatherModel = WeatherModel();

  List<SearchCityModel> resultlist = [];

  _getSearchResult(String searchquery) {
    ApiServices().searchCity(searchquery).then((searchval) {
      setState(() {
        resultlist = searchval!;
      });
    });
  }

  _getcurrentlocweather() {
    isready = true;
    ApiServices().getIpInfo().then((val) {
      if (val != null) {
        ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
        ApiServices()
            .getIPGeoLocation(ipInfoModelr.ip.toString())
            .then((data) {
          ipIGeoLocModel = data!;
          print("City Get ${ipIGeoLocModel.city}");
           String city=searchedcity==""?ipIGeoLocModel.city.toString():searchedcity;
          ApiServices().getCityWeather(city).then((wdata) {
            cityWeatherModel = wdata!;
            print(
                "city weather is ${cityWeatherModel.current?.tempC.toString()}");
            setState(() {});
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


  void setNewCity(String city)
  {
    setState(() {
      searchedcity=city;
      _getcurrentlocweather();
      isSearch=false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: isSearch
          ? AppBar(
              leading: TextButton(
                child: Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  setState(() {
                    isSearch = false;
                  });
                },
              ),
              backgroundColor: Colors.blue,
              title: TextField(
                controller: searchcontroller,
                onChanged: _getSearchResult(searchcontroller.text),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _getSearchResult(searchcontroller.text);
                  },
                  child: Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : AppBar(

              backgroundColor: AppColors.bluetransparent,
              leading: Icon(
                MdiIcons.mapMarker,
                size: 35,
                color: Colors.white,
              ),
              title: Row(
                children: [
                  Text(
                    cityWeatherModel.location!.name.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  child: Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            ),
      body: isready == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isSearch
              ? ListView.builder(
                  itemCount: resultlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextButton(onPressed: () {
                        setNewCity(resultlist[index].region.toString());
                        },
                      child: Text(resultlist[index].region.toString())),
                    );
                  },
                )
              : Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, AppColors.bluetransparent],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.7],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Image.network(
                        "https:${cityWeatherModel.current!.condition!.icon.toString()}",
                        width: 400,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Opacity(
                          opacity: 0.3,
                          child: Container(
                            // height: 400,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Today ${DateFormater().DateFormaterfunction(cityWeatherModel.location!.localtime.toString())}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${cityWeatherModel.current!.tempC!.toInt().toString()}\u00B0",
                                  style: TextStyle(fontSize: 80),
                                ),
                                Text(
                                  cityWeatherModel.current!.condition!.text
                                      .toString(),
                                  style: TextStyle(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.wind_power),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Wind     |  ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "${cityWeatherModel.current?.windKph.toString()} Km/h",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.water_drop),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Hum        |          ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "${cityWeatherModel.current?.humidity.toString()} %",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForecastView(
                                          cityname:
                                              cityWeatherModel.location!.name.toString(),
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(190, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                8,
                              ))),
                          child: Row(
                            children: [
                              Text("Forecast Report   "),
                              Icon(MdiIcons.menuUp)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
// at_ePnrppRtEldAWsZHGSJwp0WdZSeWJ
//
// 2f058980b09849ac9e9b15b9b744575e
