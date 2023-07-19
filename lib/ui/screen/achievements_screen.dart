import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Achievement {
  String title;
  bool isCompleted;
  String status;
  String imagePath; // New property for the image path

  Achievement({
    required this.title,
    this.isCompleted = false,
    required this.status,
    required this.imagePath, // Initialize the image path
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'status': status,
      'imagePath': imagePath,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      title: map['title'],
      isCompleted: map['isCompleted'],
      status: map['status'],
      imagePath: map['imagePath'],
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

  List<Achievement> achievements = [];

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
    final achievementsSnapshot = await _achievementsCollection.doc(userId).get();

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
          imagePath: 'images/badgeb1.png', // Set the image path for each achievement
        ),
        Achievement(
          title: 'Complete 3 Workouts',
          status: 'Not Started',
          imagePath: 'images/badges2.png',
        ),
        Achievement(
          title: 'Complete 5 Workouts',
          status: 'Not Started',
          imagePath: 'images/badgeg3.png',
        ),
        Achievement(
          title: 'Complete a Challenge',
          status: 'Not Started',
          imagePath: 'images/badgeb1.png',
        ),
        Achievement(
          title: 'Complete 3 Challenges',
          status: 'Not Started',
          imagePath: 'images/badges2.png',
        ),
        Achievement(
          title: 'Complete 5 Challenges',
          status: 'Not Started',
          imagePath: 'images/badgeg3.png',
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
      final userId = await getUserId();
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final count = userData['count'];
        final challengeCount = userData['challengeCount'];

        // Update the isCompleted and status properties for each achievement in the list
        for (int i = 0; i < achievements.length; i++) {
          Achievement achievement = achievements[i];
          if (achievement.title == 'Complete a Workout') {
            achievement.isCompleted = count >= 1;
          } else if (achievement.title == 'Complete 3 Workouts') {
            achievement.isCompleted = count >= 3;
          } else if (achievement.title == 'Complete 5 Workouts') {
            achievement.isCompleted = count >= 5;
          } else if (achievement.title == 'Complete a Challenge') {
            achievement.isCompleted = challengeCount >= 1;
          } else if (achievement.title == 'Complete 3 Challenges') {
            achievement.isCompleted = challengeCount >= 3;
          } else if (achievement.title == 'Complete 5 Challenges') {
            achievement.isCompleted = challengeCount >= 5;
          }

          achievement.status =
          achievement.isCompleted ? 'Completed' : 'Not Started';
        }

        await saveAchievements();
        setState(() {});
      }
    }
  }

  Future<void> updateFirestore() async {
    await saveAchievements();
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
          final achievement = achievements[index];
          return ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: achievement.isCompleted ? Colors.green : Colors.transparent,
                border: Border.all(color: Colors.black),
              ),
              child: achievement.isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            title: Text(achievement.title),
            subtitle: Text('Status: ${achievement.status}'),
            trailing: ClipOval(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey, // Apply a grey color filter when not completed
                  achievement.isCompleted ? BlendMode.dst : BlendMode.saturation,//srcOver
                ),
                child: Image.asset(
                  achievement.imagePath,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
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
