import 'package:fitness_forge/ui/screen/newforgotpassword_screen.dart';
import 'package:fitness_forge/ui/screen/newsignup_screen2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_forge/ui/screen/forgotpassword_screen.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:fitness_forge/ui/screen/signup_screen2.dart';
import 'package:fitness_forge/ui/screen/guest_homescreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewLoginScreen extends StatefulWidget {
  @override
  _NewLoginScreenState createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
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

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          // Update rememberMe field in Firestore if remember me is checked
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .update({'rememberMe': _rememberMe});

          // Login successful, navigate to a new screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      } catch (e) {
        // Login failed, handle the error
        print('Login failed: $e');
        setState(() {
          _errorMessage = 'Invalid credentials';
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
      MaterialPageRoute(builder: (context) => NewSignupScreen()),
    );
  }

  void _navigateToForgotPassword() {
    // Navigate to the forgot password screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewForgotPasswordScreen()),
    );
  }

  void _navigateToGuestScreen() {
    // Navigate to the guest screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GuestHomeScreen()),
    );
  }

  void _loadRememberMeValue(String email) async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get();

    if (userData.exists) {
      bool rememberMe = userData['rememberMe'] ?? false;
      setState(() {
        _rememberMe = rememberMe;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Retrieve the current user's email from Firebase Authentication
    String currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    _loadRememberMeValue(currentUserEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? Center(
        child: SpinKitDualRing(
          color: Colors.blue,
          size: 45.0,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration:
                  InputDecoration(labelText: 'Email or Username'),
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
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
