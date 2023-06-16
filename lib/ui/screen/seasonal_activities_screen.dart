import 'package:fitness_forge/ui/screen/achievements_screen.dart';
import 'package:flutter/material.dart';

class SeasonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a season'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Spring',
            image: 'images/spring1.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Summer',
            image: 'images/summer1.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Fall',
            image: 'images/fall.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Winter',
            image: 'images/winter.png',
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
  final String image;
  final VoidCallback onPressed;

  const CustomRightAlignedContainer({
    required this.title,
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