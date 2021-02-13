import 'package:chef/screens.dart/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // لمنع الهاتف من القلب
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
