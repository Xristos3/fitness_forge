import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  bool showPassword = false; // Added variable to toggle password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailOrUsernameController,
              decoration: InputDecoration(
                labelText: 'Email or Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password (must contain 6 or more characters)',
                suffixIcon: IconButton(
                  icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
              obscureText: !showPassword, // Toggle password visibility
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                resetPassword(context, emailOrUsernameController.text, newPasswordController.text);
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(BuildContext context, String emailOrUsername, String newPassword) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot;

      if (emailOrUsername.contains('@')) {
        querySnapshot = await userRef.where('email', isEqualTo: emailOrUsername).get();
      } else {
        querySnapshot = await userRef.where('username', isEqualTo: emailOrUsername).get();
      }

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        final email = userDoc['email'] as String;

        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        await userRef.doc(userDoc.id).update({'password': newPassword});

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Reset'),
              content: Text('An email was sent to $emailOrUsername. Please enter the new password again through the link before you log in again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('User not found'),
              content: Text('The provided email or username does not exist.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset Failed'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
