import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  final String containerName;

  ExerciseScreen(this.containerName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the new screen for $containerName!',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}