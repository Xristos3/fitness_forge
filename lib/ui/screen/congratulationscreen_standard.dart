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

      // Check if the count is a multiple of 3 and update the first achievement status
      if (newCount % 3 == 0) {
        final achievementsCollection = FirebaseFirestore.instance.collection('achievements');
        final achievementSnapshot = await achievementsCollection.doc(user.uid).get();
        if (achievementSnapshot.exists) {
          final achievementData = achievementSnapshot.data()!;
          final List<dynamic> achievementsList = achievementData['achievements'];
          if (achievementsList.isNotEmpty) {
            final firstAchievement = achievementsList[0];
            if (firstAchievement['status'] != 'Completed') {
              firstAchievement['status'] = 'Completed';
              firstAchievement['isCompleted'] = true;

              achievementsCollection.doc(user.uid).update({
                'achievements': achievementsList,
              });

              // Give respective points to the user when the achievement is completed
              final achievementPoints = firstAchievement['points'];
              final userSnapshot = await transaction.get(userDoc);
              final currentPoints = userSnapshot.data()!['points'] ?? 0;
              final newPoints = currentPoints + achievementPoints;

              transaction.update(userDoc, {'points': newPoints});

              // Update the points field in the users collection for the current user
              final usersCollection = FirebaseFirestore.instance.collection('users');
              usersCollection.doc(user.uid).update({
                'points': newPoints,
              });
            }
          }
        }
      }
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
