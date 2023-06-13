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
    Achievement(title: 'Achievement 1'),
    Achievement(title: 'Achievement 2'),
    Achievement(title: 'Achievement 3'),
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
