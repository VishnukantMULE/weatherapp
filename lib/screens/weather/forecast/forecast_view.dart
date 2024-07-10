import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/service/forecast/forecastapi_controller.dart';
import 'package:weatherapp/utils/date_formater.dart';

class ForecastView extends StatefulWidget {
  final String cityname;
  const ForecastView({super.key, required this.cityname});

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  Map<String, dynamic>? forecastData;
  Map<String,dynamic>? historyData;

  Future<void> _getForecast() async {
    ForecastController forecastController = ForecastController();
    var data = await forecastController.getForecastData(widget.cityname);
    setState(() {
      forecastData = data;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _getForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City: ${widget.cityname}"),
      ),
      body: ListView(children: [
        SizedBox(height: 250,),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Scrollbar(
              child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                itemCount: forecastData!['forecast']['forecastday'].length,
                itemBuilder: (context, index) {
                  var forecastDay =
                      forecastData!['forecast']['forecastday'][index];
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${DateFormater().DateFormateforforecast(forecastDay["date"])}"),
                        Image.network(
                          "https:${forecastDay["day"]["condition"]["icon"]}",
                        ),
                        Text("${forecastDay["day"]["avgtemp_c"].toString()}")
                      ],
                    )
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: (){}, child: Text("Weather App"))
      ]),
    );
  }
}
