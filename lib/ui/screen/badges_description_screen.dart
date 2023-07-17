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
            title: 'Engagement',
            description: 'They are unlocked by adding users as friends as well as engaging in conversations with them',
            image: 'images/badge1.PNG',
          ),
          CustomRightAlignedContainer(
            title: 'Activity',
            description: 'They are unlocked by completing a number of activities that are provided by the application',
            image: 'images/badge2.PNG',
          ),
          CustomRightAlignedContainer(
            title: 'Achievements',
            description: 'They are unlocked by achieving a variety of milestones through this application',
            image: 'images/badge3.PNG',
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