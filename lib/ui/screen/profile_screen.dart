import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/badges_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userId;

  int weight = 0;
  int height = 0;
  int challengeCount = 0; // Define the challengeCount variable
  int totalWorkouts = 0; // Define the totalWorkouts variable
  String nextFitnessGoal = '';

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
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

    DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          weight = userData['weight'] ?? 0;
          height = userData['height'] ?? 0;
          challengeCount = userData['challengeCount'] ?? 0;
          totalWorkouts = userData['count'] ?? 0;
          nextFitnessGoal = userData['nextFitnessGoal'] ?? '';

          weightController.text = weight.toString();
          heightController.text = height.toString();
          fitnessGoalController.text = nextFitnessGoal;
        });
      }
    }
  }

  void updateProfile() async {
    userId = await getUserId();

    // Check if any of the text fields are empty or zero
    if (weight == 0 || height == 0 || nextFitnessGoal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields must be filled')),
      );
      return;
    }

    _firestore.collection('users').doc(userId).update({
      'weight': weight,
      'height': height,
      'challengeCount': challengeCount,
      'count': totalWorkouts,
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
              CircleAvatar(
                radius: 50, // Adjust the radius as per your preference
                backgroundImage: AssetImage('images/profile.jpeg'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Weight in kg:',
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
                'Height in cm:',
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
              Text(totalWorkouts.toString()), // Display totalWorkouts
              SizedBox(height: 16.0),
              Text(
                'Challenges Completed:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(challengeCount.toString()), // Display challengeCount
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
                  // Check if any of the required fields are empty or zero
                  if (weightController.text.isEmpty ||
                      heightController.text.isEmpty ||
                      fitnessGoalController.text.isEmpty ||
                      weight == 0 ||
                      height == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All fields must be filled')),
                    );
                  } else {
                    updateProfile();
                  }
                },
                child: Text('View Badge Profile'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Check if any of the required fields are empty or zero
          if (weightController.text.isEmpty ||
              heightController.text.isEmpty ||
              nextFitnessGoal.isEmpty ||
              weight == 0 ||
              height == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('All fields must be filled')),
            );
          } else {
            updateProfile();
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
