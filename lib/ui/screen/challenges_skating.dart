import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_forge/ui/screen/challenges_congratulations.dart';

class Skating extends StatefulWidget {
  @override
  _SkatingState createState() => _SkatingState();
}

class _SkatingState extends State<Skating> {
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
                'Skating',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Image.asset(
                'images/skate.png',
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
                  buildTimeInput('Hours', hoursController, (value) {
                    return validateHours(value);
                  }),
                  buildTimeInput('Minutes', minutesController, null),
                  buildTimeInput('Seconds', secondsController, null),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isCountingDown ? null : canStartCountdown() ? startCountdown : null,
                child: Text('Start Countdown'),
              ),
              SizedBox(height: 182.0), // Adjust the spacing as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeInput(
      String label, TextEditingController controller, FormFieldValidator<String>? validator) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 100.0,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: validator,
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

  String? validateHours(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }

    int? parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue < 0) {
      return 'Please enter a valid non-negative integer';
    }

    return null;
  }

  bool canStartCountdown() {
    return hours > 0 || minutes > 0 || seconds > 0;
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
