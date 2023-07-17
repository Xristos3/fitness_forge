import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/badges_description_screen.dart';
import 'package:flutter/material.dart';

class BadgesScreen extends StatefulWidget {
  final int totalWorkouts;
  final int totalChallengesCompleted;

  BadgesScreen({
    required this.totalWorkouts,
    required this.totalChallengesCompleted,
  });

  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  String username = '';
  int totalBadges = 0;
  int achievementsCompleted = 0;
  List<String> recentBadges = [];
  List<Map<String, dynamic>> activeBadges = [
    // List to store non-greyed out badges and their text
    {
      'image': 'images/badge1.PNG',
      'text': 'Level 1',
    },
    {
      'image': 'images/badge2.PNG',
      'text': 'Level 2',
    },
    // Add more badges and text here as needed
  ];

  @override
  void initState() {
    super.initState();
    retrieveUsername();
    subscribeToAchievements();
  }

  Future<void> retrieveUsername() async {
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
        widget.totalWorkouts + widget.totalChallengesCompleted;

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
                          'Total Badges:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(totalBadges.toString()),
                        SizedBox(height: 16.0),
                        Text(
                          'Total Activities Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(totalActivitiesCompleted.toString()),
                        SizedBox(height: 16.0),
                        Text(
                          'Achievements Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(achievementsCompleted.toString()),
                        SizedBox(height: 16.0),
                        Text(
                          'Active Badges:', // Display active badges
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 120.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: activeBadges.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 60.0,
                                      width: 60.0,
                                      child: Image.asset(
                                        activeBadges[index]['image'],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(activeBadges[index]['text']),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
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
                          'Engagement',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge1.PNG'),
                        ),
                        Text('Level 1'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge1.PNG'),
                        ),
                        Text('Level 2'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge1.PNG'),
                        ),
                        Text('Level 3'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge1.PNG'),
                        ),
                        Text('Level 4'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge1.PNG'),
                        ),
                        Text('Level 5'),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Activity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge2.PNG'),
                        ),
                        Text('Level 1'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge2.PNG'),
                        ),
                        Text('Level 2'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge2.PNG'),
                        ),
                        Text('Level 3'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge2.PNG'),
                        ),
                        Text('Level 4'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge2.PNG'),
                        ),
                        Text('Level 5'),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Achievements',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge3.PNG'),
                        ),
                        Text('Level 1'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge3.PNG'),
                        ),
                        Text('Level 2'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge3.PNG'),
                        ),
                        Text('Level 3'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge3.PNG'),
                        ),
                        Text('Level 4'),
                        SizedBox(height: 8.0),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          child: Image.asset('images/badge3.PNG'),
                        ),
                        Text('Level 5'),
                      ],
                    ),
                  ),
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
