import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp/theme/colors.dart';
import 'package:weatherapp/utils/date_formater.dart';

import '../../../service/api_services.dart';

class ForecastView extends StatefulWidget {
  final String cityname;
  const ForecastView({super.key, required this.cityname});

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  Map<String, dynamic>? forecastData;
  Map<String, dynamic>? historyData;
  late int hrindex;

  List<Map<String, dynamic>> completeData = [];
  List<dynamic> hourlyData = [];

  Future<void> _getForecast() async {
    ApiServices forecastController = ApiServices();
    String currentdate = await DateFormater().CurrentDate();
    String lastweekdate = await DateFormater().lastWeekDate();

    var historydata = await forecastController.getHistoricData(
        widget.cityname, lastweekdate, currentdate);
    var forecastdata =
        await forecastController.getForecastData(widget.cityname);

    setState(() {
      forecastData = forecastdata;
      historyData = historydata;
      combineData();
    });
  }

  void combineData() {
    completeData.clear();

    if (historyData != null &&
        historyData!['forecast'] != null &&
        historyData!['forecast']['forecastday'] != null) {
      print("History Dta Got");
      completeData.addAll(List<Map<String, dynamic>>.from(
          historyData!['forecast']['forecastday']));
    }
    if (forecastData != null &&
        forecastData!['forecast'] != null &&
        forecastData!['forecast']['forecastday'] != null) {
      print("Forecast Dta Got");

      completeData.addAll(List<Map<String, dynamic>>.from(
          forecastData!['forecast']['forecastday']));
    }
    hourlyData = completeData[hrindex]['hour'];
  }

  @override
  void initState() {
    // TODO: implement initState
    hrindex = 8;
    _getForecast();

    super.initState();
  }

  void updateindex(int newindex) {
    setState(() {
      hrindex = newindex;
      if (completeData.isNotEmpty) {
        hourlyData = completeData[hrindex]['hour'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.blue,
      appBar: AppBar(
        backgroundColor: AppColors.bluetransparent,
        title: Text(
          " ${widget.cityname}",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, AppColors.bluetransparent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 180,
                child: forecastData == null
                    ? const Center(
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator()))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hourlyData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration:  BoxDecoration(
                                // color: Colors.black,
                                border: Border.all(
                                  color: Colors.white38,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                // color: AppColors.bluetransparent,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:
                                //     Colors.white.withOpacity(0.7),
                                //     spreadRadius: 5,
                                //     blurRadius: 7,
                                //     offset: Offset(0,
                                //         3), // changes position of shadow
                                //   ),
                                // ],
                              ),
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        "${hourlyData[index]["temp_c"].toString()} \u2103",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18

                                    ),),

                                    Image.network(
                                      "https:${hourlyData[index]["condition"]["icon"]}",
                                    ),
                                    // Text(hourlyData[index]["time"]),
                                    Text(DateFormater().getTimeAMPM(
                                        hourlyData[index]["time"]),style:TextStyle(color: Colors.white) ,),
                                    // Text(TimeUtils().currentTime())
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Next and Current ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white38
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Scrollbar(
                
                thickness: 5,
                radius: const Radius.circular(20),
                child: forecastData == null
                    ? const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()))
                    : ListView.builder(
                        itemCount: completeData.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                updateindex(index);
                              });
                            },
                            child: Container(
                                // color: AppColors.whitetransparent,
                                decoration: index == hrindex
                                    ? BoxDecoration(
                                        // color: Colors.black,
                                        border: Border.all(
                                          color: Colors.white38,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      )
                                    : const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateFormater().DateFormateforforecast(
                                          completeData[index]["date"]),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Image.network(
                                      "https:${completeData[index]["day"]["condition"]["icon"]}",
                                    ),
                                    Text(
                                        " ${completeData[index]["day"]["avgtemp_c"].toString()} \u00B0",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500))
                                  ],
                                )),
                          );
                        },
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.sun_max_fill,color: Colors.white,),
              SizedBox(width: 20,),
              Text("weatherApp",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))
            ],
          )
         
        ]),
      ),
    );
  }
}
