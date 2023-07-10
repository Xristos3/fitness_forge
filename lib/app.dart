import 'package:fitness_forge/ui/screen/congratulationscreen_standard.dart';
import 'package:fitness_forge/ui/screen/splash_screen.dart';
import 'package:fitness_forge/ui/screen/themenotifier_screen.dart';
import 'package:fitness_forge/ui/screen/workouttesting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FitnessForgeApp extends StatelessWidget {
  const FitnessForgeApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, _) {
    return MaterialApp(
      title: 'Fitness Forge App',
      theme: themeNotifier.getTheme(), // Default light theme// Use system theme as default
      home: CountdownTimer(title: 'Jumping Jacks', description: 'Begin by standing with your legs straight and your arms to your sides. '
          'Jump up and spread your feet beyond hip-width apart while bringing your arms above your head,'
          ' nearly touching. Jump again, lowering your arms and bringing your legs together. Return to your starting position.', imagePath: 'images/jjs.jpeg', nextScreen: CongratulationsScreen(),),
    );
  }
    );
}
}

