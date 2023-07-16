import 'package:flutter/material.dart';

class Achievement {
  String title;
  bool isCompleted;

  Achievement({required this.title, this.isCompleted = false});
}

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  List<Achievement> achievements = [
    Achievement(title: 'Complete a workout'),
    Achievement(title: 'Complete a challenge'),
    Achievement(title: 'Complete an advanced workout'),
    Achievement(title: 'Have a total of 3 friends'),
    Achievement(title: '5 Advanced Workouts'),
    Achievement(title: '3 Challenges'),
    Achievement(title: '10 Standard Workouts'),
    Achievement(title: 'Add an event'),
    Achievement(title: 'View Friend Profile'),
    Achievement(title: 'Have a total of 5 friends'),
  ];

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
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  achievements[index].isCompleted = !achievements[index].isCompleted;
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achievements[index].isCompleted ? Colors.green : Colors.transparent,
                  border: Border.all(color: Colors.black),
                ),
                child: achievements[index].isCompleted
                    ? Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
            ),
            title: Text(achievements[index].title),
          );
        },
      ),
    );
  }
}
