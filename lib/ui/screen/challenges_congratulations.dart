import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';

class ChallengesCongratulationsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateChallengeCount() async {
    final User? user = _auth.currentUser;
    final String? userId = user?.uid;

    if (userId != null) {
      final DocumentReference userRef =
      _firestore.collection('users').doc(userId);

      await _firestore.runTransaction((transaction) async {
        final DocumentSnapshot userSnapshot = await transaction.get(userRef);
        final int currentChallengeCount =
            (userSnapshot.data() as Map<String, dynamic>?)?['challengeCount'] ?? 0;

        transaction.update(userRef, {'challengeCount': currentChallengeCount + 1});
      });
    }
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
              'Congratulations on completing This Challenge',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateChallengeCount();
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
