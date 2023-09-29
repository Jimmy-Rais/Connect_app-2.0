import 'dart:ui';
import 'package:Connect/chats.dart';
import 'package:Connect/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'image.dart';
import 'image_picker.dart';
import 'package:intl/intl.dart';
import 'storydetail.dart';

class StoryDetailsPage extends StatefulWidget {
  final DocumentSnapshot storySnapshot;

  const StoryDetailsPage({Key? key, required this.storySnapshot})
      : super(key: key);

  @override
  _StoryDetailsPageState createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        widget.storySnapshot.data()! as Map<String, dynamic>;
    final String photoUrl = data['photo_url'];
    final String caption = data['caption'];
    final String userId = data['userid'];
    FirebaseFirestore.instance.collection('Users').doc(userId).get();
    return Scaffold(
      backgroundColor: Color.fromARGB(219, 7, 44, 66),
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            /* child: GestureDetector(
              onTap: () {
                // Close the full screen when the image is tapped
                Navigator.of(context).pop();
              },*/
            child: Image.network(
              photoUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 130,
            top: 670,
            child: Container(
              child: Text(
                caption,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 170,
            top: 720,
            child: Text(
              "Reply",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            /*child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your reaction here...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              // TODO: Implement the logic to post the reaction
            ),*/
          ),
        ],
      ),
    );
  }
}
