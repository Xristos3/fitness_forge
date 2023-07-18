import 'package:fitness_forge/ui/screen/achievements_screen.dart';
import 'package:fitness_forge/ui/screen/badges_description_screen.dart';
import 'package:fitness_forge/ui/screen/badges_profile_screen.dart';
import 'package:fitness_forge/ui/screen/challenges_screen.dart';
import 'package:fitness_forge/ui/screen/leaderboardchallenges.dart';
import 'package:fitness_forge/ui/screen/leaderboardworkout.dart';
import 'package:flutter/material.dart';

class ExtraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      // ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Achievements',
            image: 'images/achievements.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Challenges',
            image: 'images/challenges.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChallengesScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Leaderboard',
            image: 'images/leaderboard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChallengeLeaderboardScreen()),
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