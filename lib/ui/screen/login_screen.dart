import 'package:fitness_forge/ui/screen/changepassword_screen.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:fitness_forge/ui/screen/signin_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
                Text('Remember Me'),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Add logic for "Forgot Password" functionality
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordChangeScreen()),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Add logic for navigating to the new screen here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: Text('Create a New Account'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add login validation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}