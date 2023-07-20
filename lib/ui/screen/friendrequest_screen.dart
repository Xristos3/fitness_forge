import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late String currentUserId;
  late String currentUserUsername;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
    currentUserId = currentUser.uid;
    fetchCurrentUser();
    createFriendRequestOnSignUp();
  }

  Future<void> fetchCurrentUser() async {
    DocumentSnapshot userSnapshot = await users.doc(currentUserId).get();

    if (userSnapshot.exists) {
      currentUserUsername = userSnapshot['username'];
    }
  }

  Future<void> createFriendRequestOnSignUp() async {
    String senderId = currentUserId;
    String recipientId = ''; // Empty initially, to be filled later
    String status = 'pending';

    await friendRequests.add({
      'senderId': senderId,
      'recipientId': recipientId,
      'status': status,
    });
  }

  Future<void> sendFriendRequest(
      String recipientUsername) async {
    String senderId = currentUserId;
    String status = 'pending';

    // Check if recipient username already exists in the user's friends list
    QuerySnapshot friendsSnapshot = await friends
        .doc(currentUserId)
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
      'status': status,
    });

    // Perform any other necessary actions after sending the friend request
    // ...
  }

  Future<void> acceptRequest(
      String requestId, String senderId, String senderUsername) async {
    // Update the status of the friend request to accepted
    await friendRequests.doc(requestId).update({'status': 'accepted'});

    // Add the sender to the current user's friends collection
    await friends
        .doc(currentUserId)
        .collection('userFriends')
        .doc(senderId)
        .set({
      'friendId': senderId,
      'friendUsername': senderUsername,
    });

    // Add the current user to the sender's friends collection
    await friends
        .doc(senderId)
        .collection('userFriends')
        .doc(currentUserId)
        .set({
      'friendId': currentUserId,
      'friendUsername': currentUserUsername,
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
                  .where('recipientId', isEqualTo: currentUserId)
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

                    return FutureBuilder<DocumentSnapshot>(
                      future: users.doc(senderId).get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox.shrink();
                        }

                        String senderUsername = snapshot.data!['username'];

                        return ListTile(
                          title: Text('From: $senderUsername'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {
                                  acceptRequest(requestId, senderId, senderUsername);
                                },
                                child: Text('Accept'),
                              ),
                              TextButton(
                                onPressed: () {
                                  rejectRequest(requestId);
                                },
                                child: Text('Reject'),
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
    );
  }
}
