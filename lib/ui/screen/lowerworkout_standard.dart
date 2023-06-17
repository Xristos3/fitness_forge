import 'package:flutter/material.dart';

class LowerStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lower Workout Standard'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Squats',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Side lunges',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Split squats',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: '6x6x6 Circuit',
            image: 'images/walk.png',

          ),
          CustomRightAlignedContainer(
            title: 'Calf raises',
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