import 'package:fitness_forge/ui/screen/calendar_screen.dart';
import 'package:fitness_forge/ui/screen/chat_screen.dart';
import 'package:fitness_forge/ui/screen/claim_screen.dart';
import 'package:fitness_forge/ui/screen/extra_screen.dart';
import 'package:fitness_forge/ui/screen/profile_screen.dart';
import 'package:fitness_forge/ui/screen/settings_screen.dart';
import 'package:fitness_forge/ui/screen/workout_screen_easy.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WorkoutScreenEasy(),
    ProfileScreen(),
    CalendarScreen(),
    ChatScreen(),
    ExtraScreen(),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics, color: Colors.black,),
            label: 'workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black,),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.black,),
            label: 'calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.black,),
            label:'chat',
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
