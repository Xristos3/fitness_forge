import 'dart:async';
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
      exerciseWidget = isGuest ? GuestJumpingJacksStandardScreen(screenNavigator: ScreenNavigator(context)) : HiitStandardExercises();
    } else if (workoutType == 'HIIT' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestHiitAdvancedExercises() : HiitAdvancedExercises();
    } else if (workoutType == 'Upper Body' && difficulty == 'Standard') {
      exerciseWidget = isGuest ? GuestUpperStandardExercises() : UpperStandardExercises();
    } else if (workoutType == 'Upper Body' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestUpperAdvancedExercises() : UpperAdvancedExercises();
    } else if (workoutType == 'Lower Body' && difficulty == 'Standard') {
      exerciseWidget = isGuest ? GuestLowerStandardExercises() : LowerStandardExercises();
    } else if (workoutType == 'Lower Body' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestLowerAdvancedExercises() : LowerAdvancedExercises();
    } else {
      // Default case if no matching exercise class is found
      exerciseWidget = Container();
    }

    return exerciseWidget;
  }
}

class CountdownTimer {
  int seconds;
  Timer? timer;
  bool countdownStarted = false;
  bool showNextButton = false;
  Function? onTimerFinish;

  CountdownTimer({required this.seconds, this.onTimerFinish});

  void startCountdown() {
    countdownStarted = true;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
      } else {
        timer.cancel();
        showNextButton = true;
        if (onTimerFinish != null) {
          onTimerFinish!();
        }
      }
    });
  }

  void dispose() {
    timer?.cancel();
  }
}

class ScreenNavigator {
  final BuildContext context;

  ScreenNavigator(this.context);

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuestSecondScreen()),
    );
  }
}

class GuestJumpingJacksStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  GuestJumpingJacksStandardScreen({required this.screenNavigator});

  @override
  _GuestJumpingJacksStandardScreenState createState() =>
      _GuestJumpingJacksStandardScreenState();
}

class _GuestJumpingJacksStandardScreenState
    extends State<GuestJumpingJacksStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jumping Jacks')),
      body: ListView(
        children: [
          if (!countdownTimer.countdownStarted)
            ElevatedButton(
              onPressed: countdownTimer.startCountdown,
              child: Text('Start'),
            ),
          if (countdownTimer.countdownStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${countdownTimer.seconds} seconds',
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
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.screenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestButtkickStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  GuestButtkickStandardScreen({required this.screenNavigator});

  @override
  _GuestButtkickStandardScreenState createState() =>
      _GuestButtkickStandardScreenState();
}

class _GuestButtkickStandardScreenState
    extends State<GuestButtkickStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Butt kick (slow)')),
      body: ListView(
        children: [
          if (!countdownTimer.countdownStarted)
            ElevatedButton(
              onPressed: countdownTimer.startCountdown,
              child: Text('Start'),
            ),
          if (countdownTimer.countdownStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${countdownTimer.seconds} seconds',
                style: TextStyle(fontSize: 24),
              ),
            ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Butt kick (slow)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'kicking your shins back behind you to touch your buttocks with the bottom of your foot. '
                      'The movement utilizes the hamstrings while stretching the flexors and quadriceps. '
                      'Butt kickers are an effective glute-building move and they are suitable for all fitness levels.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/bks.jpeg', // Replace with your actual image filename
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.screenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSidetoSideStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  GuestSidetoSideStandardScreen({required this.screenNavigator});

  @override
  _GuestSidetoSideStandardScreenState createState() =>
      _GuestSidetoSideStandardScreenState();
}

class _GuestSidetoSideStandardScreenState
    extends State<GuestSidetoSideStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Side to side skiers (slow)')),
      body: ListView(
        children: [
          if (!countdownTimer.countdownStarted)
            ElevatedButton(
              onPressed: countdownTimer.startCountdown,
              child: Text('Start'),
            ),
          if (countdownTimer.countdownStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${countdownTimer.seconds} seconds',
                style: TextStyle(fontSize: 24),
              ),
            ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Side to side skiers (slow)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stand with your feet hip-width apart and knees slightly bent (an athletic stance). '
                      'Shift your weight so you are balancing on one leg. Jump to the side, landing on the other leg, '
                      'landing softly. Then jump to the other side, landing on the other leg.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/sss.jpeg', // Replace with your actual image filename
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.screenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSquatsStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  GuestSquatsStandardScreen({required this.screenNavigator});

  @override
  _GuestSquatsStandardScreenState createState() =>
      _GuestSquatsStandardScreenState();
}

class _GuestSquatsStandardScreenState
    extends State<GuestSquatsStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Squats')),
      body: ListView(
        children: [
          if (!countdownTimer.countdownStarted)
            ElevatedButton(
              onPressed: countdownTimer.startCountdown,
              child: Text('Start'),
            ),
          if (countdownTimer.countdownStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${countdownTimer.seconds} seconds',
                style: TextStyle(fontSize: 24),
              ),
            ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Squats',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'A squat is a strength exercise in which the trainee lowers their hips from a standing position '
                      'and then stands back up. During the descent, the hip and knee joints flex while the ankle joint dorsiflexes; '
                      'conversely the hip and knee joints extend and the ankle joint plantarflexes when standing up.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/squats.jpeg', // Replace with your actual image filename
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.screenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestRuninPlaceStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  GuestRuninPlaceStandardScreen({required this.screenNavigator});

  @override
  _GuestRuninPlaceStandardScreenState createState() =>
      _GuestRuninPlaceStandardScreenState();
}

class _GuestRuninPlaceStandardScreenState
    extends State<GuestRuninPlaceStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Run in place')),
      body: ListView(
        children: [
          if (!countdownTimer.countdownStarted)
            ElevatedButton(
              onPressed: countdownTimer.startCountdown,
              child: Text('Start'),
            ),
          if (countdownTimer.countdownStarted)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${countdownTimer.seconds} seconds',
                style: TextStyle(fontSize: 24),
              ),
            ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Run in place',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lift your right arm and left foot at the same time. '
                      'Raise your knee as high as your hips. Then switch to the opposite foot, '
                      'quickly lifting your right foot to hip height. At the same time, move your right arm back and your left arm forward and up.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/rip.png', // Replace with your actual image filename
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.screenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSecondScreen extends StatefulWidget {
  @override
  _GuestSecondScreenState createState() => _GuestSecondScreenState();
}

class _GuestSecondScreenState extends State<GuestSecondScreen> {
  int _seconds = 15;
  Timer? _timer;
  bool _breakStarted = false;
  List<Widget> screens = []; // List of screens
  int currentScreenIndex = 0; // Current screen index

  @override
  void initState() {
    super.initState();
    screens = [
      GuestButtkickStandardScreen(screenNavigator: ScreenNavigator(context)),
      GuestSidetoSideStandardScreen(screenNavigator: ScreenNavigator(context)),
      GuestSquatsStandardScreen(screenNavigator: ScreenNavigator(context)),
      GuestRuninPlaceStandardScreen(screenNavigator: ScreenNavigator(context)),
    ];
  }

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
          if (currentScreenIndex < screens.length - 1) {
            currentScreenIndex++; // Increment the screen index
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screens[currentScreenIndex]),
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


