import 'dart:async';
import 'package:fitness_forge/ui/screen/leg_raises_advanced.dart';
import 'package:fitness_forge/ui/screen/situps_standard.dart';
import 'package:flutter/material.dart';

class PlankExtendedScreenAdvanced extends StatefulWidget {
  @override
  _PushUpUpperScreenStandardState createState() =>
      _PushUpUpperScreenStandardState();
}

class _PushUpUpperScreenStandardState extends State<PlankExtendedScreenAdvanced> {
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
                'Plank with extended and stretched arms',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Get in a press-up position but with your arms as far in front of your head as you can reach. '
                    'Hold yourself there with your arms fully extended. '
                    'Make sure your back is straight and hold for the alloted time. '
                    'Expert tips: Keep your abs and glutes locked to avoid sagging or rising from your hips.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Image.asset(
                'images/plankex.jpeg', // Replace with the actual path to your image
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
                      builder: (context) => LegRaisesScreenAdvanced(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Sets: 5 sets Reps for each set: Until Failure for each set',
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

