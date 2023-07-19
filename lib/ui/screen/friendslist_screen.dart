import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/friendbadges2_profile_screen.dart';
import 'package:fitness_forge/ui/screen/friendrequest_screen.dart';
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
  CollectionReference friendRequests =
  FirebaseFirestore.instance.collection('friendRequests');

  late String currentUserUid;
  late String currentUserUsername;
  late Stream<QuerySnapshot> friendsStream;

  @override
  void initState() {
    super.initState();
    currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    friendsStream =
        friends.doc(currentUserUid).collection('userFriends').snapshots();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    DocumentSnapshot userSnapshot = await users.doc(currentUserUid).get();

    if (userSnapshot.exists) {
      currentUserUsername = userSnapshot['username'];
    }
  }

  Future<void> removeFriend(String friendId) async {
    await friends
        .doc(currentUserUid)
        .collection('userFriends')
        .doc(friendId)
        .delete();

    // Perform any other necessary actions after removing the friend
    // ...
  }

  Future<void> sendFriendRequest(
      String recipientUsername, String message) async {
    String senderId = currentUserUid;
    String status = 'pending';

    // Check if recipient username already exists in the user's friends list
    QuerySnapshot friendsSnapshot = await friends
        .doc(currentUserUid)
        .collection('userFriends')
        .where('friendUsername', isEqualTo: recipientUsername)
        .get();

    if (friendsSnapshot.docs.isNotEmpty) {
      // Recipient username is already a friend, show error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('$recipientUsername is already your friend.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Stop further execution
    }

    // Check if recipient username is the same as the current user's username
    QuerySnapshot userSnapshot =
    await users.where('username', isEqualTo: recipientUsername).get();

    if (userSnapshot.docs.isEmpty) {
      // Recipient username not found
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Recipient username not found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Stop further execution
    }

    String recipientId = userSnapshot.docs.first.id;

    await friendRequests.add({
      'senderId': senderId,
      'recipientId': recipientId,
      'message': message,
      'status': status,
    });

    // Perform any other necessary actions after sending the friend request
    // ...
  }

  Future<void> showSendFriendRequestDialog(BuildContext context) async {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Send Friend Request'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Recipient Username',
                  ),
                ),
                TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String recipientUsername = _usernameController.text.trim();
                String message = _messageController.text.trim();

                // Check if the message field is empty
                if (message.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Please enter a message for the friend request.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Check if recipient username is the same as the current user's username
                  if (recipientUsername == currentUserUsername) {
                    // Recipient username is the same as the current user, show error dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('You cannot send a friend request to yourself.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Call the sendFriendRequest method from _FriendsListScreenState
                    sendFriendRequest(recipientUsername, message);
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Text('Send Friend Request'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Friends List'),
      // ),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FriendsBadgesScreen2(friendId: friendId),
                              ),
                            );
                          },
                          child: Text('View Profile'),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Remove Friend'),
                                  content: Text(
                                    'Are you sure you want to remove $friendUsername from your friends list?',
                                  ),
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
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendsBadgesScreen2(friendId: friendId),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              showSendFriendRequestDialog(context);
            },
            label: Text('Send Friend Request'),
            icon: Icon(Icons.person_add),
          ),
          SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendRequestScreen()),
              );
            },
            label: Text('View Friend Requests'),
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}