import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:Connect/chats.dart';
import 'package:Connect/main.dart';
import 'package:Connect/userid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//final currentUser = FirebaseAuth.instance.currentUser;
//final currentuserid = currentUser?.uid ?? '';
//String currentuserid = '';

/*void main() {
  runApp(MyApp6());


class MyApp6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListScreen(),
    );
  }
}*/

/*class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat List')),
      body: ChatList(),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .where('participants', arrayContains: currentuserid)
          .orderBy('timestamp', descending: true)
          
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final chatDocuments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocuments.length,
            itemBuilder: (context, index) {
              final chatDoc = chatDocuments[index];
              final participants = chatDoc['participants'] as List<dynamic>;
              final otherParticipant = participants
                  .firstWhere((participant) => participant != currentuserid);

              return ListTile(
                title: Text('Chat with $otherParticipant'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(chatDocumentId: chatDoc.id),
                    ),
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String chatDocumentId;

  ChatScreen({required this.chatDocumentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(chatDocumentId)
            .collection('chats')
            .orderBy('timestamp')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chatMessages = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                final messageText = message['messagetxt'];
                final senderId = message['senderid'];
                final participants = message['participants'] as List<dynamic>;

                final isCurrentUserSender = participants.contains(currentUser);

                return Align(
                  alignment: isCurrentUserSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isCurrentUserSender ? Colors.blue : Colors.grey,
                    ),
                    child: Text(
                      messageText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}*/
class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String currentuserid = '';

  @override
  void initState() {
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser(); // Update currentuserid when the authentication state changes
    });
  }

  void updateUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentuserid = user.uid;
    } else {
      currentuserid =
          ''; // Set it to an empty string when no user is signed in.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat List')),
      body: ChatList(),
    );
  }
}

class ChatList extends StatefulWidget {
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  String currentuserid = '';

  @override
  void initState() {
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser(); // Update currentuserid when the authentication state changes
    });
  }

  void updateUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentuserid = user.uid;
    } else {
      currentuserid =
          ''; // Set it to an empty string when no user is signed in.
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .where('Participants', arrayContains: currentuserid)
          //.orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final chatDocuments = snapshot.data!.docs;
          print("Snapshot has data");
          print(currentuserid);
          return ListView.builder(
            itemCount: chatDocuments.length,
            itemBuilder: (context, index) {
              final chatDoc = chatDocuments[index];

              return ListTile(
                title: Text(
                  'Chat with ${chatDoc.id}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ), // Use the chat document ID
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreen(chatDocumentId: chatDoc.id),
                    ),
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
          print("No data");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String chatDocumentId;

  ChatScreen({required this.chatDocumentId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String currentuserid = '';

  @override
  void initState() {
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser(); // Update currentuserid when the authentication state changes
    });
  }

  void updateUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentuserid = user.uid;
    } else {
      currentuserid =
          ''; // Set it to an empty string when no user is signed in.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(widget.chatDocumentId)
            .collection('chats')
            .orderBy('timestamp')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chatMessages = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                final messageText = message['messagetxt'];
                final senderId = message['senderid'];
                final receiverId = message['receiverid'];
                final participants = [senderId];
                final isCurrentUserSender = //senderId ? true : false;
                    participants.contains(currentuserid);

                return Align(
                  alignment: isCurrentUserSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isCurrentUserSender ? Colors.blue : Colors.grey,
                    ),
                    child: Text(
                      messageText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
