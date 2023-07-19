import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: _buildAboutContent(),
    );
  }
}

Widget _buildAboutContent() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('images/appicon.png'),
        ),
        SizedBox(height: 16),
        Text(
          'Fitness Forge',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          '    A gamified mobile Application that aims to '
              '      increase exercise engagement and motivation',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Version: 1.0.0',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Developer: Christos Savvides',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
