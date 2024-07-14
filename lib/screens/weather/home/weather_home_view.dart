import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screens/weather/home/weather_home_controller.dart';
import 'package:weatherapp/theme/colors.dart';
import 'package:weatherapp/utils/date_formater.dart';
import '../forecast/forecast_view.dart';


class WeatherHomeView extends StatelessWidget {
  const WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherController(),
      child: Consumer<WeatherController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.blue,
            appBar: controller.isSearch
                ? AppBar(
              leading: TextButton(
                child: const Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  controller.toggleSearch();
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
            )
                : AppBar(
              backgroundColor: AppColors.bluetransparent,
              leading: const Icon(
                Icons.pin_drop,
                size: 30,
                color: Colors.white,
              ),
              title: InkWell(
                onTap: controller.toggleSearch,
                child: Row(
                  children: [
                    Text(
                      controller.cityWeatherModel.location?.name?.toString() ?? 'Unknown Location',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(width: 10,),
                    const Icon(Icons.arrow_drop_down_sharp, size: 40, color: Colors.white,)
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: controller.toggleSearch,
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
            )
                : controller.isSearch
                ? ListView.builder(
              itemCount: controller.resultList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextButton(
                      onPressed: () {
                        controller.setNewCity(controller.resultList[index].region.toString());
                      },
                      child: Text(controller.resultList[index].region.toString())),
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
                  const SizedBox(height: 50),
                  if (controller.cityWeatherModel.current?.condition?.icon != null)
                    Image.network(
                      "https:${controller.cityWeatherModel.current!.condition!.icon.toString()}",
                      width: 400,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Opacity(
                      opacity: 0.3,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ]),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            if (controller.cityWeatherModel.location?.localtime != null)
                              Text(
                                "Today ${DateFormater().DateFormaterfunction(controller.cityWeatherModel.location!.localtime.toString())}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            const SizedBox(height: 5),
                            if (controller.cityWeatherModel.current?.tempC != null)
                              Text(
                                "${controller.cityWeatherModel.current!.tempC!.toInt().toString()}\u00B0",
                                style: const TextStyle(fontSize: 80, color: Colors.black),
                              ),
                            if (controller.cityWeatherModel.current?.condition?.text != null)
                              Text(
                                controller.cityWeatherModel.current!.condition!.text.toString(),
                                style: const TextStyle(fontSize: 22),
                              ),
                            const SizedBox(height: 30),
                            if (controller.cityWeatherModel.current?.windKph != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.wind_power),
                                  const SizedBox(width: 20),
                                  const Text("Wind     |  ", style: TextStyle(fontSize: 18)),
                                  Text(
                                    "${controller.cityWeatherModel.current?.windKph.toString()} Km/h",
                                    style: const TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            const SizedBox(height: 20),
                            if (controller.cityWeatherModel.current?.humidity != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.water_drop),
                                  const SizedBox(width: 2),
                                  const Text("Hum        |          ", style: TextStyle(fontSize: 18)),
                                  Text(
                                    "${controller.cityWeatherModel.current?.humidity.toString()} %",
                                    style: const TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.cityWeatherModel.location?.name != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForecastView(
                                    cityname: controller.cityWeatherModel.location!.name.toString(),
                                  )));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: const BorderSide(
                            color: Colors.white60,
                            width: 2,
                          ),
                          fixedSize: const Size(190, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: Row(
                        children: const [
                          Text("Forecast Report   ", style: TextStyle(color: Colors.white)),
                          Icon(Icons.arrow_drop_up, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}