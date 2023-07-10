import 'dart:async';
import 'package:fitness_forge/ui/screen/congratulationscreen_standard.dart';
import 'package:fitness_forge/ui/screen/guest_congratulationsstandard.dart';
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
      exerciseWidget = isGuest ? GuestJumpingJacksStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)) : JumpingJacksStandardScreen(screenNavigator: ScreenNavigator(context));
    } else if (workoutType == 'HIIT' && difficulty == 'Advanced') {
      exerciseWidget = isGuest ? GuestCrossJacksAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context),) : CrossJacksAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context));
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

class GuestScreenNavigator {
  final BuildContext context;

  GuestScreenNavigator(this.context);

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuestSecondScreen()),
    );
  }
}

class ScreenNavigator {
  final BuildContext context;

  ScreenNavigator(this.context);

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );
  }
}

class GuestScreenNavigatorAdvanced {
  final BuildContext context;

  GuestScreenNavigatorAdvanced(this.context);

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuestSecondScreenAdvanced()),
    );
  }
}

class ScreenNavigatorAdvanced {
  final BuildContext context;

  ScreenNavigatorAdvanced(this.context);

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreenAdvanced()),
    );
  }
}

class GuestJumpingJacksStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestJumpingJacksStandardScreen({required this.GuestscreenNavigator});

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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestButtkickStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestButtkickStandardScreen({required this.GuestscreenNavigator});

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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSidetoSideStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestSidetoSideStandardScreen({required this.GuestscreenNavigator});

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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSquatsStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestSquatsStandardScreen({required this.GuestscreenNavigator});

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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestRuninPlaceStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestRuninPlaceStandardScreen({required this.GuestscreenNavigator});

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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestPushupStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestPushupStandardScreen({required this.GuestscreenNavigator});

  @override
  _GuestPushupStandardScreenState createState() =>
      _GuestPushupStandardScreenState();
}

class _GuestPushupStandardScreenState
    extends State<GuestPushupStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standard Pushups')),
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
                  'Standard Pushups',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'From a prone position, the hands are placed under the shoulders with the elbows extended. '
                      'Keeping the back and legs straight with the toes touching the ground. '
                      'The body is lowered until the upper arm is parallel to the ground. '
                      'Then reverse the movement and raise the body until arm is extended.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/pushup.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestHalfburpeesStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestHalfburpeesStandardScreen({required this.GuestscreenNavigator});

  @override
  _GuestHalfburpeesStandardScreenState createState() =>
      _GuestHalfburpeesStandardScreenState();
}

class _GuestHalfburpeesStandardScreenState
    extends State<GuestHalfburpeesStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Half Burpees')),
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
                  'Half Burpees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Place your hands on the floor in front of your feet and jump back into a high plank position '
                      'with your upper and lower body forming a straight line. Jump your feet back toward your hands '
                      'and repeat this back and forth movement with your feet for the desired number of repetitions.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/hbs.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestLegraisesStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestLegraisesStandardScreen({required this.GuestscreenNavigator});

  @override
  _GuestLegraisesStandardScreenState createState() =>
      _GuestLegraisesStandardScreenState();
}

class _GuestLegraisesStandardScreenState
    extends State<GuestLegraisesStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leg raises (bent knees)')),
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
                  'Leg raises (bent knees)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Brace your abs and lift your feet about 6 inches (about 15 cm) off of the floor.'
                      ' Maintain braced abdominals and slowly bend your knees to bring them to your chest '
                      'while keeping your lower legs parallel to the floor. Reverse the movement by slowly extending your legs.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/lrbks.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestMountainClimbersStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestMountainClimbersStandardScreen({required this.GuestscreenNavigator});

  @override
  _GuestMountainClimbersStandardScreenState createState() =>
      _GuestMountainClimbersStandardScreenState();
}

class _GuestMountainClimbersStandardScreenState
    extends State<GuestMountainClimbersStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standard mountain climbers')),
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
                  'Standard mountain climbers',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Performed from a plank position, you will alternate bringing one knee to your chest, '
                      'then back out again, speeding up each time until you are running against the floor. '
                      'While the move sounds simple, mountain climbers exercise almost the entire body '
                      'and raise your heart rate.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/mcs.png', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestPlankStandardScreen extends StatefulWidget {
  final GuestScreenNavigator GuestscreenNavigator;

  GuestPlankStandardScreen({required this.GuestscreenNavigator});

  @override
  _GuestPlankStandardScreenState createState() =>
      _GuestPlankStandardScreenState();
}

class _GuestPlankStandardScreenState
    extends State<GuestPlankStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plank Standard')),
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
                  'Plank Standard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'The plank exercise is an isometric core exercise that involves '
                      'maintaining a position similar to a push-up for the maximum possible time.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/plank.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigator.navigateToNextScreen,
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
      //GuestJumpingJacksStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestButtkickStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestSidetoSideStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestSquatsStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestRuninPlaceStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestPushupStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestHalfburpeesStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestLegraisesStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestMountainClimbersStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestPlankStandardScreen(GuestscreenNavigator: GuestScreenNavigator(context)),
      GuestCongratulationsScreen(),
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

class GuestCrossJacksAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestCrossJacksAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestCrossJacksAdvancedScreenState createState() =>
      _GuestCrossJacksAdvancedScreenState();
}

class _GuestCrossJacksAdvancedScreenState
    extends State<GuestCrossJacksAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cross Jacks')),
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
                  'Cross Jacks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stand tall with your feet together and arms out front at chest height. '
                      'Hop both feet out to the side while bringing arms out to the side as well. '
                      'Hop feet back in but cross left in front of right as well as crossing left arm over right.'
                      ' Repeat, crossing opposites',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/cross.png', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestButtKickAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestButtKickAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestButtKickAdvancedScreenState createState() =>
      _GuestButtKickAdvancedScreenState();
}

class _GuestButtKickAdvancedScreenState
    extends State<GuestButtKickAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Butt kick (fast)')),
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
                  'Butt kick (fast)',
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSidetoSideAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestSidetoSideAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestSidetoSideAdvancedScreenState createState() =>
      _GuestSidetoSideAdvancedScreenState();
}

class _GuestSidetoSideAdvancedScreenState
    extends State<GuestSidetoSideAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Side to side skiers (explosive)')),
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
                  'Side to side skiers (explosive)',
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSquatsAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestSquatsAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestSquatsAdvancedScreenState createState() =>
      _GuestSquatsAdvancedScreenState();
}

class _GuestSquatsAdvancedScreenState
    extends State<GuestSquatsAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Squats (explosive)')),
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
                  'Squats (explosive)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'A squat is a strength exercise in which the trainee lowers their hips from a standing position '
                      'and then stands back up. During the descent, the hip and knee joints flex while the ankle joint dorsiflexes; '
                      'conversely the hip and knee joints extend and the ankle joint plantarflexes when standing up.'
                      'But in the explosive version you have to jump during the accession.',
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestHighKneesAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestHighKneesAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestHighKneesAdvancedScreenState createState() =>
      _GuestHighKneesAdvancedScreenState();
}

class _GuestHighKneesAdvancedScreenState
    extends State<GuestHighKneesAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High knees')),
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
                  'High knees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stand with your feet hip-width apart. Lift up your left knee to your chest.'
                      'Switch to lift your right knee to your chest. Continue the movement, '
                      'alternating legs and moving at a sprinting or running pace.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/high.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestPushupAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestPushupAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestPushupAdvancedScreenState createState() =>
      _GuestPushupAdvancedScreenState();
}

class _GuestPushupAdvancedScreenState
    extends State<GuestPushupAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explosive push ups')),
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
                  'Explosive push ups',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lay down on the floor, facing down, with your hands at the width of your shoulders and your elbows bended. '
                      'Try to maintain your trunk as a plank and extend your arms '
                      'in an explosive way so that your hands lift off the floor. '
                      'If you are able to push yourself high enough in the air, you can clap your hands.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/pushup.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestFullBurpeesAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestFullBurpeesAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestFullBurpeesAdvancedScreenState createState() =>
      _GuestFullBurpeesAdvancedScreenState();
}

class _GuestFullBurpeesAdvancedScreenState
    extends State<GuestFullBurpeesAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Burpees')),
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
                  'Full Burpees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Start by standing erect with the arms by the side, feet should-width apart.'
                      ' Bend the knees, squatting down to place the hands on the floor in front of the feet. '
                      'Putting the bodyweight on the hands, the legs are thrust back to a push-up position '
                      'with a straight line from the shoulders to the heels.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/burpees.png', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestLegRaisesAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestLegRaisesAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestLegRaisesAdvancedScreenState createState() =>
      _GuestLegRaisesAdvancedScreenState();
}

class _GuestLegRaisesAdvancedScreenState
    extends State<GuestLegRaisesAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leg raises (stretched knees)')),
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
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestCrossClimbersAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestCrossClimbersAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestCrossClimbersAdvancedScreenState createState() =>
      _GuestCrossClimbersAdvancedScreenState();
}

class _GuestCrossClimbersAdvancedScreenState
    extends State<GuestCrossClimbersAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cross climbers')),
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
                  'Cross climbers',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Bring one knee up towards your chest and twist towards the opposing elbow.'
                      '(Ex: Right knee to left elbow.) Contract the core and return the leg to the starting position.'
                      'Alternate between legs.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/crossclimbers.png', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestPlankAdvancedScreen extends StatefulWidget {
  final GuestScreenNavigatorAdvanced GuestscreenNavigatorAdvanced;

  GuestPlankAdvancedScreen({required this.GuestscreenNavigatorAdvanced});

  @override
  _GuestPlankAdvancedScreenState createState() =>
      _GuestPlankAdvancedScreenState();
}

class _GuestPlankAdvancedScreenState
    extends State<GuestPlankAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plank with extended and stretched arms')),
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
                  'Plank with extended and stretched arms',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Get in a press-up position but with your arms as far in front of your head as you can reach. '
                      'Hold yourself there with your arms fully extended.'
                      ' Make sure your back is straight and hold for the alloted time. '
                      'Expert tips: Keep your abs and glutes locked to avoid sagging or rising from your hips.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/plankex.jpeg', // Replace with your actual image filename
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
                onPressed: widget.GuestscreenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class GuestSecondScreenAdvanced extends StatefulWidget {
  @override
  _GuestSecondScreenAdvancedState createState() => _GuestSecondScreenAdvancedState();
}

class _GuestSecondScreenAdvancedState extends State<GuestSecondScreenAdvanced> {
  int _seconds = 15;
  Timer? _timer;
  bool _breakStarted = false;
  List<Widget> screens = []; // List of screens
  int currentScreenIndex = 0; // Current screen index

  @override
  void initState() {
    super.initState();
    screens = [
      //GuestCrossJacksAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestButtKickAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestSidetoSideAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestSquatsAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestHighKneesAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestPushupAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestFullBurpeesAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestLegRaisesAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestCrossClimbersAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestPlankAdvancedScreen(GuestscreenNavigatorAdvanced: GuestScreenNavigatorAdvanced(context)),
      GuestCongratulationsScreen(),
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

class JumpingJacksStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  JumpingJacksStandardScreen({required this.screenNavigator});

  @override
  _JumpingJacksStandardScreenState createState() =>
      _JumpingJacksStandardScreenState();
}

class _JumpingJacksStandardScreenState
    extends State<JumpingJacksStandardScreen> {
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

class ButtkickStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  ButtkickStandardScreen({required this.screenNavigator});

  @override
  _ButtkickStandardScreenState createState() =>
      _ButtkickStandardScreenState();
}

class _ButtkickStandardScreenState
    extends State<ButtkickStandardScreen> {
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

class SidetoSideStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  SidetoSideStandardScreen({required this.screenNavigator});

  @override
  _SidetoSideStandardScreenState createState() =>
      _SidetoSideStandardScreenState();
}

class _SidetoSideStandardScreenState
    extends State<SidetoSideStandardScreen> {
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

class SquatsStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  SquatsStandardScreen({required this.screenNavigator});

  @override
  _SquatsStandardScreenState createState() =>
      _SquatsStandardScreenState();
}

class _SquatsStandardScreenState
    extends State<SquatsStandardScreen> {
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

class RuninPlaceStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  RuninPlaceStandardScreen({required this.screenNavigator});

  @override
  _RuninPlaceStandardScreenState createState() =>
      _RuninPlaceStandardScreenState();
}

class _RuninPlaceStandardScreenState
    extends State<RuninPlaceStandardScreen> {
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

class PushupStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  PushupStandardScreen({required this.screenNavigator});

  @override
  _PushupStandardScreenState createState() =>
      _PushupStandardScreenState();
}

class _PushupStandardScreenState
    extends State<PushupStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standard Pushups')),
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
                  'Standard Pushups',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'From a prone position, the hands are placed under the shoulders with the elbows extended. '
                      'Keeping the back and legs straight with the toes touching the ground. '
                      'The body is lowered until the upper arm is parallel to the ground. '
                      'Then reverse the movement and raise the body until arm is extended.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/pushup.jpeg', // Replace with your actual image filename
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

class HalfburpeesStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  HalfburpeesStandardScreen({required this.screenNavigator});

  @override
  _HalfburpeesStandardScreenState createState() =>
      _HalfburpeesStandardScreenState();
}

class _HalfburpeesStandardScreenState
    extends State<HalfburpeesStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Half Burpees')),
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
                  'Half Burpees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Place your hands on the floor in front of your feet and jump back into a high plank position '
                      'with your upper and lower body forming a straight line. Jump your feet back toward your hands '
                      'and repeat this back and forth movement with your feet for the desired number of repetitions.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/hbs.jpeg', // Replace with your actual image filename
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

class LegraisesStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  LegraisesStandardScreen({required this.screenNavigator});

  @override
  _LegraisesStandardScreenState createState() =>
      _LegraisesStandardScreenState();
}

class _LegraisesStandardScreenState
    extends State<LegraisesStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leg raises (bent knees)')),
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
                  'Leg raises (bent knees)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Brace your abs and lift your feet about 6 inches (about 15 cm) off of the floor.'
                      ' Maintain braced abdominals and slowly bend your knees to bring them to your chest '
                      'while keeping your lower legs parallel to the floor. Reverse the movement by slowly extending your legs.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/lrbks.jpeg', // Replace with your actual image filename
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

class MountainClimbersStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  MountainClimbersStandardScreen({required this.screenNavigator});

  @override
  _MountainClimbersStandardScreenState createState() =>
      _MountainClimbersStandardScreenState();
}

class _MountainClimbersStandardScreenState
    extends State<MountainClimbersStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Standard mountain climbers')),
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
                  'Standard mountain climbers',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Performed from a plank position, you will alternate bringing one knee to your chest, '
                      'then back out again, speeding up each time until you are running against the floor. '
                      'While the move sounds simple, mountain climbers exercise almost the entire body '
                      'and raise your heart rate.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/mcs.png', // Replace with your actual image filename
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

class PlankStandardScreen extends StatefulWidget {
  final ScreenNavigator screenNavigator;

  PlankStandardScreen({required this.screenNavigator});

  @override
  _PlankStandardScreenState createState() =>
      _PlankStandardScreenState();
}

class _PlankStandardScreenState
    extends State<PlankStandardScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plank Standard')),
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
                  'Plank Standard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'The plank exercise is an isometric core exercise that involves '
                      'maintaining a position similar to a push-up for the maximum possible time.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/plank.jpeg', // Replace with your actual image filename
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

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _seconds = 15;
  Timer? _timer;
  bool _breakStarted = false;
  List<Widget> screens = []; // List of screens
  int currentScreenIndex = 0; // Current screen index

  @override
  void initState() {
    super.initState();
    screens = [
      //JumpingJacksStandardScreen(screenNavigator: ScreenNavigator(context)),
      ButtkickStandardScreen(screenNavigator: ScreenNavigator(context)),
      SidetoSideStandardScreen(screenNavigator: ScreenNavigator(context)),
      SquatsStandardScreen(screenNavigator: ScreenNavigator(context)),
      RuninPlaceStandardScreen(screenNavigator: ScreenNavigator(context)),
      PushupStandardScreen(screenNavigator: ScreenNavigator(context)),
      HalfburpeesStandardScreen(screenNavigator: ScreenNavigator(context)),
      LegraisesStandardScreen(screenNavigator: ScreenNavigator(context)),
      MountainClimbersStandardScreen(screenNavigator: ScreenNavigator(context)),
      PlankStandardScreen(screenNavigator: ScreenNavigator(context)),
      CongratulationsScreen(),
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

class CrossJacksAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  CrossJacksAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _CrossJacksAdvancedScreenState createState() =>
      _CrossJacksAdvancedScreenState();
}

class _CrossJacksAdvancedScreenState
    extends State<CrossJacksAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cross Jacks')),
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
                  'Cross Jacks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stand tall with your feet together and arms out front at chest height. '
                      'Hop both feet out to the side while bringing arms out to the side as well. '
                      'Hop feet back in but cross left in front of right as well as crossing left arm over right.'
                      ' Repeat, crossing opposites',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/cross.png', // Replace with your actual image filename
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class ButtKickAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  ButtKickAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _ButtKickAdvancedScreenState createState() =>
      _ButtKickAdvancedScreenState();
}

class _ButtKickAdvancedScreenState
    extends State<ButtKickAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Butt kick (fast)')),
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
                  'Butt kick (fast)',
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class SidetoSideAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  SidetoSideAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _SidetoSideAdvancedScreenState createState() =>
      _SidetoSideAdvancedScreenState();
}

class _SidetoSideAdvancedScreenState
    extends State<SidetoSideAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Side to side skiers (explosive)')),
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
                  'Side to side skiers (explosive)',
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class SquatsAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  SquatsAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _SquatsAdvancedScreenState createState() =>
      _SquatsAdvancedScreenState();
}

class _SquatsAdvancedScreenState
    extends State<SquatsAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Squats (explosive)')),
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
                  'Squats (explosive)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'A squat is a strength exercise in which the trainee lowers their hips from a standing position '
                      'and then stands back up. During the descent, the hip and knee joints flex while the ankle joint dorsiflexes; '
                      'conversely the hip and knee joints extend and the ankle joint plantarflexes when standing up.'
                      'But in the explosive version you have to jump during the accession.',
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class HighKneesAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  HighKneesAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _HighKneesAdvancedScreenState createState() =>
      _HighKneesAdvancedScreenState();
}

class _HighKneesAdvancedScreenState
    extends State<HighKneesAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High knees')),
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
                  'High knees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stand with your feet hip-width apart. Lift up your left knee to your chest.'
                      'Switch to lift your right knee to your chest. Continue the movement, '
                      'alternating legs and moving at a sprinting or running pace.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/high.jpeg', // Replace with your actual image filename
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class PushupAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  PushupAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _PushupAdvancedScreenState createState() =>
      _PushupAdvancedScreenState();
}

class _PushupAdvancedScreenState
    extends State<PushupAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explosive push ups')),
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
                  'Explosive push ups',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lay down on the floor, facing down, with your hands at the width of your shoulders and your elbows bended. '
                      'Try to maintain your trunk as a plank and extend your arms '
                      'in an explosive way so that your hands lift off the floor. '
                      'If you are able to push yourself high enough in the air, you can clap your hands.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/pushup.jpeg', // Replace with your actual image filename
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class FullBurpeesAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  FullBurpeesAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _FullBurpeesAdvancedScreenState createState() =>
      _FullBurpeesAdvancedScreenState();
}

class _FullBurpeesAdvancedScreenState
    extends State<FullBurpeesAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Burpees')),
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
                  'Full Burpees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Start by standing erect with the arms by the side, feet should-width apart.'
                      ' Bend the knees, squatting down to place the hands on the floor in front of the feet. '
                      'Putting the bodyweight on the hands, the legs are thrust back to a push-up position '
                      'with a straight line from the shoulders to the heels.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/burpees.png', // Replace with your actual image filename
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class LegRaisesAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  LegRaisesAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _LegRaisesAdvancedScreenState createState() =>
      _LegRaisesAdvancedScreenState();
}

class _LegRaisesAdvancedScreenState
    extends State<LegRaisesAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leg raises (stretched knees)')),
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
          if (countdownTimer.showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class CrossClimbersAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  CrossClimbersAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _CrossClimbersAdvancedScreenState createState() =>
      _CrossClimbersAdvancedScreenState();
}

class _CrossClimbersAdvancedScreenState
    extends State<CrossClimbersAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cross climbers')),
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
                  'Cross climbers',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Bring one knee up towards your chest and twist towards the opposing elbow.'
                      '(Ex: Right knee to left elbow.) Contract the core and return the leg to the starting position.'
                      'Alternate between legs.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/crossclimbers.png', // Replace with your actual image filename
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class PlankAdvancedScreen extends StatefulWidget {
  final ScreenNavigatorAdvanced screenNavigatorAdvanced;

  PlankAdvancedScreen({required this.screenNavigatorAdvanced});

  @override
  _PlankAdvancedScreenState createState() =>
      _PlankAdvancedScreenState();
}

class _PlankAdvancedScreenState
    extends State<PlankAdvancedScreen> {
  CountdownTimer countdownTimer = CountdownTimer(seconds: 40);

  @override
  void dispose() {
    countdownTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plank with extended and stretched arms')),
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
                  'Plank with extended and stretched arms',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Get in a press-up position but with your arms as far in front of your head as you can reach. '
                      'Hold yourself there with your arms fully extended.'
                      ' Make sure your back is straight and hold for the alloted time. '
                      'Expert tips: Keep your abs and glutes locked to avoid sagging or rising from your hips.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Image.asset(
                  'images/plankex.jpeg', // Replace with your actual image filename
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
                onPressed: widget.screenNavigatorAdvanced.navigateToNextScreen,
                child: Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

class SecondScreenAdvanced extends StatefulWidget {
  @override
  _SecondScreenAdvancedState createState() => _SecondScreenAdvancedState();
}

class _SecondScreenAdvancedState extends State<SecondScreenAdvanced> {
  int _seconds = 15;
  Timer? _timer;
  bool _breakStarted = false;
  List<Widget> screens = []; // List of screens
  int currentScreenIndex = 0; // Current screen index

  @override
  void initState() {
    super.initState();
    screens = [
      //CrossJacksAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      ButtKickAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      SidetoSideAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      SquatsAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      HighKneesAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      PushupAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      FullBurpeesAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      LegRaisesAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      CrossClimbersAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      PlankAdvancedScreen(screenNavigatorAdvanced: ScreenNavigatorAdvanced(context)),
      CongratulationsScreen(),
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

class CountdownTimers extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget nextScreen;
  final int initialCountdown;

  CountdownTimers({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.nextScreen,
    this.initialCountdown = 30,
  });

  @override
  _CountdownTimersState createState() => _CountdownTimersState();
}

class _CountdownTimersState extends State<CountdownTimers> {
  int countdown = 30;
  bool isCountdownActive = false;

  @override
  void initState() {
    super.initState();
    countdown = widget.initialCountdown;
  }

  void startCountdown() {
    if (!isCountdownActive) {
      setState(() {
        countdown = widget.initialCountdown;
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
              Image.asset(
                widget.imagePath,
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
                      builder: (context) => widget.nextScreen,
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Sets: 4 sets Reps: Until Failure for each set.'
                    'Or if the exercise does not include reps, Sets: 4 sets Reps: Until Failure for each set.',
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

class GuestLowerSquatsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Squats',
      description:
      'A squat is a strength exercise in which the trainee lowers their hips from a standing position '
          'and then stands back up. During the descent, the hip and knee joints flex while'
          ' the ankle joint dorsiflexes; conversely the hip and knee joints extend '
          'and the ankle joint plantarflexes when standing up.',
      imagePath: 'images/squats.jpeg',
      nextScreen: GuestLowerSideLungesScreenStandard(),
    );
  }
}

class GuestLowerSideLungesScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Side lunges',
      description:
      'Stand with your feet hip-width apart. Step to the side while keeping your other foot flat.'
          ' Bend your “stepping” knee while keeping the other knee straight. '
          'Your body will hinge forward slightly, '
          'and your shoulders will be slightly ahead of your knee compared with forward and backward lunges.',
      imagePath: 'images/sidelunges.png',
      nextScreen: GuestLowerSplitsSquatsScreenStandard(),
    );
  }
}

class GuestLowerSplitsSquatsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Split squats',
      description:
      'A split squat is a lower body exercise that works one leg at a time. '
          'Your legs are split with one leg in front of you '
          'and the other behind you on an elevated surface like a bench. '
          'This exercise works the front leg muscles.',
      imagePath: 'images/sidesquats.png',
      nextScreen: GuestLowerCircuitScreenStandard(),
    );
  }
}

class GuestLowerCircuitScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Lower Circuit',
      description:
      'pulse squats:  In pulse squats, this pulse is performed at the bottom quarter of the squat,'
          ' so you would squat down, push up a quarter of the way back up, and pulse up and down from there.'
          ' One quarter up and down would be one rep.'
          'jump squats: Jump squats are bodyweight exercises characterized by leaping directly upwards at the top of the movement.'
          'high knees: Stand with your feet hip-width apart. Lift up your left knee to your chest.'
          'Switch to lift your right knee to your chest. Continue the movement, alternating legs and moving at a sprinting or running pace.',
      imagePath: 'images/circuit.png',
      nextScreen: GuestLowerCalfRaisesScreenStandard(),
    );
  }
}

class GuestLowerCalfRaisesScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Calf raises',
      description:
      'The calf raise, also known as the standing calf raise, '
          'is a bodyweight exercise that targets the muscle groups in your lower legs. '
          'Perform calf raises by standing tall with your feet hip-width apart. '
          'Lift your body by pushing into the fronts of your feet, '
          'activating your calf muscles as you stand on your tiptoes.',
      imagePath: 'images/calf.jpeg',
      nextScreen: GuestCongratulationsScreen(),
    );
  }
}

class LowerSquatsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Squats',
      description:
      'A squat is a strength exercise in which the trainee lowers their hips from a standing position '
          'and then stands back up. During the descent, the hip and knee joints flex while'
          ' the ankle joint dorsiflexes; conversely the hip and knee joints extend '
          'and the ankle joint plantarflexes when standing up.',
      imagePath: 'images/squats.jpeg',
      nextScreen: LowerSideLungesScreenStandard(),
    );
  }
}

class LowerSideLungesScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Side lunges',
      description:
      'Stand with your feet hip-width apart. Step to the side while keeping your other foot flat.'
          ' Bend your “stepping” knee while keeping the other knee straight. '
          'Your body will hinge forward slightly, '
          'and your shoulders will be slightly ahead of your knee compared with forward and backward lunges.',
      imagePath: 'images/sidelunges.png',
      nextScreen: LowerSplitsSquatsScreenStandard(),
    );
  }
}

class LowerSplitsSquatsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Split squats',
      description:
      'A split squat is a lower body exercise that works one leg at a time. '
          'Your legs are split with one leg in front of you '
          'and the other behind you on an elevated surface like a bench. '
          'This exercise works the front leg muscles.',
      imagePath: 'images/sidesquats.png',
      nextScreen: LowerCircuitScreenStandard(),
    );
  }
}

class LowerCircuitScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Lower Circuit',
      description:
      'pulse squats:  In pulse squats, this pulse is performed at the bottom quarter of the squat,'
          ' so you would squat down, push up a quarter of the way back up, and pulse up and down from there.'
          ' One quarter up and down would be one rep.'
          'jump squats: Jump squats are bodyweight exercises characterized by leaping directly upwards at the top of the movement.'
          'high knees: Stand with your feet hip-width apart. Lift up your left knee to your chest.'
          'Switch to lift your right knee to your chest. Continue the movement, alternating legs and moving at a sprinting or running pace.',
      imagePath: 'images/circuit.png',
      nextScreen: LowerCalfRaisesScreenStandard(),
    );
  }
}

class LowerCalfRaisesScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Calf raises',
      description:
      'The calf raise, also known as the standing calf raise, '
          'is a bodyweight exercise that targets the muscle groups in your lower legs. '
          'Perform calf raises by standing tall with your feet hip-width apart. '
          'Lift your body by pushing into the fronts of your feet, '
          'activating your calf muscles as you stand on your tiptoes.',
      imagePath: 'images/calf.jpeg',
      nextScreen: CongratulationsScreen(),
    );
  }
}

class GuestPushUpUpperScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Pushups',
      description:
      'From a prone position, the hands are placed under the shoulders with the elbows extended. '
          'Keeping the back and legs straight with the toes touching the ground. '
          'The body is lowered until the upper arm is parallel to the ground. '
          'Then reverse the movement and raise the body until the arm is extended.',
      imagePath: 'images/pushup.jpeg',
      nextScreen: GuestBirdDogHoldScreenStandard(),
    );
  }
}

class GuestBirdDogHoldScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Bird dog hold',
      description:
      'Draw your shoulder blades together. Raise your right arm and left leg, '
          'keeping your shoulders and hips parallel to the floor. '
          'Lengthen the back of your neck and tuck your chin into your chest to gaze down at the floor. '
          'Hold this position for a few seconds, then lower back down to the starting position.',
      imagePath: 'images/bdh.png',
      nextScreen: GuestTricepsExtensionScreenStandard(),
    );
  }
}

class GuestTricepsExtensionScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Bodyweight triceps extension',
      description:
      'Set up by grabbing the bar with both hands in an overhand grip.'
          'Extend your arms so that your elbows are locked, and maintain a tight standing plank position,'
          'keeping you glutes and abs squeezed. '
          'From here, bend your elbows and bring your torso forward, as your head dips under the bar.',
      imagePath: 'images/tes.jpeg',
      nextScreen: GuestDragonWalkScreenStandard(),
    );
  }
}

class GuestDragonWalkScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Dragon walk',
      description:
      'Start in a push-up position. Go down into a push-up, and on your way back up, '
          'raise your left arm and right leg into the air, keeping your hips square to the floor. '
          'As you move your left hand forward and position it onto the floor, '
          'bring your right leg to your side at a 90-degree angle and complete a staggered push-up.',
      imagePath: 'images/dw.jpeg',
      nextScreen: GuestOverheadPushupScreenStandard(),
    );
  }
}

class GuestOverheadPushupScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Overhead pushups',
      description:
      'Start in a standard pushup position with your hands slightly wider than shoulder-width apart '
          'and elbows completely locked out. '
          'Shoot your hips towards the ceiling and plant your toes into the ground'
          ' so your body looks like an upside-down V. Slowly lower the top of your head towards the ground.',
      imagePath: 'images/spus.jpeg',
      nextScreen: GuestPlankUpperScreenStandard(),
    );
  }
}

class GuestPlankUpperScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Plank Standard',
      description:
      'The plank exercise is an isometric core exercise that involves maintaining a position '
          'similar to a push-up for the maximum possible time.',
      imagePath: 'images/plank.jpeg',
      nextScreen: GuestSitupsScreenStandard(),
    );
  }
}

class GuestSitupsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
        title: 'Sit ups',
        description:
        'Situps are classic abdominal exercises done by lying on your back and lifting your torso. '
            'They use your body weight to strengthen and tone the core-stabilizing abdominal muscles. '
            'Situps work the rectus abdominis, transverse abdominis, and obliques in addition to your hip flexors, chest, and neck',
        imagePath: 'images/situps.png',
        nextScreen: GuestSidePlankScreenStandard(),
    );
  }
}

class GuestSidePlankScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Side planks',
      description:
      'Lie on your side with your knees bent, and prop your upper body up on your elbow. '
          'Raise your hips off the floor.',
      imagePath: 'images/sideplank.png',
      nextScreen: GuestReverseSnowAngelsScreenStandard(),
    );
  }
}

class GuestReverseSnowAngelsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Reverse snow angels',
      description:
      'Lie down on the floor on your chest and stomach. '
          'Stretch your hands forward and your legs at the back. '
          'The palms should face the floor and your toes should be pointed towards the floor. '
          'Lift your arms and legs so that they hover across the floor.',
      imagePath: 'images/rsas.png',
      nextScreen: GuestNoseAndToesScreenStandard(),
    );
  }
}

class GuestNoseAndToesScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Nose and Toes Against the Wall',
      description:
      'Setup Begin standing with feet about 6 inches away from a wall and your feet close together.'
          ' Lean towards the wall as far as you can '
          'keeping your body in a straight line and your heels on the ground.'
          ' Return to the starting position and repeat.',
      imagePath: 'images/naratw.jpeg',
      nextScreen: GuestCongratulationsScreen(),
    );
  }
}

class PushUpUpperScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Pushups',
      description:
      'From a prone position, the hands are placed under the shoulders with the elbows extended.'
          'Keeping the back and legs straight with the toes touching the ground. '
          'The body is lowered until the upper arm is parallel to the ground. '
          'Then reverse the movement and raise the body until arm is extended.',
      imagePath: 'images/pushup.jpeg',
      nextScreen: BirdDogHoldScreenStandard(),
    );
  }
}

class BirdDogHoldScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Bird dog hold',
      description:
      'Draw your shoulder blades together. Raise your right arm and left leg, '
          'keeping your shoulders and hips parallel to the floor. '
          'Lengthen the back of your neck and tuck your chin into your chest to gaze down at the floor.'
          'Hold this position for a few seconds, then lower back down to the starting position.',
      imagePath: 'images/bdh.png',
      nextScreen: TricepsExtensionScreenStandard(),
    );
  }
}

class TricepsExtensionScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Bodyweight triceps extension',
      description:
      'Set up by grabbing the bar with both hands in an overhand grip.'
          'Extend your arms so that your elbows are locked, and maintain a tight standing plank position,'
          'keeping you glutes and abs squeezed. '
          'From here, bend your elbows and bring your torso forward, as your head dips under the bar.',
      imagePath: 'images/tes.jpeg',
      nextScreen: DragonWalkScreenStandard(),
    );
  }
}

class DragonWalkScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Dragon walk',
      description:
      'Start in a push-up position. Go down into a push-up, and on your way back up, '
          'raise your left arm and right leg into the air, keeping your hips square to the floor. '
          'As you move your left hand forward and position it onto the floor, '
          'bring your right leg to your side at a 90-degree angle and complete a staggered push-up.',
      imagePath: 'images/dw.jpeg',
      nextScreen: OverheadPushupScreenStandard(),
    );
  }
}

class OverheadPushupScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Overhead pushups',
      description:
      'Start in a standard pushup position with your hands slightly wider than shoulder-width apart '
          'and elbows completely locked out. '
          'Shoot your hips towards the ceiling and plant your toes into the ground'
          ' so your body looks like an upside-down V. Slowly lower the top of your head towards the ground.',
      imagePath: 'images/spus.jpeg',
      nextScreen: PlankUpperScreenStandard(),
    );
  }
}

class PlankUpperScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Plank Standard',
      description:
      'The plank exercise is an isometric core exercise that involves maintaining a position '
          'similar to a push-up for the maximum possible time.',
      imagePath: 'images/plank.jpeg',
      nextScreen: SitupsScreenStandard(),
    );
  }
}

class SitupsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Sit ups',
      description:
      'Situps are classic abdominal exercises done by lying on your back and lifting your torso. '
          'They use your body weight to strengthen and tone the core-stabilizing abdominal muscles. '
          'Situps work the rectus abdominis, transverse abdominis, and obliques in addition to your hip flexors, chest, and neck',
      imagePath: 'images/situps.png',
      nextScreen: SidePlankScreenStandard(),
    );
  }
}

class SidePlankScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Side planks',
      description:
      'Lie on your side with your knees bent, and prop your upper body up on your elbow. '
          'Raise your hips off the floor.',
      imagePath: 'images/sideplank.png',
      nextScreen: ReverseSnowAngelsScreenStandard(),
    );
  }
}

class ReverseSnowAngelsScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Reverse snow angels',
      description:
      'Lie down on the floor on your chest and stomach. '
          'Stretch your hands forward and your legs at the back. '
          'The palms should face the floor and your toes should be pointed towards the floor. '
          'Lift your arms and legs so that they hover across the floor.',
      imagePath: 'images/rsas.png',
      nextScreen: NoseAndToesScreenStandard(),
    );
  }
}

class NoseAndToesScreenStandard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimers(
      title: 'Nose and Toes Against the Wall',
      description:
      'Setup Begin standing with feet about 6 inches away from a wall and your feet close together.'
          ' Lean towards the wall as far as you can '
          'keeping your body in a straight line and your heels on the ground.'
          ' Return to the starting position and repeat.',
      imagePath: 'images/naratw.jpeg',
      nextScreen: CongratulationsScreen(),
    );
  }
}

class CountdownTimersAdvanced extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget nextScreen;
  final int initialCountdown;

  CountdownTimersAdvanced({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.nextScreen,
    this.initialCountdown = 30,
  });

  @override
  _CountdownTimersAdvancedState createState() => _CountdownTimersAdvancedState();
}

class _CountdownTimersAdvancedState extends State<CountdownTimersAdvanced> {
  int countdown = 30;
  bool isCountdownActive = false;

  @override
  void initState() {
    super.initState();
    countdown = widget.initialCountdown;
  }

  void startCountdown() {
    if (!isCountdownActive) {
      setState(() {
        countdown = widget.initialCountdown;
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
              Image.asset(
                widget.imagePath,
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
                      builder: (context) => widget.nextScreen,
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Sets: 5 sets Reps for each set: 15, 12, 10, 8, 5'
                    'Or if the exercise does not include reps, Sets: 5 sets Reps: Until Failure for each set.',
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

class LowerExplosiveSquatsScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Squats',
      description:
      'Stand with your feet shoulder-width apart, toes pointed forward. '
          'Interlock fingers behind head with elbows flared out. '
          'Descend into a full squat position with thighs parallel to ground for a few seconds. '
          'Quickly drive through the heels, jumping off ground as high as possible, keeping hands behind the head',
      imagePath: 'images/squats.jpeg',
      nextScreen: LowerOneLegSquatsScreenAdvanced(),
    );
  }
}

class LowerOneLegSquatsScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'One Leg Squats',
      description:
      'Stand on one leg, with the other leg and your arms out in front of you. '
          'Squat, bending at the knee and sitting your hips back. '
          'Keep the other knee in line over your foot.'
          'Once you feel the squat in your quad and glutes, extend your leg back up to standing.',
      imagePath: 'images/oneleg.jpeg',
      nextScreen: LowerExplosiveSplitSquadsScreenAdvanced(),
    );
  }
}

class LowerExplosiveSplitSquadsScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Split squats',
      description:
      'Your legs are split with one leg in front of you and the other behind you on an elevated surface '
          'like a bench. This exercise works the front leg muscles.'
          ' Split squats put emphasis on your quadriceps to support your body weight '
          'and require core engagement to stay upright and balanced.',
      imagePath: 'images/sidesquats.png',
      nextScreen: LowerCircuitScreenAdvanced(),
    );
  }
}

class LowerCircuitScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Lower Circuit',
      description:
      'pulse squats:  In pulse squats, this pulse is performed at the bottom quarter of the squat,'
          ' so you would squat down, push up a quarter of the way back up, and pulse up and down from there.'
          ' One quarter up and down would be one rep.'
          'jump squats: Jump squats are bodyweight exercises characterized by leaping directly upwards at the top of the movement.'
          'high knees: Stand with your feet hip-width apart. Lift up your left knee to your chest.'
          'Switch to lift your right knee to your chest. Continue the movement, alternating legs and moving at a sprinting or running pace.',
      imagePath: 'images/circuit.png',
      nextScreen: LowerExplosiveCalfRaisesScreenAdvanced(),
    );
  }
}

class LowerExplosiveCalfRaisesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Calf raises',
      description:
      'Stand with feet just wider than hip-width apart, '
          'toes pointed slightly out, and clasp hands at chest for balance. '
          'Send hips back and bend at knees to lower down as far as possible with chest lifted. '
          'You can swing your arms back for momentum. Press through heels back up to explode up,'
          'jumping vertically in the air.',
      imagePath: 'images/calf.jpeg',
      nextScreen: CongratulationsScreen(),
    );
  }
}

class GuestLowerExplosiveSquatsScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Squats',
      description:
      'Stand with your feet shoulder-width apart, toes pointed forward. '
          'Interlock fingers behind head with elbows flared out. '
          'Descend into a full squat position with thighs parallel to ground for a few seconds. '
          'Quickly drive through the heels, jumping off ground as high as possible, keeping hands behind the head',
      imagePath: 'images/squats.jpeg',
      nextScreen: GuestLowerOneLegSquatsScreenAdvanced(),
    );
  }
}

class GuestLowerOneLegSquatsScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'One Leg Squats',
      description:
      'Stand on one leg, with the other leg and your arms out in front of you. '
          'Squat, bending at the knee and sitting your hips back. '
          'Keep the other knee in line over your foot.'
          'Once you feel the squat in your quad and glutes, extend your leg back up to standing.',
      imagePath: 'images/oneleg.jpeg',
      nextScreen: GuestLowerExplosiveSplitSquadsScreenAdvanced(),
    );
  }
}

class GuestLowerExplosiveSplitSquadsScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Split squats',
      description:
      'Your legs are split with one leg in front of you and the other behind you on an elevated surface '
          'like a bench. This exercise works the front leg muscles.'
          ' Split squats put emphasis on your quadriceps to support your body weight '
          'and require core engagement to stay upright and balanced.',
      imagePath: 'images/sidesquats.png',
      nextScreen: GuestLowerCircuitScreenAdvanced(),
    );
  }
}

class GuestLowerCircuitScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Lower Circuit',
      description:
      'pulse squats:  In pulse squats, this pulse is performed at the bottom quarter of the squat,'
          ' so you would squat down, push up a quarter of the way back up, and pulse up and down from there.'
          ' One quarter up and down would be one rep.'
          'jump squats: Jump squats are bodyweight exercises characterized by leaping directly upwards at the top of the movement.'
          'high knees: Stand with your feet hip-width apart. Lift up your left knee to your chest.'
          'Switch to lift your right knee to your chest. Continue the movement, alternating legs and moving at a sprinting or running pace.',
      imagePath: 'images/circuit.png',
      nextScreen: GuestLowerExplosiveCalfRaisesScreenAdvanced(),
    );
  }
}

class GuestLowerExplosiveCalfRaisesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Calf raises',
      description:
      'Stand with feet just wider than hip-width apart, '
          'toes pointed slightly out, and clasp hands at chest for balance. '
          'Send hips back and bend at knees to lower down as far as possible with chest lifted. '
          'You can swing your arms back for momentum. Press through heels back up to explode up,'
          'jumping vertically in the air.',
      imagePath: 'images/calf.jpeg',
      nextScreen: GuestCongratulationsScreen(),
    );
  }
}

class GuestExplosivePushUpScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Pushups',
      description:
      'Lay down on the floor, facing down, '
          'with your hands at the width of your shoulders and your elbows bended.'
          ' Try to maintain your trunk as a plank'
          ' and extend your arms in an explosive way so that your hands lift off the floor. '
          'If you are able to push yourself high enough in the air, you can clap your hands',
      imagePath: 'images/pushup.jpeg',
      nextScreen: GuestDiamondPressScreenAdvanced(),
    );
  }
}

class GuestDiamondPressScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Diamond press up',
      description:
      'In a diamond push-up, you touch your thumbs and index fingers together '
          'to make a diamond shape directly in front of the center of your chest.'
          ' This difference may seem subtle, but it changes the weight distribution of the press.'
          ' Diamond push-ups recruit smaller muscles, generally making the movement more difficult.',
      imagePath: 'images/diamond.jpeg',
      nextScreen: GuestTricepDipScreenAdvanced(),
    );
  }
}

class GuestTricepDipScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Tricep dips',
      description:
      'Tricep dips can be performed on parallel bars at your gym or even on a playground. '
          'You hold your entire body weight up with your arms extended and feet hovering over the floor,'
          ' ankles crossed. Lower your body until your elbows reach a 90-degree angle'
          ' before returning to your starting position.',
      imagePath: 'images/dips.png',
      nextScreen: GuestPlankExtendedScreenAdvanced(),
    );
  }
}

class GuestPlankExtendedScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Plank with extended and stretched arms',
      description:
      'Get in a press-up position but with your arms as far in front of your head as you can reach. '
          'Hold yourself there with your arms fully extended. '
          'Make sure your back is straight and hold for the alloted time. '
          'Expert tips: Keep your abs and glutes locked to avoid sagging or rising from your hips.',
      imagePath: 'images/plankex.jpeg',
      nextScreen: GuestLegRaisesScreenAdvanced(),
    );
  }
}

class GuestLegRaisesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Leg raises',
      description:
      'Lie on your back, legs straight and together.'
          'Keep your legs straight and lift them all the way up to the ceiling until your butt comes off the floor.'
          'Slowly lower your legs back down till they are just above the floor. Hold for a moment.'
          'Raise your legs back up. Repeat.',
      imagePath: 'images/legraises.png',
      nextScreen: GuestSideLegRaisesScreenAdvanced(),
    );
  }
}

class GuestSideLegRaisesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Side leg raises',
      description:
      'Side leg raises is a core and leg exercise that involves you lying on the floor on your side, '
          'and abducting your leg (pushing them) away from the midline. '
          'You can also perform this whilst standing up. This exercise is great to develop strength'
          ' and endurance in the core, thighs, and hip abductors.',
      imagePath: 'images/sideleg.png',
      nextScreen: GuestDolphinKicksScreenAdvanced(),
    );
  }
}

class GuestDolphinKicksScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Dolphin kicks',
      description:
      'It is similar to a kick that you would do in butterfly, but a few feet underwater. '
          'This is a very compact, and efficient kick, so make sure your legs are together, '
          'your arms are squeezed against your ears, and you keep your core solid.',
      imagePath: 'images/dolphin.jpeg',
      nextScreen: GuestSupermanScreenAdvanced(),
    );
  }
}

class GuestSupermanScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Superman',
      description:
      'Lie on the floor in a prone (facedown) position, with your legs straight '
          'and your arms extended in front of you. Keeping your head in a neutral position (avoid looking up),'
          ' slowly lift your arms and legs around 6 inches (15.3 cm) off the floor,'
          ' or until you feel your lower back muscles contracting.',
      imagePath: 'images/superman.png',
      nextScreen: GuestHandStandPushUpScreenAdvanced(),
    );
  }
}

class GuestHandStandPushUpScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Handstand pushups',
      description:
      'The handstand push-ups (sometimes abbreviated as HSPU) is an advanced push-up variation '
          'that involves standing upside down on your hands and engaging your arms, shoulders, '
          'and core muscles to lift your body',
      imagePath: 'images/hand.jpeg',
      nextScreen: GuestNoseAndtoesScreenAdvanced(),
    );
  }
}

class GuestNoseAndtoesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Nose and Toes Against the Wall',
      description:
      'Setup Begin standing with feet about 6 inches away from a wall and your feet close together. '
          'Lean towards the wall as far as you can keeping your body in a straight line '
          'and your heels on the ground. Return to the starting position and repeat.',
      imagePath: 'images/naratw.jpeg',
      nextScreen: GuestCongratulationsScreen(),
    );
  }
}

class ExplosivePushUpScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Explosive Pushups',
      description:
      'Lay down on the floor, facing down, '
          'with your hands at the width of your shoulders and your elbows bended.'
          ' Try to maintain your trunk as a plank'
          ' and extend your arms in an explosive way so that your hands lift off the floor. '
          'If you are able to push yourself high enough in the air, you can clap your hands',
      imagePath: 'images/pushup.jpeg',
      nextScreen: DiamondPressScreenAdvanced(),
    );
  }
}

class DiamondPressScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Diamond press up',
      description:
      'In a diamond push-up, you touch your thumbs and index fingers together '
          'to make a diamond shape directly in front of the center of your chest.'
          ' This difference may seem subtle, but it changes the weight distribution of the press.'
          ' Diamond push-ups recruit smaller muscles, generally making the movement more difficult.',
      imagePath: 'images/diamond.jpeg',
      nextScreen: TricepDipScreenAdvanced(),
    );
  }
}

class TricepDipScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Tricep dips',
      description:
      'Tricep dips can be performed on parallel bars at your gym or even on a playground. '
          'You hold your entire body weight up with your arms extended and feet hovering over the floor,'
          ' ankles crossed. Lower your body until your elbows reach a 90-degree angle'
          ' before returning to your starting position.',
      imagePath: 'images/dips.png',
      nextScreen: PlankExtendedScreenAdvanced(),
    );
  }
}

class PlankExtendedScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Plank with extended and stretched arms',
      description:
      'Get in a press-up position but with your arms as far in front of your head as you can reach. '
          'Hold yourself there with your arms fully extended. '
          'Make sure your back is straight and hold for the alloted time. '
          'Expert tips: Keep your abs and glutes locked to avoid sagging or rising from your hips.',
      imagePath: 'images/plankex.jpeg',
      nextScreen: LegRaisesScreenAdvanced(),
    );
  }
}

class LegRaisesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Leg raises',
      description:
      'Lie on your back, legs straight and together.'
          'Keep your legs straight and lift them all the way up to the ceiling until your butt comes off the floor.'
          'Slowly lower your legs back down till they are just above the floor. Hold for a moment.'
          'Raise your legs back up. Repeat.',
      imagePath: 'images/legraises.png',
      nextScreen: SideLegRaisesScreenAdvanced(),
    );
  }
}

class SideLegRaisesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Side leg raises',
      description:
      'Side leg raises is a core and leg exercise that involves you lying on the floor on your side, '
          'and abducting your leg (pushing them) away from the midline. '
          'You can also perform this whilst standing up. This exercise is great to develop strength'
          ' and endurance in the core, thighs, and hip abductors.',
      imagePath: 'images/sideleg.png',
      nextScreen: DolphinKicksScreenAdvanced(),
    );
  }
}

class DolphinKicksScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Dolphin kicks',
      description:
      'It is similar to a kick that you would do in butterfly, but a few feet underwater. '
          'This is a very compact, and efficient kick, so make sure your legs are together, '
          'your arms are squeezed against your ears, and you keep your core solid.',
      imagePath: 'images/dolphin.jpeg',
      nextScreen: SupermanScreenAdvanced(),
    );
  }
}

class SupermanScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Superman',
      description:
      'Lie on the floor in a prone (facedown) position, with your legs straight '
          'and your arms extended in front of you. Keeping your head in a neutral position (avoid looking up),'
          ' slowly lift your arms and legs around 6 inches (15.3 cm) off the floor,'
          ' or until you feel your lower back muscles contracting.',
      imagePath: 'images/superman.png',
      nextScreen: HandStandPushUpScreenAdvanced(),
    );
  }
}

class HandStandPushUpScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Handstand pushups',
      description:
      'The handstand push-ups (sometimes abbreviated as HSPU) is an advanced push-up variation '
          'that involves standing upside down on your hands and engaging your arms, shoulders, '
          'and core muscles to lift your body',
      imagePath: 'images/hand.jpeg',
      nextScreen: NoseAndtoesScreenAdvanced(),
    );
  }
}

class NoseAndtoesScreenAdvanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountdownTimersAdvanced(
      title: 'Nose and Toes Against the Wall',
      description:
      'Setup Begin standing with feet about 6 inches away from a wall and your feet close together. '
          'Lean towards the wall as far as you can keeping your body in a straight line '
          'and your heels on the ground. Return to the starting position and repeat.',
      imagePath: 'images/naratw.jpeg',
      nextScreen: CongratulationsScreen(),
    );
  }
}

