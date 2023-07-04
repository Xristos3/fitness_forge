import 'package:flutter/material.dart';
import 'package:fitness_forge/ui/screen/login_screen2.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
      ),
    );
  }
}
