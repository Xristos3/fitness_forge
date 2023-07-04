import 'package:fitness_forge/ui/screen/badges_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  int weight = 0;
  int height = 0;
  int totalWorkouts = 0;
  int totalChallengesCompleted = 0;
  String nextfitnessgoal = '';

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController totalWorkoutsController = TextEditingController();
  TextEditingController totalChallengesController = TextEditingController();
  TextEditingController fitnessGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<String> getUserId() async {
    User? user = _auth.currentUser;
    return user!.uid;
  }

  void fetchUserProfile() async {
    userId = await getUserId();

    DocumentSnapshot snapshot =
    await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic>? userData =
      snapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          weight = userData['weight'] ?? 0;
          height = userData['height'] ?? 0;
          totalWorkouts = userData['totalWorkouts'] ?? 0;
          totalChallengesCompleted = userData['totalChallengesCompleted'] ?? 0;
          nextfitnessgoal = userData['nextFitnessGoal'] ?? '';

          weightController.text = weight.toString();
          heightController.text = height.toString();
          totalWorkoutsController.text = totalWorkouts.toString();
          totalChallengesController.text = totalChallengesCompleted.toString();
          fitnessGoalController.text = nextfitnessgoal;
        });
      }
    }
  }

  void updateProfile() async {
    userId = await getUserId();

    _firestore.collection('users').doc(userId).update({
      'weight': weight,
      'height': height,
      'totalWorkouts': totalWorkouts,
      'totalChallengesCompleted': totalChallengesCompleted,
      'nextFitnessGoal': nextfitnessgoal,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/profile.jpeg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                'Weight:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    weight = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Height:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    height = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Workouts:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: totalWorkoutsController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    totalWorkouts = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Challenges Completed:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: totalChallengesController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    totalChallengesCompleted = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Next Fitness Goal:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: fitnessGoalController,
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    nextfitnessgoal = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BadgesScreen()),
                  );
                },
                child: Text('view badge profile'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateProfile,
        child: Icon(Icons.save),
      ),
    );
  }
}


