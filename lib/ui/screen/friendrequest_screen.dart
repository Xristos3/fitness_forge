import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendRequestScreen extends StatefulWidget {
  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  CollectionReference friendRequests =
  FirebaseFirestore.instance.collection('friendRequests');

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

  Future<void> sendFriendRequest(String recipientUsername, String message) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: friendRequests
            .where('recipientId', isEqualTo: currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Text('No friend requests found.');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot request = snapshot.data!.docs[index];
              String senderId = request['senderId'];
              String recipientId = request['recipientId'];
              String message = request['message'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(senderId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                      subtitle: Text(message),
                    );
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return ListTile(
                      title: Text('Unknown User'),
                      subtitle: Text(message),
                    );
                  }

                  String senderUsername = snapshot.data!['username'];

                  return ListTile(
                    title: Text(senderUsername),
                    subtitle: Text(message),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check),
                          color: Colors.green,
                          onPressed: () {
                            acceptRequest(request.id, recipientId);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.red,
                          onPressed: () {
                            rejectRequest(request.id);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showSendFriendRequestDialog(context);
        },
        label: Text('Send Friend Request'),
        icon: Icon(Icons.person_add),
      ),
    );
  }

  Future<void> acceptRequest(String requestId, String recipientId) async {
    // Update the status of the friend request to accepted
    await friendRequests.doc(requestId).update({'status': 'accepted'});

    // Perform any other necessary actions after accepting the friend request
    // ...
  }

  Future<void> rejectRequest(String requestId) async {
    // Delete the document from the 'friendRequests' collection
    friendRequests.doc(requestId).delete();
  }

  Future<void> showSendFriendRequestDialog(BuildContext context) async {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Send Friend Request'),
          content: Column(
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
