import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen2 extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen2> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false; // Add a isLoading variable to track the loading state

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _emailError = '';
  String _usernameError = '';

  Future<bool> _checkIfUserExists(String field, String value) async {
    final snapshot = await _firestore
        .collection('users')
        .where(field, isEqualTo: value)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  void _signUp() async {
    try {
      setState(() {
        _emailError = '';
        _usernameError = '';
        _isLoading = true; // Show the loader when the request starts
      });

      bool emailExists = await _checkIfUserExists('email', _emailController.text.trim());
      bool usernameExists = await _checkIfUserExists('username', _usernameController.text.trim());

      if (emailExists) {
        setState(() {
          _emailError = 'Email already exists';
          _isLoading = false; // Hide the loader if an error occurs
        });
        return;
      }

      if (usernameExists) {
        setState(() {
          _usernameError = 'Username already exists';
          _isLoading = false; // Hide the loader if an error occurs
        });
        return;
      }

      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        print('Signup successful');
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      print('Signup failed: $e');
      // You can display an error message or perform other actions here
    } finally {
      setState(() {
        _isLoading = false; // Hide the loader when the request is finished
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailError.isNotEmpty ? _emailError : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  errorText: _usernameError.isNotEmpty ? _usernameError : null,
                ),
              ),
              SizedBox(height: 16.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password (must contain 6 or more characters)',
                    ),
                    obscureText: !_passwordVisible,
                  ),
                  IconButton(
                    icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp, // Disable the button when isLoading is true
                child: _isLoading ? CircularProgressIndicator() : Text('Sign up'), // Show the loader if isLoading is true
              ),
            ],
          ),
        ),
      ),
    );
  }
}
