import 'package:fitness_forge/ui/screen/login_screen2.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your settings content here
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: double.infinity, // Set width to occupy the whole screen
          child: ElevatedButton(
            onPressed: () {
              // Logout button logic
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
