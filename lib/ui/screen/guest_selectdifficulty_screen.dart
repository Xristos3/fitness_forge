import 'package:fitness_forge/ui/screen/guest_workoutscreen_hard.dart';
import 'package:fitness_forge/ui/screen/guest_workoutscreen_standard.dart';
import 'package:fitness_forge/ui/screen/workout_screen_standard.dart';
import 'package:fitness_forge/ui/screen/workout_screen_hard.dart';
import 'package:flutter/material.dart';

class GuestSelectDifficultyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Difficulty'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Standard',
            description: 'Composed of basic callisthenic exercises to help you start your fitness journey ',
            image: 'images/custom.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestWorkoutScreenStandard()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Advanced',
            description: 'Test your limits with exercises that will push your muscles to new levels',
            image: 'images/custom.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestWorkoutScreenAdvanced()),
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