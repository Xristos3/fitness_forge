import 'package:fitness_forge/ui/screen/guest_calendarscreen.dart';
import 'package:fitness_forge/ui/screen/guest_challengesscreen.dart';
import 'package:fitness_forge/ui/screen/guest_settingsscreen.dart';
import 'package:fitness_forge/ui/screen/workouts.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatefulWidget {
  @override
  _GuestHomeScreenState createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WorkoutScreen(isGuest: true, isStandard: true, difficulty: 'Standard',), // Set isGuest to true
    GuestCalendarScreen2(),
    GuestChallengesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Forge'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestSettingsScreen()),
              );
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics, color: Colors.black,),
            label: 'workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.black,),
            label: 'calendar',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events, color: Colors.black,),
              label: 'extra'
          ),
        ],
      ),
    );
  }
}
