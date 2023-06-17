import 'package:flutter/material.dart';

class HiitAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Advanced'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Each exercise lasts for 40 seconds,'
                  'after that you have 15 seconds of rest '
                  'and then you proceed to the next one',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Cross Jacks',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Butt kick (fast)',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Side to side skiers (explosive)',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Squats (explosive)',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'High knees',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Explosive push ups',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Full Burpees',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises (stretched knees)',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Cross climbers',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/walk.png',

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {

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