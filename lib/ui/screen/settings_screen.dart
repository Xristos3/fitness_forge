import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/about.dart';
import 'package:fitness_forge/ui/screen/newlogin_screen2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fitness_forge/ui/screen/themenotifier_screen.dart';

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

  Future<bool?> showLogoutConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            child: Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
              bool? confirmed = await showLogoutConfirmation(context);
              if (confirmed == true) {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NewLoginScreen()),
                );
              }
            },
            child: Text('Logout'),
          ),
        ),
      ],
    );
  }
}
