import 'package:fitness_forge/ui/screen/achievements_screen.dart';
import 'package:flutter/material.dart';

class SelectDifficultyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Difficulty'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Easy',
            description: 'Composed of basic callisthenic exercises to help you start your fitness journey ',
            image: 'images/custom.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Medium',
            description: 'Composed of more advanced versions of basic callisthenic exercises ',
            image: 'images/custom.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Hard',
            description: 'Test your limits with exercises that will push your muscles to new levels',
            image: 'images/custom.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomRightAlignedContainer extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final VoidCallback onPressed;

  const CustomRightAlignedContainer({
    required this.title,
    required this.description,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text('Select'),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}