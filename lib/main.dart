import 'package:flutter/material.dart';
import 'package:weatherapp/screens/auth/login/login_view.dart';

import 'package:google_fonts/google_fonts.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller here

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.overpassTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        // home: Postview()
      home: const LoginView(),
        // home:const WeatherHomeView()

    );
  }
}
