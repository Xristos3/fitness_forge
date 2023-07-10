import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget nextScreen;
  //final int initialCountdown;

  CountdownTimer({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.nextScreen,
    //this.initialCountdown = 15,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int countdown = 15;
  bool isCountdownActive = false;

  @override
  void initState() {
    super.initState();
    //countdown = widget.initialCountdown;
  }

  void startCountdown(int duration) {
    if (!isCountdownActive) {
      setState(() {
        countdown = duration;
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
        title: Text('HIIT Workout'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Countdown: $countdown seconds',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Reps: Until the 40-second countdown ends,'
                    ' then take a 15-second break'
                    'and proceed to the next exercise.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.description,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Start'),
                    onPressed: isCountdownActive ? null : () => startCountdown(40),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Take a break from each set',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: isCountdownActive ? null : () => startCountdown(15),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Image.asset(
                widget.imagePath,
                width: 200.0,
                height: 200.0,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.nextScreen,
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
