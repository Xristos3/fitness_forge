import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/newlogin_screen2.dart';
import 'package:flutter/material.dart';

class GuestSettingsScreen extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(),
      persistentFooterButtons: [
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _logout(context),
            child: Text('SignUp/Login'),
          ),
        ),
      ],
    );
  }
}
