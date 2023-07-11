import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/badges_profile_screen.dart';

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
  String nextFitnessGoal = '';

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController totalChallengesController = TextEditingController();
  TextEditingController fitnessGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    syncUserData();
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
          totalChallengesCompleted =
              userData['totalChallengesCompleted'] ?? 0;
          nextFitnessGoal = userData['nextFitnessGoal'] ?? '';

          weightController.text = weight.toString();
          heightController.text = height.toString();
          totalChallengesController.text =
              totalChallengesCompleted.toString();
          fitnessGoalController.text = nextFitnessGoal;
        });
      }
    }
  }

  void syncUserData() async {
    userId = await getUserId();

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          totalWorkouts = snapshot.data()?['count'] ?? 0;
          totalChallengesCompleted = snapshot.data()?['challengeCount'] ?? 0;
        });
      }
    });
  }

  void updateProfile() async {
    userId = await getUserId();

    if (height == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Height cannot be zero')),
      );
      return;
    }

    if (weight == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Weight cannot be zero')),
      );
      return;
    }

    _firestore.collection('users').doc(userId).update({
      'weight': weight,
      'height': height,
      'totalChallengesCompleted': totalChallengesCompleted,
      'nextFitnessGoal': nextFitnessGoal,
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
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    weight = int.parse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Weight is required';
                  }
                  if (value == '0') {
                    return 'Weight cannot be zero';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Weight',
                  errorText: weight == 0 ? 'Weight cannot be zero' : null,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Height:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    height = int.parse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Height is required';
                  }
                  if (value == '0') {
                    return 'Height cannot be zero';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Height',
                  errorText: height == 0 ? 'Height cannot be zero' : null,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Workouts:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(totalWorkouts.toString()),
              SizedBox(height: 16.0),
              Text(
                'Total Challenges Completed:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(totalChallengesCompleted.toString()),
              SizedBox(height: 16.0),
              Text(
                'Next Fitness Goal:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: fitnessGoalController,
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    nextFitnessGoal = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Write your fitness goal',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BadgesScreen()),
                  );
                },
                child: Text('View Badge Profile'),
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
