import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fitness_forge/ui/screen/home_screen.dart';

class CongratulationsScreen extends StatelessWidget {
  Future<void> _incrementCount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated or there is no current user.
      // Handle this case accordingly.
      return;
    }

    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      final currentCount = snapshot.data()!['count'] ?? 0;
      final newCount = currentCount + 1;

      transaction.update(userDoc, {'count': newCount});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations on completing your workout!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _incrementCount();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: Text(
                'Done',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


