import 'package:flutter/material.dart';

class UpperAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Advanced'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Explosive Pushups',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Diamond press up',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Tricep dips',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Side leg raises',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Dolphin kicks',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Superman',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Handstand pushups ',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Nose and Toes Against the Wall',
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