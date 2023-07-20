import 'dart:async';
import 'package:fitness_forge/ui/screen/login_screen2.dart';
import 'package:fitness_forge/ui/screen/newlogin_screen2.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // After 3 seconds, navigate to the login screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => NewLoginScreen()),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue, // Set the background color
        body: Center(
          child: Text(
            'Fitness Forge',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}