import 'package:fitness_forge/ui/screen/challenges_congratulations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sports extends StatefulWidget {
  @override
  _HikingState createState() => _HikingState();
}

class _HikingState extends State<Sports> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondsController = TextEditingController();
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  bool isCountingDown = false;

  @override
  void dispose() {
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sports',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Image.asset(
                'images/sports.png',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16.0),
              Text(
                'Countdown: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTimeInput('Hours', hoursController),
                  buildTimeInput('Minutes', minutesController),
                  buildTimeInput('Seconds', secondsController),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isCountingDown ? null : startCountdown,
                child: Text('Start Countdown'),
              ),
              SizedBox(height: 182.0), // Adjust the spacing as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeInput(String label, TextEditingController controller) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 100.0,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                if (label == 'Hours') {
                  hours = int.tryParse(value) ?? 0;
                } else if (label == 'Minutes') {
                  minutes = int.tryParse(value) ?? 0;
                } else if (label == 'Seconds') {
                  seconds = int.tryParse(value) ?? 0;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  void startCountdown() {
    setState(() {
      isCountingDown = true;
    });

    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    Future.delayed(Duration(seconds: 1), () {
      if (totalSeconds > 0) {
        setState(() {
          totalSeconds--;
          hours = totalSeconds ~/ 3600;
          minutes = (totalSeconds % 3600) ~/ 60;
          seconds = totalSeconds % 60;
        });
        startCountdown();
      } else {
        setState(() {
          isCountingDown = false;
        });
        navigateToNextScreen();
      }
    });
  }

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChallengesCongratulationsScreen()),
    );
  }
}

