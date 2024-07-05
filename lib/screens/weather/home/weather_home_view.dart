import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({super.key});

  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff29b6f6),
      appBar: AppBar(
        backgroundColor: Color(0xff29b6f6),
        leading: Icon(MdiIcons.mapMarker,size: 35,color: Colors.white,),
        title: Row(
          children: [Text('Thane   ',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),Icon(Icons.arrow_drop_down,color: Colors.white,size: 30,)],
        ),
        actions: [
          Icon(MdiIcons.bellAlert,size: 35,color: Colors.white,)
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x47BFDFFF), Color(0x4A91FFFF)],
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
          ),
        ),
        child: SizedBox.expand(), // This makes the Container fill its parent
      ),

    );
  }
}
