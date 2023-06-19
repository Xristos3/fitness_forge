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
            image: 'images/pushup.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Diamond press up',
            image: 'images/diamond.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Tricep dips',
            image: 'images/dips.png',

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/plankex.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises',
            image: 'images/legraises.png',

          ),
          CustomRightAlignedContainer(
            title: 'Side leg raises',
            image: 'images/sideleg.png',

          ),
          CustomRightAlignedContainer(
            title: 'Dolphin kicks',
            image: 'images/dolphin.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Superman',
            image: 'images/superman.png',

          ),
          CustomRightAlignedContainer(
            title: 'Handstand pushups ',
            image: 'images/hand.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Nose and Toes Against the Wall',
            image: 'images/naratw.jpeg',

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