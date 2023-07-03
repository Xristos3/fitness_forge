import 'dart:async';
import 'package:fitness_forge/ui/screen/diamondpress_advanced.dart';
import 'package:fitness_forge/ui/screen/lowerexcalfraises_advanced.dart';
import 'package:fitness_forge/ui/screen/situps_standard.dart';
import 'package:flutter/material.dart';

class LowerCircuitScreenAdvanced extends StatefulWidget {
  @override
  _PushUpUpperScreenStandardState createState() =>
      _PushUpUpperScreenStandardState();
}

class _PushUpUpperScreenStandardState extends State<LowerCircuitScreenAdvanced> {
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
                'Lower Circuit',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'pulse squats:  In pulse squats, this pulse is performed at the bottom quarter of the squat,'
                    ' so you would squat down, push up a quarter of the way back up, and pulse up and down from there.'
                    ' One quarter up and down would be one rep.'
                    'jump squats: Jump squats are bodyweight exercises characterized by leaping directly upwards at the top of the movement.'
                    'high knees: Stand with your feet hip-width apart. Lift up your left knee to your chest.'
                    'Switch to lift your right knee to your chest. Continue the movement, alternating legs and moving at a sprinting or running pace.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Image.asset(
                'images/circuit.png', // Replace with the actual path to your image
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
                      builder: (context) => LowerExplosiveCalfRaisesScreenAdvanced(),
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

