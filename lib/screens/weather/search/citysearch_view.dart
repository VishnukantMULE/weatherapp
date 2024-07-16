import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/weather/home/weather_home_view.dart';
import 'package:weatherapp/screens/weather/search/citysearch_controller.dart';
import 'package:weatherapp/service/db_service/db_service.dart';
import 'package:weatherapp/utils/date_formater.dart';
import 'package:weatherapp/utils/time_utils.dart';

class CitysearchView extends StatelessWidget {
  const CitysearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CitysearchController(),
      child: Consumer<CitysearchController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: AppBar(
              leading: TextButton(
                child: const Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.blue,
              title: TextField(
                controller: controller.searchController,
                onChanged: controller.getSearchResult,
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
                    controller
                        .getSearchResult(controller.searchController.text);
                  },
                  child: const Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Column(children: <Widget>[
              controller.isReady
                  ? Container(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: controller.recentsearch.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WeatherHomeView(
                                            cityName:
                                                controller.recentsearch[index]
                                                    ["cityname"])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                  Flexible(
                                    child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          text: controller.recentsearch[index]
                                              ["cityname"],
                                        )),
                                  ),
                                  Text(
                                    TimeUtils().TimeDifference(controller.recentsearch[index]
                                    ["datetime"]).toString()
                                      ,
                                      style: const TextStyle(fontSize: 18)),
                                ]),
                              ),
                            );
                          }),
                    ),
              controller.isrecentready
                  ? Container(
                      child: const CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.model.resultList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: TextButton(
                                onPressed: () {
                                  controller.model.searchCity = controller
                                      .model.resultList[index].name
                                      .toString();
                                  DbService().insertDataInDB(
                                      controller.model.searchCity,
                                      DateFormater().DateTimeNow());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WeatherHomeView(
                                              cityName: controller
                                                  .model.searchCity)));
                                  // controller.setNewCity(controller.resultList[index].region.toString());
                                },
                                child: Text(controller
                                    .model.resultList[index].name
                                    .toString())),
                          );
                        },
                      ),
                    )
            ]),
          );
        },
      ),
    );
  }
}
