import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:demo1/buttonnavigation.dart';
import 'package:demo1/homepage.dart';
import 'package:demo1/login.dart';
import 'package:demo1/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SharedPreferences localStorage;
 String user="user";
 String role="";
 late SharedPreferences preferences;

  Future<void> checkRoleAndNavigate() async {
    preferences = await SharedPreferences.getInstance();
    role = (preferences.getString("role") ?? '');

    if (role == user) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigation()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Welcome()));
    }
  }

@override
void initState() {
  super.initState();
  startTime();
}

startTime() async {
  var duration = new Duration(seconds: 3);
  return Timer(duration, checkRoleAndNavigate);
}
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginPage()
            )
        )
    );
  }*/
@override
Widget build(BuildContext context) {

  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0),
              child: Image.asset("image/adoption.jpg"),
            ),

          ]
      ),
    ),
  );

  // return Scaffold(
  //   body: AnimatedSplashScreen(
  //       splash: Center(child: Text('Angelwing',style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),)),
  //       nextScreen: Login(),
  //     splashTransition: SplashTransition.slideTransition,
  //     duration: 300000,
  //     backgroundColor: Colors.blue,
  //   ),
  // );
}
}