import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/weather/home/weather_home_view.dart';
import 'package:weatherapp/screens/weather/search/citysearch_controller.dart';
import 'package:weatherapp/service/db_service/db_service.dart';
import 'package:weatherapp/utils/date_formater.dart';

class CitysearchView extends StatelessWidget {
  const CitysearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>CitysearchController(),
    child: Consumer<CitysearchController>(
      builder: (context,controller,child){
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
                  controller.getSearchResult(controller.searchController.text);
                },
                child: const Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.white,
                ),
              )
            ],
          ),

            body: controller.isReady
                ? const Center(
              child: CircularProgressIndicator(),
            ):
            ListView.builder(
              itemCount: controller.model.resultList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextButton(
                      onPressed: () {
                        controller.model.searchCity=controller.model.resultList[index].region.toString();
                        DbService().InsertDatainDB(controller.model.searchCity, DateFormater().DateTimeNow());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherHomeView(cityName:controller.model.searchCity)));
                        // controller.setNewCity(controller.resultList[index].region.toString());
                      },
                      child: Text(controller.model.resultList[index].region.toString())),
                );
              },
            )


        );
      },
    ),);
  }
}
