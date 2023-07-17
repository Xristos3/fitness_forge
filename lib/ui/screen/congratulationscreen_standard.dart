import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/profile_screen.dart';

class CongratulationsScreen extends StatelessWidget {
  Future<void> _updateWorkoutCounter(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated or there is no current user.
      // Handle this case accordingly.
      return;
    }

    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDoc = userCollection.doc(user.uid);

    // Update the workout counter
    userDoc.update({
      'count': FieldValue.increment(1),
    }).then((value) {
      print('Workout counter updated successfully');

      // Fetch the updated workout counter value
      userDoc.get().then((docSnapshot) {
        final userData = docSnapshot.data() as Map<String, dynamic>?;
        final workoutCount = userData?['count'] ?? 0;

        // Navigate back to the ProfileScreen with the updated workout counter value
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(totalWorkouts: workoutCount),
          ),
        );
      });
    }).catchError((error) {
      print('Failed to update workout counter: $error');
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
                await _updateWorkoutCounter(context);
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
