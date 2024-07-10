import 'package:flutter/material.dart';
import 'package:weatherapp/screens/auth/login/login_view.dart';
import 'package:weatherapp/screens/test/view/postview.dart';
import 'package:weatherapp/screens/weather/home/weather_home_view.dart';
import 'package:weatherapp/screens/weather/search/search_weather_view.dart';
import 'package:weatherapp/screens/weather/search/search_weather_controller.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller here

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.overpassTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        // home: Postview()
      home: LoginView(),
        // home:const WeatherHomeView()

    );
  }
}
