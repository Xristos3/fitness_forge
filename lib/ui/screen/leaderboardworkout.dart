import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/leaderboardchallenges.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late String currentUserUid;

  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.leaderboard),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengeLeaderboardScreen()),
                  );
                },
              ),
              Text('2nd board'), // Text added next to the IconButton
            ],
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('friends')
            .doc(currentUserUid)
            .collection('userFriends')
            .snapshots(),
        builder: (context, friendsSnapshot) {
          if (!friendsSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final friendDocs = friendsSnapshot.data!.docs;
          final friendUids = friendDocs.map((doc) => doc.id).toList();

          return StreamBuilder<QuerySnapshot>(
            stream: users
                .where(FieldPath.documentId, whereIn: [currentUserUid, ...friendUids])
                .snapshots(),
            builder: (context, leaderboardSnapshot) {
              if (!leaderboardSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final usersData = leaderboardSnapshot.data!.docs;
              // Sort usersData based on the "count" value in descending order
              usersData.sort((a, b) => b['count'].compareTo(a['count']));

              return ListView.builder(
                itemCount: usersData.length,
                itemBuilder: (context, index) {
                  final userData = usersData[index];
                  final String uid = userData.id;
                  final String username = userData['username'];
                  final int count = userData['count'];

                  return ListTile(
                    leading: Text((index + 1).toString()), // Display the rank
                    title: Text('$username ($count workouts)'),
                    tileColor: uid == currentUserUid ? Colors.blue[100] : null, // Highlight the current user
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}