import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_forge/ui/screen/friendslist_screen.dart';
import 'package:flutter/material.dart';

class FriendRequestScreen extends StatefulWidget {
  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  CollectionReference friendRequests =
  FirebaseFirestore.instance.collection('friendRequests');
  CollectionReference friends =
  FirebaseFirestore.instance.collection('friends');
  CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
    createFriendRequestOnSignUp();
  }

  Future<void> createFriendRequestOnSignUp() async {
    String senderId = currentUser.uid;
    String recipientId = ''; // Empty initially, to be filled later
    String message = '';
    String status = 'pending';

    await friendRequests.add({
      'senderId': senderId,
      'recipientId': recipientId,
      'message': message,
      'status': status,
    });
  }

  Future<void> sendFriendRequest(
      String recipientUsername, String message) async {
    String senderId = currentUser.uid;
    String status = 'pending';

    // Get the recipient user document based on the entered username
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: recipientUsername)
        .get();

    // Check if the recipient username exists
    if (querySnapshot.docs.isNotEmpty) {
      String recipientId = querySnapshot.docs.first.id;

      await friendRequests.add({
        'senderId': senderId,
        'recipientId': recipientId,
        'message': message,
        'status': status,
      });

      // Perform any other necessary actions after sending the friend request
      // ...
    } else {
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
    }
  }

  Future<void> acceptRequest(
      String requestId, String senderId, String senderUsername) async {
    // Update the status of the friend request to accepted
    await friendRequests.doc(requestId).update({'status': 'accepted'});

    // Add the sender to the friends collection
    await friends
        .doc(currentUser.uid)
        .collection('userFriends')
        .doc(senderId)
        .set({
      'friendId': senderId,
      'friendUsername': senderUsername,
    });

    // Perform any other necessary actions after accepting the friend request
    // ...

    // Remove the friend request from the friendRequests collection
    friendRequests.doc(requestId).delete();
  }

  Future<void> rejectRequest(String requestId) async {
    // Update the status of the friend request to rejected
    await friendRequests.doc(requestId).update({'status': 'rejected'});

    // Perform any other necessary actions after rejecting the friend request
    // ...

    // Remove the friend request from the friendRequests collection
    friendRequests.doc(requestId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Requests'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: friendRequests
                  .where('recipientId', isEqualTo: currentUser.uid)
                  .where('status', isEqualTo: 'pending')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No friend requests.'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot request = snapshot.data!.docs[index];
                    String requestId = request.id;
                    String senderId = request['senderId'];
                    String message = request['message'];

                    return FutureBuilder<DocumentSnapshot>(
                      future: users.doc(senderId).get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox.shrink();
                        }

                        String senderUsername = snapshot.data!['username'];

                        return ListTile(
                          title: Text('From: $senderUsername'),
                          subtitle: Text('Message: $message'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check),
                                color: Colors.green,
                                onPressed: () {
                                  acceptRequest(
                                      requestId, senderId, senderUsername);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                color: Colors.red,
                                onPressed: () {
                                  rejectRequest(requestId);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
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
                MaterialPageRoute(builder: (context) => FriendsListScreen()),
              );
            },
            label: Text('Friends List'),
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
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
              onPressed: () {
                String recipientUsername = _usernameController.text.trim();
                String message = _messageController.text.trim();
                sendFriendRequest(recipientUsername, message);
                Navigator.of(context).pop();
              },
              child: Text('Send Friend Request'),
            ),
          ],
        );
      },
    );
  }
}
