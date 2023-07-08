import 'package:flutter/material.dart';

class TypesOfWorkouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Types of Workouts'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Upper Workout Standard',
            image: 'images/upper_standard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpperStandardScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Upper Workout Advanced',
            image: 'images/upper_advanced.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpperAdvancedScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Lower Workout Standard',
            image: 'images/lower_standard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LowerStandardScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Lower Workout Advanced',
            image: 'images/lower_advanced.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LowerAdvancedScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'HIIT Workout Standard',
            image: 'images/hiit_standard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HiitStandardScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'HIIT Workout Advanced',
            image: 'images/hiit_advanced.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HiitAdvancedScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Upper Workout Standard',
            image: 'images/upper_standard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestUpperStandardScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Upper Workout Advanced',
            image: 'images/upper_advanced.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestUpperAdvancedScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Lower Workout Standard',
            image: 'images/lower_standard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestLowerStandardScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'Lower Workout Advanced',
            image: 'images/lower_advanced.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestLowerAdvancedScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'HIIT Workout Standard',
            image: 'images/hiit_standard.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestHiitStandardScreen()),
              );
            },
          ),
          CustomRightAlignedContainer(
            title: 'HIIT Workout Advanced',
            image: 'images/hiit_advanced.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestHiitAdvancedScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomRightAlignedContainer extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPressed;

  const CustomRightAlignedContainer({
    required this.title,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class UpperStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Standard'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'After you press start complete the number of each set and reps'
                  ' before proceeding to the next exercise.',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Pushups',
            image: 'images/pushup.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Bird dog hold',
            image: 'images/bdh.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Bodyweight triceps extension',
            image: 'images/tes.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Dragon walk',
            image: 'images/dw.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Overhead pushups',
            image: 'images/spus.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Plank Standard',
            image: 'images/plank.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Sit ups',
            image: 'images/situps.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Side planks',
            image: 'images/sideplank.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Reverse snow angels',
            image: 'images/rsas.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Nose and Toes Against the Wall',
            image: 'images/naratw.jpeg', onPressed: () {  },
          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PushUpUpperScreenStandard(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
class UpperAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Advanced'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'After you press start complete the number of each set and reps'
                  ' before proceeding to the next exercise.',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Explosive Pushups',
            image: 'images/pushup.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Diamond press up',
            image: 'images/diamond.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Tricep dips',
            image: 'images/dips.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/plankex.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises',
            image: 'images/legraises.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side leg raises',
            image: 'images/sideleg.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Dolphin kicks',
            image: 'images/dolphin.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Superman',
            image: 'images/superman.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Handstand pushups',
            image: 'images/hand.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Nose and Toes Against the Wall',
            image: 'images/naratw.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ExplosivePushUpScreenAdvanced(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class LowerStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lower Workout Standard'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Squats',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side lunges',
            image: 'images/sidelunges.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Split squats',
            image: 'images/sidesquats.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: '6x6x6 Circuit',
            image: 'images/circuit.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Calf raises',
            image: 'images/calf.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LowerSquatsScreenStandard(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}


class LowerAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lower Workout Advanced'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Explosive Squats',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'One Leg Squats',
            image: 'images/oneleg.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Explosive Split squats',
            image: 'images/sidesquats.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: '15x15x15 Circuit',
            image: 'images/circuit.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Explosive Calf raises',
            image: 'images/calf.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LowerExplosiveSquatsScreenAdvanced(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class HiitStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiit Workout Standard'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Each exercise lasts for 40 seconds,'
                  'after that you have 15 seconds of rest '
                  'and then you proceed to the next one',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Jumping Jacks',
            image: 'images/jjs.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Butt kick (slow)',
            image: 'images/bks.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side to side skiers (slow)',
            image: 'images/sss.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Squats',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Run in place',
            image: 'images/rip.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Standard Pushups',
            image: 'images/pushup.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Half Burpees',
            image: 'images/hbs.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises (bent knees)',
            image: 'images/lrbks.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Standard mountain climbers',
            image: 'images/mcs.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Plank Standard',
            image: 'images/plank.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => JumpingJacksStandardScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class HiitAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiit Workout Advanced'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Each exercise lasts for 40 seconds,'
                  'after that you have 15 seconds of rest '
                  'and then you proceed to the next one',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Cross Jacks',
            image: 'images/cross.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Butt kick (fast)',
            image: 'images/bks.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side to side skiers (explosive)',
            image: 'images/sss.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Squats (explosive)',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'High knees',
            image: 'images/high.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Explosive push ups',
            image: 'images/pushup.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Full Burpees',
            image: 'images/burpees.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises (stretched knees)',
            image: 'images/legraises.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Cross climbers',
            image: 'images/crossclimbers.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/plankex.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CrossJacksAdvancedScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class GuestHiitStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiit Workout Standard'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Each exercise lasts for 40 seconds,'
                  'after that you have 15 seconds of rest '
                  'and then you proceed to the next one',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Jumping Jacks',
            image: 'images/jjs.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Butt kick (slow)',
            image: 'images/bks.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side to side skiers (slow)',
            image: 'images/sss.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Squats',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Run in place',
            image: 'images/rip.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Standard Pushups',
            image: 'images/pushup.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Half Burpees',
            image: 'images/hbs.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises (bent knees)',
            image: 'images/lrbks.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Standard mountain climbers',
            image: 'images/mcs.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Plank Standard',
            image: 'images/plank.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GuestJumpingJacksStandardScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class GuestHiitAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiit Workout Advanced'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Each exercise lasts for 40 seconds,'
                  'after that you have 15 seconds of rest '
                  'and then you proceed to the next one',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Cross Jacks',
            image: 'images/cross.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Butt kick (fast)',
            image: 'images/bks.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side to side skiers (explosive)',
            image: 'images/sss.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Squats (explosive)',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'High knees',
            image: 'images/high.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Explosive push ups',
            image: 'images/pushup.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Full Burpees',
            image: 'images/burpees.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises (stretched knees)',
            image: 'images/legraises.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Cross climbers',
            image: 'images/crossclimbers.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/plankex.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GuestCrossJacksAdvancedScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class GuestLowerStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lower Workout Standard'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Squats',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side lunges',
            image: 'images/sidelunges.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Split squats',
            image: 'images/sidesquats.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: '6x6x6 Circuit',
            image: 'images/circuit.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Calf raises',
            image: 'images/calf.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GuestLowerSquatsScreenStandard(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class GuestLowerAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lower Workout Advanced'),
      ),
      body: ListView(
        children: [
          CustomRightAlignedContainer(
            title: 'Explosive Squats',
            image: 'images/squats.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'One Leg Squats',
            image: 'images/oneleg.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Explosive Split squats',
            image: 'images/sidesquats.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: '15x15x15 Circuit',
            image: 'images/circuit.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Explosive Calf raises',
            image: 'images/calf.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GuestLowerExplosiveSquatsScreenAdvanced(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class GuestUpperStandardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Standard'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'After you press start complete the number of each set and reps'
                  ' before proceeding to the next exercise.',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Pushups',
            image: 'images/pushup.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Bird dog hold',
            image: 'images/bdh.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Bodyweight triceps extension',
            image: 'images/tes.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Dragon walk',
            image: 'images/dw.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Overhead pushups',
            image: 'images/spus.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Plank Standard',
            image: 'images/plank.jpeg', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Sit ups',
            image: 'images/situps.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Side planks',
            image: 'images/sideplank.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Reverse snow angels',
            image: 'images/rsas.png', onPressed: () {  },
          ),
          CustomRightAlignedContainer(
            title: 'Nose and Toes Against the Wall',
            image: 'images/naratw.jpeg', onPressed: () {  },
          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GuestPushUpUpperScreenStandard(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

class GuestUpperAdvancedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upper Workout Advanced'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'After you press start complete the number of each set and reps'
                  ' before proceeding to the next exercise.',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomRightAlignedContainer(
            title: 'Explosive Pushups',
            image: 'images/pushup.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Diamond press up',
            image: 'images/diamond.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Tricep dips',
            image: 'images/dips.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Plank with extended and stretched arms',
            image: 'images/plankex.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Leg raises',
            image: 'images/legraises.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Side leg raises',
            image: 'images/sideleg.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Dolphin kicks',
            image: 'images/dolphin.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Superman',
            image: 'images/superman.png', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Handstand pushups',
            image: 'images/hand.jpeg', onPressed: () {  },

          ),
          CustomRightAlignedContainer(
            title: 'Nose and Toes Against the Wall',
            image: 'images/naratw.jpeg', onPressed: () {  },

          ),
          SizedBox(height: 16.0), // Added spacing
          ElevatedButton(
            child: Text('Start'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GuestExplosivePushUpScreenAdvanced(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}