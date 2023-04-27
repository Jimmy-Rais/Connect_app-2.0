import 'dart:ui';
import 'package:Connect/chats.dart';
import 'package:Connect/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'image.dart';

final CollectionReference messagesCollection =
    FirebaseFirestore.instance.collection('Messages');

class MyStories extends StatelessWidget {
  const MyStories({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
          backgroundColor: Color.fromARGB(219, 7, 44, 66),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )),
      body: Column(
        children: [
          MyStatut(),
          Expanded(child: Stories()),
        ],
      ),
    );
  }
}

class MyStatut extends StatelessWidget {
  const MyStatut({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ImagePickerWidget1(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = 0.0;
                    var end = 1.0;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return ScaleTransition(
                      scale: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              )
            },
        splashColor: Color.fromARGB(255, 99, 178, 223),
        child: Container(
          height: 80,
          color: Color.fromARGB(219, 7, 44, 66),
          child: Row(children: [
            SizedBox(width: 21),
            Stack(children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/avatar/Arnold.jpg'),
                ),
              ),
              Positioned(
                  bottom: -17,
                  right: -14,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 18,
                        color: Colors.white,
                      )))
            ]),
            SizedBox(width: 1),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 17, left: 1),
                  child: Text(
                    "My Status",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Tap to add status update",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )),
              ],
            ),
          ]),
        ));
  }
}

class Stories extends StatelessWidget {
  final List MyStories = [
    {
      'id_name': 'Jimmy',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': 'Today,15:47',
    },
    {
      'id_name': 'Shaloe',
      'statut': 'images/avatar/Amanda.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Dan',
      'statut': 'images/avatar/Dan.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Louise',
      'statut': 'images/avatar/Louise.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Arnold',
      'statut': 'images/avatar/Arnold.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Jonathan',
      'statut': 'images/avatar/Joe.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Lucas',
      'statut': 'images/avatar/Lucas.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Jordan',
      'statut': 'images/avatar/Jordan.jpg',
      'caption': 'Hello',
      'date': 'Today,8:34',
    },
    {
      'id_name': 'Claire',
      'statut': 'images/avatar/Claire.jpg',
      'caption': 'Hello',
      'date': 'Yesterday,8:34',
    },
  ];
  Stories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromARGB(219, 7, 44, 66),
        body: SingleChildScrollView(
      child: Column(
        children: MyStories.map((Mess) {
          // Click detection
          return InkWell(
            onTap: () => {},
            splashColor: Color.fromARGB(255, 99, 178, 223),
            child: Container(
                padding: EdgeInsets.only(left: 25, right: 10, top: 25),
                child: Row(children: [
                  Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(3),

                    /*decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Mess['statut']),
                      ),
                    ),*/
                    decoration: BoxDecoration(
                      color: Color.fromARGB(219, 7, 44, 66),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Mess['statut']),
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Column(
                    children: [
                      Row(
                        // Max Space between row elements
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            // Start from the right
                            //  crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SizedBox(height: 15),
                              Text(
                                Mess['id_name'],
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              // Line return
                              Wrap(
                                children: [
                                  Text(
                                    Mess['date'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                              /*children: [
                              Text(
                                Mess['date'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 8),
                              Mess['unread'] != 0
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 99, 178, 223),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        Mess['unread'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],*/
                              ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Separating line
                      Container(
                        height: 1.2,
                        color: Colors.grey,
                      )
                    ],
                  )
                ])),
          );
        }).toList(),
      ),
    ));
  }
}
