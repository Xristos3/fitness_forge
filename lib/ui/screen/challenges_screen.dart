import 'package:fitness_forge/ui/screen/achievements_screen.dart';
import 'package:fitness_forge/ui/screen/challenges_cycling.dart';
import 'package:fitness_forge/ui/screen/challenges_hiking.dart';
import 'package:fitness_forge/ui/screen/challenges_rockclimbing.dart';
import 'package:fitness_forge/ui/screen/challenges_running.dart';
import 'package:fitness_forge/ui/screen/challenges_skating.dart';
import 'package:fitness_forge/ui/screen/challenges_sports.dart';
import 'package:fitness_forge/ui/screen/challenges_swimming.dart';
import 'package:fitness_forge/ui/screen/challenges_walking.dart';
import 'package:fitness_forge/ui/screen/challenges_yoga.dart';
import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outside Activities'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Hiking',
            image: 'images/walk.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Hiking()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Cycling',
            image: 'images/cycling.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cycling()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Walking',
            image: 'images/walking.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Walking()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Running',
            image: 'images/run.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Running()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Yoga',
            image: 'images/yoga.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Yoga()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Sports',
            image: 'images/sports.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sports()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Fly a kite',
            image: 'images/kite.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Swimming',
            image: 'images/swim.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Swimming()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Skating',
            image: 'images/skate.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Skating()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Rock Climbing',
            image: 'images/rock.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RockClimbing()),
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