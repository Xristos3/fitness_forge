import 'package:fitness_forge/ui/screen/forgotpassword_screen.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:fitness_forge/ui/screen/signup_screen2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen2 extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  void _loginWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        String identifier = _identifierController.text.trim();
        String password = _passwordController.text;

        QuerySnapshot emailQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: identifier)
            .limit(1)
            .get();

        QuerySnapshot usernameQuerySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: identifier)
            .limit(1)
            .get();

        List<QueryDocumentSnapshot> documents = [
          ...emailQuerySnapshot.docs,
          ...usernameQuerySnapshot.docs,
        ];

        if (documents.isNotEmpty) {
          QueryDocumentSnapshot docSnapshot = documents.first;
          String? email = (docSnapshot.data() as Map<String, dynamic>)['email'] as String?;


          if (email != null) {
            UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password,
            );

            // Login successful, navigate to a new screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
            );
          } else {
            // Email is null for the retrieved document
            print('Email not found for the user');
          }
        } else {
          // User not found with the provided email/username
          print('User not found');
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
                controller: _identifierController,
                decoration: InputDecoration(labelText: 'Email or Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email or username';
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
                onPressed: _loginWithEmailAndPassword,
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










