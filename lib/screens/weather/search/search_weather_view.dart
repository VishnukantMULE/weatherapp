import 'package:flutter/material.dart';
import 'search_weather_controller.dart';
import 'geoLocationModel.dart';

class SearchWeatherView extends StatefulWidget {
  final SearchWeatherController searchController;

  SearchWeatherView({Key? key, required this.searchController}) : super(key: key);

  @override
  State<SearchWeatherView> createState() => _SearchWeatherViewState();
}

class _SearchWeatherViewState extends State<SearchWeatherView> {
  List<Results> _searchResults = [];

  void _searchWeather() async {
    String cityName = widget.searchController.searchInputController.text;
    if (cityName.isNotEmpty) {
      var results = await widget.searchController.getGeoCoordinates(cityName);
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Search')),
      body: ListView(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.searchController.searchInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter City Name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _searchWeather,
            child: Text('Search'),
          ),
          _searchResults.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_searchResults[index].name ?? 'No name'),
              );
            },
          )
              : Center(child: Text('No results found')),
        ],
      ),
    );
  }
}
