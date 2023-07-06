import 'package:fitness_forge/ui/screen/splash_screen.dart';
import 'package:fitness_forge/ui/screen/themenotifier_screen.dart';
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
      home: SplashScreen(),
    );
  }
    );
}
}

