import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.lightBlue[800],
              title: Text(
                "الصفحة الرئيسية",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
