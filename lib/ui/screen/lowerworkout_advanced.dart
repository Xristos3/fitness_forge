import 'package:fitness_forge/ui/screen/lowerexsquats_advanced.dart';
import 'package:flutter/material.dart';

class LowerAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lower Workout Advanced'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Explosive Squats',
            image: 'images/squats.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'One Leg Squats',
            image: 'images/oneleg.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Explosive Split squats',
            image: 'images/sidesquats.png',

          ),
          CustomRightAlignedContainer(
            title: '15x15x15 Circuit',
            image: 'images/circuit.png',

          ),
          CustomRightAlignedContainer(
            title: 'Explosive Calf raises',
            image: 'images/calf.jpeg',

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LowerExplosiveSquatsScreenAdvanced(),
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