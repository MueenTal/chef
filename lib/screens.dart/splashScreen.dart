import 'dart:async';

import 'package:chef/screens.dart/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _loadSlpash() async {
    // Time (splash)
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login())));
  }

// ماذا يجب ان يفعل التطبيق عند فتح هذه الصفحة
  @override
  void initState() {
    _loadSlpash();
    Firebase.initializeApp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splash.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
        ],
      ),
    ));
  }
}
