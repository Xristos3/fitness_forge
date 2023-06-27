import 'package:flutter/material.dart';

void main() {
  runApp(MessengerApp());
}

class MessengerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MessengerScreen(),
    );
  }
}

class MessengerScreen extends StatelessWidget {
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
        title: Text('Messenger'),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen1(friendName: friendName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen1 extends StatelessWidget {
  final String friendName;

  const ChatScreen1({Key? key, required this.friendName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friendName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                ChatMessage(text: 'Hello!', isSentByMe: true),
                ChatMessage(text: 'Hi there!', isSentByMe: false),
                ChatMessage(text: 'How are you?', isSentByMe: true),
                ChatMessage(
                  text: 'I\'m good. How about you?',
                  isSentByMe: false,
                ),
                // Add more ChatMessage widgets here
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle send message logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSentByMe;

  const ChatMessage({Key? key, required this.text, required this.isSentByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: isSentByMe ? 80.0 : 8.0,
        right: isSentByMe ? 8.0 : 80.0,
      ),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSentByMe ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSentByMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
