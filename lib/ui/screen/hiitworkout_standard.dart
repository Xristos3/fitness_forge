import 'package:fitness_forge/ui/screen/achievements_screen.dart';
import 'package:fitness_forge/ui/screen/jumpingjacks_standard.dart';
import 'package:flutter/material.dart';

class HiitStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiit Workout Standard'),
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
            title: 'Jumping Jacks',
            image: 'images/jjs.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Butt kick (slow)',
            image: 'images/bks.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Side to side skiers (slow)',
            image: 'images/sss.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Squats',
            image: 'images/squats.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Run in place',
            image: 'images/rip.png',

          ),
          CustomRightAlignedContainer(
            title: 'Standard Pushups',
            image: 'images/pushup.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Half Burpees',
            image: 'images/hbs.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises (bent knees)',
            image: 'images/lrbks.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Standard mountain climbers',
            image: 'images/mcs.png',

          ),
          CustomRightAlignedContainer(
            title: 'Plank Standard',
            image: 'images/plank.jpeg',

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountdownScreen(),
                ),
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