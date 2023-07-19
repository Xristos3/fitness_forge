import 'dart:async';
import 'package:fitness_forge/ui/screen/exercises.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  final bool isStandard;
  final bool isGuest;

  ExerciseScreen({required this.isStandard, required this.isGuest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Screen'),
      ),
      body: ListView(
        children: [
          Text(
            'Exercise Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          buildExerciseWidget(context, 'HIIT', 'Standard', isGuest),
          buildExerciseWidget(context, 'HIIT', 'Advanced', isGuest),
          buildExerciseWidget(context, 'Upper Body', 'Standard', isGuest),
          buildExerciseWidget(context, 'Upper Body', 'Advanced', isGuest),
          buildExerciseWidget(context, 'Lower Body', 'Standard', isGuest),
          buildExerciseWidget(context, 'Lower Body', 'Advanced', isGuest),
        ],
      ),
    );
  }

  Widget buildExerciseWidget(BuildContext context, String workoutType, String difficulty, bool isGuest) {
    // Define the exercise classes based on workout type, difficulty, and isGuest
    Widget exerciseWidget;

    if (workoutType == 'HIIT' && difficulty == 'Standard') {
      exerciseWidget = isGuest ? GuestJumpingJacksStandardScreen() : JumpingJacksStandardScreen();
    } else if (workoutType == 'HIIT' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestCrossJacksAdvancedScreen() : CrossJacksAdvancedScreen();
    } else if (workoutType == 'Upper Body' && difficulty == 'Standard') {
      exerciseWidget = isGuest ? GuestPushUpUpperScreenStandard() : PushUpUpperScreenStandard();
    } else if (workoutType == 'Upper Body' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestExplosivePushUpScreenAdvanced() : ExplosivePushUpScreenAdvanced();
    } else if (workoutType == 'Lower Body' && difficulty == 'Standard') {
      exerciseWidget = isGuest ? GuestLowerSquatsScreenStandard() : LowerSquatsScreenStandard();
    } else if (workoutType == 'Lower Body' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestLowerExplosiveSquatsScreenAdvanced() : LowerExplosiveSquatsScreenAdvanced();
    } else {
      // Default case if no matching exercise class is found
      exerciseWidget = Container();
    }

    return exerciseWidget;
  }
}

class CountdownTimer extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget nextScreen;

  CountdownTimer({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.nextScreen,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int countdown = 0;
  bool isCountdownActive = false;
  bool showStartButton = true;
  bool showTakeBreakButton = false;
  bool showNextButton = false;

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
            if (showStartButton) {
              showStartButton = false;
              showTakeBreakButton = true;
              countdown = 15; // Start the countdown for "Take a break from each set"
            } else if (showTakeBreakButton) {
              showTakeBreakButton = false;
              showNextButton = true;
              timer.cancel(); // Cancel the periodic timer
            }
          });
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
        title: Text('Exercise'),
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
                    ' and proceed to the next exercise.',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Show the "Start" button when countdown is not active
                  if (showStartButton)
                    ElevatedButton(
                      child: Text('Start'),
                      onPressed: () => startCountdown(40),
                    ),

                  // Show the "Take a break" button when countdown is not active
                  if (showTakeBreakButton)
                    ElevatedButton(
                      child: Text(
                        'Take a break from each set',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => startCountdown(15),
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
              // Show the "Next" button below the image when countdown is done
              if (showNextButton)
                ElevatedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget.nextScreen,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class GuestJumpingJacksStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      title: 'Jumping Jacks',
      description:
      'Begin by standing with your legs straight and your arms to your sides. '
          'Jump up and spread your feet beyond hip-width apart while bringing your arms above your head,'
          ' nearly touching. Jump again, lowering your arms and bringing your legs together. Return to your starting position.',
      imagePath: 'images/jjs.jpeg',
      nextScreen: GuestButtkickStandardScreen(),
    );
  }
}
