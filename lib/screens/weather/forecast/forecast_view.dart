import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/weather/forecast/forecast_controller.dart';

import 'package:weatherapp/theme/colors.dart';
import 'package:weatherapp/utils/date_formater.dart';



class ForecastView extends StatefulWidget {
  final String cityname;
  const ForecastView({super.key, required this.cityname});



  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {









  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>ForecastController(widget.cityname),
    child: Consumer<ForecastController>(
      builder: (context,controller,child){
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
                    child: controller.forecastData == null
                        ? const Center(
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator()))
                        : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.hourlyData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration:  BoxDecoration(
                                // color: Colors.black,
                                border: Border.all(
                                  color: Colors.white70,
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
                                      "${controller.hourlyData[index]["temp_c"].toString()} \u2103",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18

                                    ),),

                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white38,
                                          border: Border.all(color: Colors.white30,),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Image.network(
                                        "https:${controller.hourlyData[index]["condition"]["icon"]}",
                                      ),
                                    ),
                                    // Text(hourlyData[index]["time"]),
                                    Text(DateFormater().getTimeAMPM(
                                        controller.hourlyData[index]["time"]),style:TextStyle(color: Colors.white) ,),
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
                    child: controller.forecastData == null
                        ? const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()))
                        : ListView.builder(
                      itemCount: controller.completeData.length,
                      itemBuilder: (context, index) {
                        return TextButton(
                          onPressed: () {
                              controller.updateindex(index);
                          },
                          child: Container(
                            // color: AppColors.whitetransparent,
                              decoration: index == controller.hrindex
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
                                        controller.completeData[index]["date"]),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white30,
                                          border: Border.all(color: Colors.white30,),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Image.network(
                                        "https:${controller.completeData[index]["day"]["condition"]["icon"]}",
                                      ),
                                    ),
                                  ),
                                  Text(
                                      " ${controller.completeData[index]["day"]["avgtemp_c"].toString()} \u00B0",
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
      },
    )
    );
  }
}
