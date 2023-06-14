
import 'package:demo1/cloth_donation.dart';
import 'package:demo1/login.dart';
import 'package:demo1/members.dart';

import 'package:demo1/registration.dart';
import 'package:demo1/splash.dart';
import 'package:demo1/welcome.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'adoption.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'EBGaramond',
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      //home: Adoption(),
      home: SplashScreen(),
    );
  }
}

class GoogleFonts {
}