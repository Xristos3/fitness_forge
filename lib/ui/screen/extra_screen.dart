import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';

class ExtraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Difficulty'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Achievements',
            image: 'images/achievements.png',
          ),
          CustomRightAlignedContainer(
            title: 'Challenges',
            image: 'images/challenges.png',
          ),
          CustomRightAlignedContainer(
            title: 'Badges',
            image: 'images/badges.jpeg',
          ),
        ],
      ),
    );
  }
}

class CustomRightAlignedContainer extends StatelessWidget {
  final String title;
  final String image;

  const CustomRightAlignedContainer({
    required this.title,
    required this.image,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavigationScreen()), // Replace NewScreen with the desired screen to navigate to
                    );
                  },
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