import 'package:fitness_forge/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class FitnessForgeApp extends StatelessWidget {
  const FitnessForgeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Forge app',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}