import 'package:fitness_forge/ui/screen/badges_profile_screen.dart';
import 'package:flutter/material.dart';

class ClaimScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Congradulations',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'You have unlocked a new badge!!!',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Name:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    child: Image.asset('images/ccc.jpeg'), // Replace with your image path
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Level:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Points:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    child: Image.asset('images/badge2.PNG'), // Replace with your image path
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BadgesScreen(
                      totalWorkouts: 0,
                      totalChallengesCompleted: 0,
                    )),
                  );
                },
                child: Text('Claim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}