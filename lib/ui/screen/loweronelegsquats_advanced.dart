import 'dart:async';
import 'package:fitness_forge/ui/screen/diamondpress_advanced.dart';
import 'package:fitness_forge/ui/screen/lowerexsplitsquats_advanced.dart';
import 'package:fitness_forge/ui/screen/situps_standard.dart';
import 'package:flutter/material.dart';

class LowerOneLegSquatsScreenAdvanced extends StatefulWidget {
  @override
  _PushUpUpperScreenStandardState createState() =>
      _PushUpUpperScreenStandardState();
}

class _PushUpUpperScreenStandardState extends State<LowerOneLegSquatsScreenAdvanced> {
  int countdown = 30;
  bool isCountdownActive = false;

  void startCountdown() {
    if (!isCountdownActive) {
      setState(() {
        countdown = 30;
        isCountdownActive = true;
      });

      const oneSec = const Duration(seconds: 1);
      Timer.periodic(oneSec, (Timer timer) {
        if (countdown == 0) {
          setState(() {
            isCountdownActive = false;
          });
          timer.cancel();
        } else {
          setState(() {
            countdown--;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'One Leg Squats',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Stand on one leg, with the other leg and your arms out in front of you. '
                    'Squat, bending at the knee and sitting your hips back. '
                    'Keep the other knee in line over your foot.'
                    'Once you feel the squat in your quad and glutes, extend your leg back up to standing.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Image.asset(
                'images/oneleg.jpeg', // Replace with the actual path to your image
                width: 200.0,
                height: 200.0,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LowerExplosiveSplitSquadsScreenAdvanced(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Sets: 5 sets Reps for each set: 15, 12, 10, 8, 5',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(
                  'Take a break from each set',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: isCountdownActive ? null : startCountdown,
              ),
              SizedBox(height: 16.0),
              Text(
                'Countdown: $countdown seconds',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

