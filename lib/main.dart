import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_forge/app.dart';
import 'package:flutter/material.dart';
import 'package:fitness_forge/ui/screen/themenotifier_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(ThemeData.light()),
          child:      const FitnessForgeApp()
      )
  );
}