import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/themenotifier_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_forge/ui/screen/login_screen2.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkModeEnabled = false; // Track the dark mode preference

  @override
  void initState() {
    super.initState();
    retrieveDarkModePreference(); // Retrieve the dark mode preference on screen initialization
  }

  Future<void> retrieveDarkModePreference() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    final userSnapshot = await userRef.get();
    final darkMode = userSnapshot.data()?['darkModeEnabled'] ?? false;

    setState(() {
      darkModeEnabled = darkMode;
    });
  }

  Future<void> updateDarkModePreference(bool enabled, ThemeNotifier themeNotifier) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await userRef.update({
      'darkModeEnabled': enabled,
    });

    setState(() {
      darkModeEnabled = enabled;
    });

    // Update the theme based on the dark mode preference
    themeNotifier.setTheme(enabled ? ThemeData.dark() : ThemeData.light());
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: darkModeEnabled,
              onChanged: (value) => updateDarkModePreference(value, themeNotifier),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen2()),
              );
            },
            child: Text('Logout'),
          ),
        ),
      ],
    );
  }
}
