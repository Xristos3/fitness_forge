import 'package:fitness_forge/ui/screen/forgotpassword_screen.dart';
import 'package:fitness_forge/ui/screen/signup_screen2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen2 extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  void _loginWithCredentials() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '${_usernameController.text.trim()}@example.com',
          password: _passwordController.text,
        );

        // Login successful, do something
        print('User logged in: ${userCredential.user!.email}');

        if (_rememberMe) {
          // Save login credentials locally for future use
          // You can use shared preferences or secure storage packages for this
        }
      } catch (e) {
        // Login failed, handle the error
        print('Login failed: $e');
      }
    }
  }

  void _navigateToSignUp() {
    // Navigate to the sign-up screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen2()),
    );
  }

  void _navigateToForgotPassword() {
    // Navigate to the forgot password screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  Text('Remember Me'),
                ],
              ),
              ElevatedButton(
                onPressed: _loginWithCredentials,
                child: Text('Login'),
              ),
              TextButton(
                onPressed: _navigateToSignUp,
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: _navigateToForgotPassword,
                child: Text('Forgot Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


