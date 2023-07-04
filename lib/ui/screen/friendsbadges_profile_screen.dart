import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/badges_description_screen.dart';

class FriendsBadgesScreen extends StatefulWidget {
  final String friendId;

  const   FriendsBadgesScreen({required this.friendId});

  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<FriendsBadgesScreen> {
  String username = '';
  int numberOfPoints = 0;
  int totalBadges = 0;
  int totalActivitiesCompleted = 0;
  int achievementsCompleted = 0;

  List<String> recentBadges = [
    'images/badge1.PNG',
    'images/badge2.PNG',
    'images/badge3.PNG',
    'images/badge4.PNG',
    'images/badge4.PNG',
    'images/badge2.PNG',
    'images/badge3.PNG',
    'images/badge1.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

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
                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.friendId)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              String username = snapshot.data!['username'];

                              return Text(
                                username,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('No data available');
                            }
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Number of Points:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              numberOfPoints = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Total Badges:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              totalBadges = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Total Activities Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              totalActivitiesCompleted = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Achievements Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              achievementsCompleted = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Recent Badges Earned:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 80.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recentBadges.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Image.asset(recentBadges[index]),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BadgesDescriptionScreen(),
                    ),
                  );
                },
                child: Text('View Badges Requirements'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
