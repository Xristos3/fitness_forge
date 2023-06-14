import 'package:fitness_forge/ui/screen/badges_description_screen.dart';
import 'package:flutter/material.dart';

class BadgesScreen extends StatefulWidget {
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  String username = '';
  int numberOfPoints = 0;
  int totalBadges = 0;
  int totalActivitiesCompleted = 0;
  int achievementsCompleted = 0;

  List<String> recentBadges = [
    'images/badge1.PNG',
    'images/badge2.PNG',
    'images/badge3.PNG',
    'images/badge4.PNG',
    'images/badge4.PNG',
    'images/badge2.PNG',
    'images/badge3.PNG',
    'images/badge1.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Badges Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/rank.png'),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Number of Points:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              numberOfPoints = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Total Badges:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              totalBadges = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Total Activities Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              totalActivitiesCompleted = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Achievements Completed:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              achievementsCompleted = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Recent Badges Earned:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          height: 80.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recentBadges.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Image.asset(recentBadges[index]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Lists of each badge:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Engagement',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.asset('images/badge1.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge1.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge1.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge1.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge4.PNG'),
                        Text('Name'),
                        // Add more images and names here
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Activity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.asset('images/badge2.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge2.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge2.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge2.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge4.PNG'),
                        Text('Name'),
                        // Add more images and names here
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Achievements',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.asset('images/badge3.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge3.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge3.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge3.PNG'),
                        Text('Name'),
                        SizedBox(height: 8.0),
                        Image.asset('images/badge4.PNG'),
                        Text('Name'),
                        // Add more images and names here
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BadgesDescriptionScreen(),
                    ),
                  );
                },
                child: Text('View Badges requirements'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}