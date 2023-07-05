import 'package:fitness_forge/ui/screen/guest_lowerworkout_standard.dart';
import 'package:fitness_forge/ui/screen/guest_selectdifficulty_screen.dart';
import 'package:fitness_forge/ui/screen/guest_upperworkout_standard.dart';
import 'package:fitness_forge/ui/screen/guesti_hiitworkout_standard.dart';
import 'package:fitness_forge/ui/screen/hiitworkout_standard.dart';
import 'package:fitness_forge/ui/screen/lowerworkout_standard.dart';
import 'package:fitness_forge/ui/screen/select_difficulty_screen.dart';
import 'package:fitness_forge/ui/screen/upperworkout_standard.dart';
import 'package:flutter/material.dart';

class GuestWorkoutScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Sessions'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Difficulty: Standard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomContainer(
            title: 'HIIT Workout',
            description: 'Exercises: Expected duration:',
            image: 'images/hiit.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestHiitStandardScreen()),
              );
            },
          ),
          CustomContainer(
            title: 'Upper Body Workout',
            description: 'Exercises: Expected duration:',
            image: 'images/upperbody.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestUpperStandardScreen()),
              );
            },
          ),
          CustomContainer(
            title: 'Lower Body Workout',
            description: 'Exercises: Expected duration:',
            image: 'images/lowerbody.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestLowerStandardScreen()),
              );
            },
          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Change Difficulty'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestSelectDifficultyScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final VoidCallback onPressed;

  const CustomContainer({
    required this.title,
    required this.description,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
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
          Image.asset(image),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text('Start'),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}