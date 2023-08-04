/*import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'login.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Page.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'chats.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      /*   options: FirebaseOptions(
    appId: 'current_key',
    apiKey: 'AIzaSyBg6XXBYl04UCtM-ORt8oJsneSBO9-L7pc',
    projectId: 'connectapp-85f42',
    databaseURL: 'https://connectapp-85f42-default-rtdb.firebaseio.com/',
    messagingSenderId: 'taivxLlQ47TFHhjtRwWd7LeMp2g1',
  )*/
      );
  /*appId: 'current_key',
      apiKey: 'AIzaSyBg6XXBYl04UCtM-ORt8oJsneSBO9-L7pc',
      projectId: 'connectapp-85f42',
      databaseURL: 'https://connectapp-85f42-default-rtdb.firebaseio.com/',
    ),*/

  runApp(MyApp());
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final databaseRef = FirebaseDatabase.instance.reference();
  final TextEditingController _textEditingController = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    databaseRef.onChildAdded.listen(_onMessageAdded);
  }

  void _onMessageAdded(Event event) {
    setState(() {
      _messages.add(Message.fromSnapshot(event.snapshot));
    });
  }

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      databaseRef.push().set(Message(
            sender: "me",
            text: _textEditingController.text,
            timestamp: DateTime.now().millisecondsSinceEpoch,
          ).toJson());
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.text),
                  subtitle: Text(message.sender),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*Message class to represent the chat messages*/
class Message {
  final String sender;
  final String text;

  final int timestamp;

  Message({
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "text": text,
        "timestamp": timestamp,
      };

  factory Message.fromSnapshot(DataSnapshot snapshot) {
    return Message(
      sender: snapshot.value["sender"],
      text: snapshot.value["text"],
      timestamp: snapshot.value["timestamp"],
    );
  }
}
*/