import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/friendsbadges_profile_screen.dart';
import 'package:flutter/material.dart';

class FriendsListScreen extends StatefulWidget {
  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  CollectionReference friends =
  FirebaseFirestore.instance.collection('friends');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late String currentUserUid;
  late Stream<QuerySnapshot> friendsStream;

  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    friendsStream = friends.doc(currentUserUid).collection('userFriends').snapshots();
  }

  Future<void> removeFriend(String friendId) async {
    await friends.doc(currentUserUid).collection('userFriends').doc(friendId).delete();

    // Perform any other necessary actions after removing the friend
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: friendsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No friends.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot friend = snapshot.data!.docs[index];
              String friendId = friend['friendId'];

              return FutureBuilder<DocumentSnapshot>(
                future: users.doc(friendId).get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox.shrink();
                  }

                  String friendUsername = snapshot.data!['username'];

                  return ListTile(
                    title: Text(friendUsername),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Remove Friend'),
                              content: Text(
                                  'Are you sure you want to remove $friendUsername from your friends list?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    removeFriend(friendId);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Remove'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendsBadgesScreen(friendId: friendId),
                        ),
                      );
                    },
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
