import 'dart:async';
import 'package:fitness_forge/ui/screen/buttkick_standard.dart';
import 'package:fitness_forge/ui/screen/guest_buttkick_standard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => GuestJumpingJacksStandardScreen(),
        '/buttkickstandardScreen': (context) => GuestButtkickStandardScreen(),
      },
    );
  }
}

class GuestJumpingJacksStandardScreen extends StatefulWidget {
  @override
  _JumpingJacksStandardScreenState createState() =>
      _JumpingJacksStandardScreenState();
}

class _JumpingJacksStandardScreenState
    extends State<GuestJumpingJacksStandardScreen> {
  int _seconds = 40;
  Timer? _timer;
  bool _countdownStarted = false;
  bool _showNextButton = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      _countdownStarted = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
          setState(() {
            _showNextButton = true;
          });
        }
      });
    });
  }

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jumping Jacks')),
      body: ListView(
        children: [
          if (!_countdownStarted)
            ElevatedButton(
              onPressed: startCountdown,
              child: Text('Start'),
            ),
          if (_countdownStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_seconds seconds',
                style: TextStyle(fontSize: 24),
              ),
            ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jumping Jacks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Begin by standing with your legs straight and your arms to your sides. '
                      'Jump up and spread your feet beyond hip-width apart while bringing your arms above your head,'
                      ' nearly touching. Jump again, lowering your arms and bringing your legs together. Return to your starting position.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/jjs.jpeg', // Replace with your actual image filename
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          if (_showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _seconds = 15;
  Timer? _timer;
  bool _breakStarted = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startBreak() {
    setState(() {
      _breakStarted = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuestButtkickStandardScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a break')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_breakStarted)
            ElevatedButton(
              onPressed: startBreak,
              child: Text('Start Break'),
            ),
          if (_breakStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_seconds seconds',
                style: TextStyle(fontSize: 24),
              ),
            ),
        ],
      ),
    );
  }
}

