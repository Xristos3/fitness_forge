import 'package:fitness_forge/ui/screen/guest_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_forge/ui/screen/forgotpassword_screen.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:fitness_forge/ui/screen/signup_screen2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen2 extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  String _errorMessage = '';
  bool _passwordVisible = false;
  bool _isLoading = false;

  void _loginWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String email = _usernameController.text.trim();
        String password = _passwordController.text;

        // Check if the input is an email or a username
        bool isEmail = email.contains('@');

        QuerySnapshot querySnapshot;
        if (isEmail) {
          querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();
        } else {
          querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: email)
              .limit(1)
              .get();
        }

        if (querySnapshot.size > 0) {
          QueryDocumentSnapshot docSnapshot = querySnapshot.docs.first;
          String storedPassword = docSnapshot['password'];

          if (password == storedPassword) {
            UserCredential userCredential;
            if (isEmail) {
              userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
            } else {
              userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: docSnapshot['email'], password: password);
            }

            // Login successful, navigate to a new screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            // Password doesn't match
            setState(() {
              _errorMessage = 'Invalid password';
            });
          }
        } else {
          // User not found
          setState(() {
            _errorMessage = 'User not found';
          });
        }
      } catch (e) {
        // Login failed, handle the error
        print('Login failed: $e');
        setState(() {
          _errorMessage = 'Error occurred during login';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
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

  void _navigateToGuestScreen() {
    // Navigate to the guest screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuestHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:  _isLoading
          ? Center(
        child: SpinKitDualRing(
          color: Colors.blue,
          size: 45.0,
        ),
      )
          :  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
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
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
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
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
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
                TextButton(
                  onPressed: _navigateToGuestScreen,
                  child: Text('Guest'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
