import 'dart:ui';

import 'package:Connect/chats.dart';
import 'package:Connect/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final CollectionReference messagesCollection =
    FirebaseFirestore.instance.collection('Messages');

class MyStories extends StatelessWidget {
  const MyStories({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stories(),
    );
  }
}

class Stories extends StatelessWidget {
  final List MyStories = [
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
    {
      'id_name': 'Jim',
      'statut': 'images/avatar/Jim.jpg',
      'caption': 'Hello',
      'date': '8:34',
    },
  ];
  Stories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(105, 77, 140, 176),
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
                        margin: EdgeInsets.only(right: 25),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Mess['statut']),
                          ),
                        ),
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
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  // Line return
                                  Wrap(
                                    children: [
                                      Text(
                                        Mess['date'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
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
