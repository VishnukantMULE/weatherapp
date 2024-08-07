// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather/home/weather_home_view.dart';


import '../register/register_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _useridcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Center(
          child: Text("Weather App"),
        ),

      ),
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(40),
        child: ListView(
          children: [
            Container(
              height: 70,
            ),

            // Image.asset('assets/images/loginbg.png'),
            Container(
              height: 40,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter User Id",
              ),
              controller: _useridcontroller,
            ),
            Container(
              height: 40,
            ),
            TextField(
              obscureText: true,
              // enableSuggestions: false,
              // autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Your Password",
              ),
              controller: _passwordcontroller,
            ),
            Container(
              height: 30,
            ),
            Row(
              children: [
                const Text("Dont have an account ? please"),
                TextButton(onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterView()));
                }, child: const Text("Regiter"))
              ],
            ),

            Container(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {



                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WeatherHomeView(cityName: '',)));
                // _controller.updateuserId(_useridcontroller.text);
                // _controller.updatePassword(_passwordcontroller.text);
                // if(_controller.validateuser())
                // {
                //
                // }
                // else
                // {
                //
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black),
                ),
              ),
              child: const Text(
                "Login",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}