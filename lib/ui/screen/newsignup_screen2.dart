import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';
class NewSignupScreen extends StatefulWidget {
  @override
  _NewSignupScreenState createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _emailError = '';
  String _usernameError = '';
  String _passwordError = '';

  RegExp _passwordRegex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

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
        _passwordError = '';
        _isLoading = true;
      });

      bool emailExists = await _checkIfUserExists('email', _emailController.text.trim());
      bool usernameExists = await _checkIfUserExists('username', _usernameController.text.trim());

      if (_emailController.text.isEmpty) {
        setState(() {
          _emailError = 'Email is required';
          _isLoading = false;
        });
        return;
      }

      if (emailExists) {
        setState(() {
          _emailError = 'Email already exists';
          _isLoading = false;
        });
        return;
      }

      if (_usernameController.text.isEmpty) {
        setState(() {
          _usernameError = 'Username is required';
          _isLoading = false;
        });
        return;
      }

      if (usernameExists) {
        setState(() {
          _usernameError = 'Username already exists';
          _isLoading = false;
        });
        return;
      }

      String password = _passwordController.text.trim();
      if (password.isEmpty) {
        setState(() {
          _passwordError = 'Password is required';
          _isLoading = false;
        });
        return;
      } else if (!_passwordRegex.hasMatch(password)) {
        setState(() {
          _passwordError =
          'Password must contain 8 or more characters, at least 1 uppercase letter, 1 number, and 1 symbol';
          _isLoading = false;
        });
        return;
      }

      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        print('Signup successful');
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
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
        _isLoading = false;
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
                onChanged: (value) {
                  setState(() {
                    _emailError = value.isEmpty ? 'Email is required' : '';
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  errorText: _usernameError.isNotEmpty ? _usernameError : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _usernameError = value.isEmpty ? 'Username is required' : '';
                  });
                },
              ),
              SizedBox(height: 16.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password (must contain 8 or more characters, at least 1 uppercase letter, 1 number, and 1 symbol)',
                      errorText: _passwordError.isNotEmpty ? _passwordError : null,
                    ),
                    obscureText: !_passwordVisible,
                    onChanged: (value) {
                      setState(() {
                        if (!_passwordRegex.hasMatch(value)) {
                          _passwordError =
                          'Password must contain 8 or more characters, at least 1 uppercase letter, 1 number, and 1 symbol';
                        } else {
                          _passwordError = '';
                        }
                      });
                    },
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
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading ? CircularProgressIndicator() : Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

