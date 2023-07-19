import 'package:flutter/material.dart';
import 'package:fitness_forge/ui/screen/types_of_workouts.dart';
import 'package:fitness_forge/ui/screen/difficulty.dart';

class WorkoutScreen extends StatelessWidget {
  final bool? isStandard;
  final bool? isGuest;

  WorkoutScreen({required this.isStandard, required this.isGuest, required String difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Workout Sessions'),
      // ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Difficulty: ${isStandard == true ? 'Standard' : 'Advanced'}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0), // Added spacing
                ElevatedButton(
                  child: Text('Change Difficulty'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => isGuest == true ? GuestSelectDifficultyScreen() : SelectDifficultyScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          _buildWorkoutItem(
            title: 'HIIT Workout',
            type: 'HIIT',
            // description: 'Exercises: Expected duration:',
            image: 'images/hiit.png',
            onPressed: () {
              if (isGuest == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => isStandard == true ? GuestHiitStandardScreen() : GuestHiitAdvancedScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => isStandard == true ? HiitStandardScreen() : HiitAdvancedScreen()),
                );
              }
            },
          ),
          _buildWorkoutItem(
            title: 'Upper Body Workout',
            type: 'Upper Body',
            // description: 'Exercises: Expected duration:',
            image: 'images/upperbody.jpeg',
            onPressed: () {
              if (isGuest == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => isStandard == true ? GuestUpperStandardScreen() : GuestUpperAdvancedScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => isStandard == true ? UpperStandardScreen() : UpperAdvancedScreen()),
                );
              }
            },
          ),
          _buildWorkoutItem(
            title: 'Lower Body Workout',
            type: 'Lower Body',
            // description: 'Exercises: Expected duration:',
            image: 'images/lowerbody.jpeg',
            onPressed: () {
              if (isGuest == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => isStandard == true ? GuestLowerStandardScreen() : GuestLowerAdvancedScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => isStandard == true ? LowerStandardScreen() : LowerAdvancedScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutItem({
    required String title,
    required String type,
    // required String description,
    required String image,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(image),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 2,
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
                  'Type: $type',//\n$description
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  child: Text('Start'),
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
