import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/badges_description_screen.dart';
import 'package:flutter/material.dart';

class Achievement {
  String title;
  bool isCompleted;
  String status;
  String imagePath;

  Achievement({
    required this.title,
    this.isCompleted = false,
    required this.status,
    required this.imagePath,
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

class BadgesScreen extends StatefulWidget {
  // final int totalWorkouts;
  // final int challengeCount;

  // BadgesScreen({
  //   // required this.totalWorkouts,
  //   // required this.challengeCount,
  // });

  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  String username = '';
  int achievementsCompleted = 0;
  int totalWorkouts = 0;
  int challengeCount = 0;
  List<Achievement> achievements = [
    Achievement(
      title: 'Complete a Workout',
      status: 'Not Started',
      imagePath: 'images/badgeb1.png',
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

  @override
  void initState() {
    super.initState();
    retrieveUserData();
    subscribeToAchievements();
  }

  Future<void> retrieveUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

      if (userSnapshot.exists) {
        setState(() {
          username = userSnapshot.get('username') as String;
          totalWorkouts = userSnapshot.get('count') as int;
          challengeCount = userSnapshot.get('challengeCount') as int;

        });
      }
    }
  }

  void subscribeToAchievements() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance.collection('achievements').doc(currentUser.uid).snapshots().listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.exists) {
          setState(() {
            List<dynamic> achievementsData = snapshot.data()!['achievements'];
            achievementsCompleted = achievementsData.where((achievement) => achievement['status'] == 'Completed' && achievement['isCompleted'] == true).length;

            // Update the isCompleted property for each achievement in the list
            for (int i = 0; i < achievements.length; i++) {
              Achievement achievement = achievements[i];
              achievement.isCompleted = achievementsData[i]['isCompleted'] == true;
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalActivitiesCompleted = totalWorkouts + challengeCount; // Sum of totalWorkouts and challengeCount

    // Check if the first, second, and third achievements are completed and isCompleted is true
    bool isFirstAchievementCompleted = achievements[0].isCompleted;
    bool isSecondAchievementCompleted = achievements[1].isCompleted;
    bool isThirdAchievementCompleted = achievements[2].isCompleted;
    // Check if the fourth, fifth, and sixth achievements are completed and isCompleted is true
    bool isFourthAchievementCompleted = achievements[3].isCompleted;
    bool isFifthAchievementCompleted = achievements[4].isCompleted;
    bool isSixthAchievementCompleted = achievements[5].isCompleted;

    return Scaffold(
      appBar: AppBar(
        title: Text('Badges Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/rank.png'),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(username),
                        SizedBox(height: 16.0),
                        Text(
                          'Total Activities Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(totalActivitiesCompleted.toString()),
                        SizedBox(height: 16.0),
                        Text(
                          'Achievements/Badges Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(achievementsCompleted.toString()),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Lists of each badge:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Workout Medals',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isFirstAchievementCompleted
                                  ? Colors.transparent
                                  : Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(achievements[0].imagePath),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isSecondAchievementCompleted
                                  ? Colors.transparent
                                  : Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(achievements[1].imagePath),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isThirdAchievementCompleted
                                  ? Colors.transparent
                                  : Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(achievements[2].imagePath),
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Challenge Medals',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isFourthAchievementCompleted
                                  ? Colors.transparent
                                  : Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(achievements[3].imagePath),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isFifthAchievementCompleted
                                  ? Colors.transparent
                                  : Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(achievements[4].imagePath),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isSixthAchievementCompleted
                                  ? Colors.transparent
                                  : Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Image.asset(achievements[5].imagePath),
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BadgesDescriptionScreen(),
                    ),
                  );
                },
                child: Text('View Badges requirements'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
