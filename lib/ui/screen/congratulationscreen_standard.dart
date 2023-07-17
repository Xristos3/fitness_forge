import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CongratulationsScreen extends StatelessWidget {
  Future<void> _updateFirstAchievement() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated or there is no current user.
      // Handle this case accordingly.
      return;
    }

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

          await achievementsCollection.doc(user.uid).update({'achievements': achievementsList});
        }
      }
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
              'Congratulations on completing your workout!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _updateFirstAchievement();
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
