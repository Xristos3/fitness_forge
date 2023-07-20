import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChallengeLeaderboardScreen extends StatefulWidget {
  @override
  _ChallengeLeaderboardScreenState createState() => _ChallengeLeaderboardScreenState();
}

class _ChallengeLeaderboardScreenState extends State<ChallengeLeaderboardScreen> {
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
        title: Text('Challenge Leaderboard'),
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
              // Sort usersData based on the "challengeCount" value in descending order
              usersData.sort((a, b) => b['challengeCount'].compareTo(a['challengeCount']));

              return ListView.builder(
                itemCount: usersData.length,
                itemBuilder: (context, index) {
                  final userData = usersData[index];
                  final String uid = userData.id;
                  final String username = userData['username'];
                  final int challengeCount = userData['challengeCount'];

                  return ListTile(
                    leading: Text((index + 1).toString()), // Display the rank
                    title: Text('$username ($challengeCount challenges)'),
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
