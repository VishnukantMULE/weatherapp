import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weatherapp/service/geolocation/geo_location_controller.dart';
import 'package:weatherapp/service/getcityweather/getcityweather_controller.dart';
import 'package:weatherapp/service/getcityweather/getcityweather_model.dart';
import 'package:weatherapp/service/ipgeolocation/ipgeo_loc_controller.dart';
import 'package:weatherapp/service/ipinfo/ipinfo_controller.dart';
import 'package:weatherapp/service/ipinfo/ipinfo_model.dart';
import 'package:weatherapp/service/searchcity/searchcity_model.dart';
import 'package:weatherapp/service/weatherapi/weatherapi_model.dart';
import '../../../service/geolocation/geo_location_model.dart';
import '../../../service/ipgeolocation/ipgeo_loc_model.dart';
import '../../../service/searchcity/searchcity_controller.dart';

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({super.key});

  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  bool isSearch = false;
  bool isready = false;
  // String searchquery='';

  TextEditingController searchcontroller = TextEditingController();

  // SearchCityModel searchresult=SearchCityModel();
  IpInfoModel ipInfoModelr = IpInfoModel();
  IpIGeoLocModel ipIGeoLocModel = IpIGeoLocModel();
  CityWeatherModel cityWeatherModel = CityWeatherModel();
  GeoLocModel geoLocModel = GeoLocModel();
  WeatherModel weatherModel = WeatherModel();

  List<SearchCityModel> resultlist = [];

  _getSearchResult(String searchquery) {
    SearchcityController().searchCity(searchquery).then((searchval) {
      setState(() {
        resultlist = searchval!;
      });
    });
  }

  _getcurrentlocweather() {
    isready = true;
    IpinfoController().getIpInfo().then((val) {
      if (val != null && val is IpInfoModel) {
        ipInfoModelr.ip = val.ip ?? 'Unknown Ip';
        print("Ip get");
        IpgeoLocController()
            .getIPGeoLocation(ipInfoModelr.ip.toString())
            .then((data) {
          ipIGeoLocModel = data!;
          print("City Get ${ipIGeoLocModel.city}");
          String city = ipIGeoLocModel.city.toString();
          GetcityweatherController().getCityWeather(city).then((wdata) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff29b6f6),
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
                backgroundColor: Color(0xff29b6f6),
                leading: Icon(
                  MdiIcons.mapMarker,
                  size: 35,
                  color: Colors.white,
                ),
                title: Row(
                  children: [
                    Text(
                      ipIGeoLocModel.city.toString(),
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
                        title: Text(resultlist[index].region.toString()),
                      );
                    },
                  )
                : ListView(
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
                                  "Today ${cityWeatherModel.location?.localtime.toString()}",
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
                      SizedBox(height: 25,),
                      Center(
                        child: ElevatedButton(onPressed: (){},
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
      
    );
  }
}
