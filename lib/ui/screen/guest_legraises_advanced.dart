import 'dart:async';
import 'package:fitness_forge/ui/screen/achievements_screen.dart';
import 'package:fitness_forge/ui/screen/buttkick_standard.dart';
import 'package:fitness_forge/ui/screen/crossclimbers_advanced.dart';
import 'package:fitness_forge/ui/screen/guest_crossclimbers_advanced.dart';
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
        '/': (context) => GuestLegRaisesAdvancedScreen(),
        '/buttkickstandardScreen': (context) => GuestCrossClimbersAdvancedScreen(),
      },
    );
  }
}

class GuestLegRaisesAdvancedScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<GuestLegRaisesAdvancedScreen> {
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leg raises (stretched knees)')),
      body: SingleChildScrollView(
        child: Column(
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
                    'Leg raises (stretched knees)',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grasp one leg with your hands, holding behind your thigh.'
                        ' Raise your leg in the air with your foot flexed. '
                        'Straighten the leg as much as possible without locking the knee. Hold the stretch, '
                        'return to the starting position, then repeat with the other leg.'
                        'If you feel comfortable you can raise both leg at the same time',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    'images/legraises.png', // Replace with your actual image filename
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => GuestCrossClimbersAdvancedScreen()));
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
