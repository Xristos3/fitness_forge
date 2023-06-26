import 'package:flutter/material.dart';


class FriendsListScreen extends StatelessWidget {
  final List<String> friends = [
    'John Doe',
    'Jane Smith',
    'Alex Johnson',
    'Emily Wilson',
    'Michael Brown',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friendName = friends[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(friendName[0]),
            ),
            title: Text(friendName),
            onTap: () {
              // Handle friend selection logic here
            },
          );
        },
      ),
    );
  }
}
