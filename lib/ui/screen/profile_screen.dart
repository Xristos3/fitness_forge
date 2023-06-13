import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int weight = 0;
  int height = 0;
  int totalWorkouts = 0;
  int totalChallengesCompleted = 0;
  String nextfitnessgoal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile.jpeg'),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        weight = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Height:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        height = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Total Workouts:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        totalWorkouts = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Total Challenges Completed:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        totalChallengesCompleted = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Next Fitness Goal:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        nextfitnessgoal = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}