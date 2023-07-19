import 'package:flutter/material.dart';

class BadgesDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requirements of each type of badge'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Bronze Medal',
            description: 'This medal is unlocked when you complete the first achievement regarding the workouts and/or challenges',
            image: 'images/badgeb1.png',
          ),
          CustomRightAlignedContainer(
            title: 'Silver Medal',
            description: 'This medal is unlocked when you complete the second achievement regarding the workouts and/or challenges',
            image: 'images/badges2.png',
          ),
          CustomRightAlignedContainer(
            title: 'Gold Medal',
            description: 'This medal is unlocked when you complete the third achievement regarding the workouts and/or challenges',
            image: 'images/badgeg3.png',
          ),
          CustomRightAlignedContainer(
            title: 'Locked',
            description: 'They are locked for the time being, they will be unlocked once you meet the appropriate requirements',
            image: 'images/badge4.PNG',
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

  const CustomRightAlignedContainer({
    required this.title,
    required this.description,
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
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
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