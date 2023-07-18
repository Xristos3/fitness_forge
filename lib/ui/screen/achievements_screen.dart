import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Achievement {
  String title;
  bool isCompleted;
  String status;

  Achievement({
    required this.title,
    this.isCompleted = false,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'status': status,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      title: map['title'],
      isCompleted: map['isCompleted'],
      status: map['status'],
    );
  }
}

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> _achievementsCollection =
  FirebaseFirestore.instance.collection('achievements');

  List<Achievement> achievements = [
    // Achievement(
    //   title: 'Complete a Workout',
    //   status: 'Not Started',
    // ),
    // Achievement(
    //   title: 'Complete 3 Workouts',
    //   status: 'Not Started',
    // ),
    // Achievement(
    //   title: 'Complete 5 Workouts',
    //   status: 'Not Started',
    // ),
    // Achievement(
    //   title: 'Complete a Challenge',
    //   status: 'Not Started',
    // ),
    // Achievement(
    //   title: 'Complete 3 Challenges',
    //   status: 'Not Started',
    // ),
    // Achievement(
    //   title: 'Complete 5 Challenges',
    //   status: 'Not Started',
    // ),
  ];

  @override
  void initState() {
    super.initState();
    loadAchievements();
  }

  Future<String> getUserId() async {
    final user = await FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  Future<void> loadAchievements() async {
    final userId = await getUserId();
    final achievementsSnapshot =
    await _achievementsCollection.doc(userId).get();

    if (achievementsSnapshot.exists) {
      final data = achievementsSnapshot.data()!;
      final List<dynamic> achievementsData = data['achievements'];
      achievements = achievementsData
          .map((achievement) => Achievement.fromMap(achievement))
          .toList();
    } else {
      achievements = [
        Achievement(
          title: 'Complete a Workout',
          status: 'Not Started',
        ),
        Achievement(
          title: 'Complete 3 Workouts',
          status: 'Not Started',
        ),
        Achievement(
          title: 'Complete 5 Workouts',
          status: 'Not Started',
        ),
        Achievement(
          title: 'Complete a Challenge',
          status: 'Not Started',
        ),
        Achievement(
          title: 'Complete 3 Challenges',
          status: 'Not Started',
        ),
        Achievement(
          title: 'Complete 5 Challenges',
          status: 'Not Started',
        ),
      ];

      await saveAchievements();
    }

    setState(() {
      checkAndUpdateAchievements();
    });
  }

  Future<void> saveAchievements() async {
    final userId = await getUserId();
    final achievementsData =
    achievements.map((achievement) => achievement.toMap()).toList();

    await _achievementsCollection.doc(userId).set({
      'achievements': achievementsData,
    });
  }

  Future<void> checkAndUpdateAchievements() async {
    if (achievements.isNotEmpty) {
      final firstAchievement = achievements.first;
      if (firstAchievement.title == 'Complete a Workout') {
        final userId = await getUserId();
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final count = userData['count'];

          if (count >= 1) {
            firstAchievement.isCompleted = true;
            firstAchievement.status = 'Completed';
            await saveAchievements();
          }
        }
      }
      final secondAchievement = achievements[1]; // Get the second achievement
      if (secondAchievement.title == 'Complete 3 Workouts') {
        final userId = await getUserId();
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final count = userData['count'];

          if (count >= 3) {
            secondAchievement.isCompleted = true;
            secondAchievement.status = 'Completed';
            await saveAchievements();
          }
        }
      }
      final thirdAchievement = achievements[2]; // Get the second achievement
      if (thirdAchievement.title == 'Complete 5 Workouts') {
        final userId = await getUserId();
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final count = userData['count'];

          if (count >= 5) {
            thirdAchievement.isCompleted = true;
            thirdAchievement.status = 'Completed';
            await saveAchievements();
          }
        }
      }
      final fourthAchievement = achievements[3]; // Get the second achievement
      if (fourthAchievement.title == 'Complete a Challenge') {
        final userId = await getUserId();
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final challengecount = userData['challengeCount'];

          if (challengecount >= 1) {
            fourthAchievement.isCompleted = true;
            fourthAchievement.status = 'Completed';
            await saveAchievements();
          }
        }
      }
      final fifthAchievement = achievements[4]; // Get the second achievement
      if (fifthAchievement.title == 'Complete 3 Challenges') {
        final userId = await getUserId();
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final challengecount = userData['challengeCount'];

          if (challengecount >= 3) {
            fifthAchievement.isCompleted = true;
            fifthAchievement.status = 'Completed';
            await saveAchievements();
          }
        }
      }
      final sixthAchievement = achievements[5]; // Get the second achievement
      if (sixthAchievement.title == 'Complete 5 Challenges') {
        final userId = await getUserId();
        final userDoc = await _firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          final challengecount = userData['challengeCount'];

          if (challengecount >= 5) {
            sixthAchievement.isCompleted = true;
            sixthAchievement.status = 'Completed';
            await saveAchievements();
          }
        }
      }
    }
  }

  Future<void> updateFirestore() async {
    await saveAchievements();
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Achievements updated in Firestore.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: achievements[index].isCompleted
                    ? Colors.green
                    : Colors.transparent,
                border: Border.all(color: Colors.black),
              ),
              child: achievements[index].isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            title: Text(achievements[index].title),
            subtitle: Text('Status: ${achievements[index].status}'),
            onTap: null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateFirestore,
        child: Icon(Icons.update),
      ),
    );
  }
}
