import 'package:flutter/material.dart';
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
  late String searchedcity = "";

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
        ApiServices().getIPGeoLocation(ipInfoModelr.ip.toString()).then((data) {
          ipIGeoLocModel = data!;
          String city = searchedcity == ""
              ? ipIGeoLocModel.city.toString()
              : searchedcity;
          ApiServices().getCityWeather(city).then((wdata) {
            cityWeatherModel = wdata!;
            setState(() {});
          });
        });
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

  void setNewCity(String city) {
    setState(() {
      searchedcity = city;
      _getcurrentlocweather();
      isSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: isSearch
          ? AppBar(
              leading: TextButton(
                child: const Icon(Icons.arrow_back_sharp),
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
                  child: const Icon(
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
                size: 30,
                color: Colors.white,
              ),
              title: InkWell(
                onTap: (){
                  setState(() {
                    isSearch=true;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      cityWeatherModel.location!.name.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_drop_down_sharp,size: 40,color: Colors.white,)
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  child: const Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            ),
      body: isready == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isSearch
              ? ListView.builder(
                  itemCount: resultlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextButton(
                          onPressed: () {
                            setNewCity(resultlist[index].region.toString());
                          },
                          child: Text(resultlist[index].region.toString())),
                    );
                  },
                )
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, AppColors.bluetransparent],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.7],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(
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
                                // color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Today ${DateFormater().DateFormaterfunction(cityWeatherModel.location!.localtime.toString())}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${cityWeatherModel.current!.tempC!.toInt().toString()}\u00B0",
                                  style: const TextStyle(
                                      fontSize: 80, color: Colors.black),
                                ),
                                Text(
                                  cityWeatherModel.current!.condition!.text
                                      .toString(),
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.wind_power),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      "Wind     |  ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "${cityWeatherModel.current?.windKph.toString()} Km/h",
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.water_drop),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      "Hum        |          ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "${cityWeatherModel.current?.humidity.toString()} %",
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForecastView(
                                          cityname: cityWeatherModel
                                              .location!.name
                                              .toString(),
                                        )));
                          },
                          style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.blue,
                              side: const BorderSide(
                                color: Colors.white60,
                                width: 2
                              ),
                              fixedSize: const Size(190, 45),
                              shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(
                                8,

                              )
                              )
                          ),
                          child: Row(
                            children: [
                              const Text("Forecast Report   ",style: TextStyle(color: Colors.white),),
                              Icon(MdiIcons.menuUp,color: Colors.white,)
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
