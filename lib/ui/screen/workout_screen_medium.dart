import 'package:fitness_forge/ui/screen/exercise_screen.dart';
import 'package:fitness_forge/ui/screen/select_difficulty_screen.dart';
import 'package:flutter/material.dart';


class WorkoutScreenMedium extends StatelessWidget {
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
              'Difficulty: Medium',
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
                MaterialPageRoute(builder: (context) => ExerciseScreen('Exercise 1')),
              );
            },
          ),
          CustomContainer(
            title: 'Full Body Workout',
            description: 'Exercises: Expected duration:',
            image: 'images/fullbody.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExerciseScreen('Exercise 1')),
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
                MaterialPageRoute(builder: (context) => ExerciseScreen('Exercise 1')),
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
                MaterialPageRoute(builder: (context) => ExerciseScreen('Exercise 1')),
              );
            },
          ),
          CustomContainer(
            title: 'Custom Workout',
            description: 'Exercises: Expected duration:',
            image: 'images/custom.jpeg',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExerciseScreen('Exercise 1')),
              );
            },
          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Change Difficulty'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectDifficultyScreen()),
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