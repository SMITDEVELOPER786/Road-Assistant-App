import 'package:accidentapp/Company%20Side/ServiceProvide.dart';
import 'package:accidentapp/Company%20Side/tow_service.dart';
import 'package:accidentapp/SplashScreen.dart';
import 'package:accidentapp/User%20Side/VerificationCode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Splashscreen(),
      ),
    );
  }
}
