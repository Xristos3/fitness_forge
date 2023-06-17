import 'package:flutter/material.dart';

class UpperStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Standard'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Pushups',
            image: 'images/pushup.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Bird dog hold',
            image: 'images/bdh.png',

          ),
          CustomRightAlignedContainer(
            title: 'Bodyweight triceps extension ',
            image: 'images/tes.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Dragon walk',
            image: 'images/dw.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Overhead pushups',
            image: 'images/spus.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Plank Standard',
            image: 'images/plank.jpeg',

          ),
          CustomRightAlignedContainer(
            title: 'Sit ups',
            image: 'images/situps.png',

          ),
          CustomRightAlignedContainer(
            title: 'Side planks',
            image: 'images/sideplank.png',

          ),
          CustomRightAlignedContainer(
            title: 'Reverse snow angels',
            image: 'images/rsas.png',

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