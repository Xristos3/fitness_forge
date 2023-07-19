import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/badges_description_screen.dart';
import 'package:flutter/material.dart';

class BadgesScreen extends StatefulWidget {
  final int totalWorkouts;
  final int challengeCount;

  BadgesScreen({
    required this.totalWorkouts,
    required this.challengeCount,
  });

  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  String username = '';
  int achievementsCompleted = 0;

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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          username = userSnapshot.get('username') as String;
        });
      }
    }
  }

  void subscribeToAchievements() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('achievements')
          .doc(currentUser.uid)
          .snapshots()
          .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.exists) {
          setState(() {
            List<dynamic> achievementsData = snapshot.data()!['achievements'];
            achievementsCompleted = achievementsData
                .where((achievement) =>
            achievement['status'] == 'Completed' &&
                achievement['isCompleted'] == true)
                .length;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalActivitiesCompleted =
        widget.totalWorkouts + widget.challengeCount; // Sum of totalWorkouts and challengeCount

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
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badgeb1.png'),
                        ),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badges2.png'),
                        ),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badgeg3.png'),
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
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badgeb1.png'),
                        ),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badges2.png'),
                        ),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badgeg3.png'),
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
