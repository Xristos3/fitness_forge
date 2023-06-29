import 'package:fitness_forge/ui/screen/home_screen.dart';
import 'package:fitness_forge/ui/screen/login_screen.dart';
import 'package:fitness_forge/ui/screen/login_screen2.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color _selectedColor = Colors.blue;
  String _selectedProfile = 'Profile 1';

  List<Color> _themeColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  List<String> _profileOptions = [
    'Profile 1',
    'Profile 2',
    'Profile 3',
    'Profile 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Color:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _buildColorOptions(),
            ),
            SizedBox(height: 16),
            Text(
              'Profile:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedProfile,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProfile = newValue!;
                });
              },
              items: _buildProfileOptions(),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            // Apply button logic
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
            );
          },
          child: Text('Apply'),
        ),
      ],
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Logout button logic
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen2()),
              );
            },
            child: Text('Logout'),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildColorOptions() {
    return _themeColors.map((color) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedColor = color;
          });
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: color == _selectedColor ? Colors.white : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _buildProfileOptions() {
    return _profileOptions.map((profile) {
      return DropdownMenuItem<String>(
        value: profile,
        child: Text(profile),
      );
    }).toList();
  }
}