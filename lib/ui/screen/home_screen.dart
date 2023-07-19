import 'package:fitness_forge/ui/screen/calendar_screen2.dart';
import 'package:fitness_forge/ui/screen/claim_screen.dart';
import 'package:fitness_forge/ui/screen/extra_screen.dart';
import 'package:fitness_forge/ui/screen/friendrequest_screen.dart';
import 'package:fitness_forge/ui/screen/friendslist_screen.dart';
import 'package:fitness_forge/ui/screen/profile_screen.dart';
import 'package:fitness_forge/ui/screen/settings_screen.dart';
import 'package:fitness_forge/ui/screen/workouts.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WorkoutScreen(isGuest: false,), //    WorkoutScreen(isStandard: true, isGuest: false, difficulty: 'Standard',),
    ProfileScreen(),
    CalendarScreen2(),
    FriendsListScreen(),
    ExtraScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Forge'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClaimScreen()),
              );
              // Add your notification button logic here
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.blue, // Set the background color to blue
        selectedItemColor: Colors.black, // Set the selected item color to white
        unselectedItemColor: Colors.black54, // Set the unselected item color to a lighter shade of white
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Extra',
          ),
        ],
      ),
    );
  }
}
