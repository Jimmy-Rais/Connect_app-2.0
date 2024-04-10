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
import 'mychat.dart';
import 'user.dart';
import 'AllUsers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
        // appBar: AppBar(title: Text('Chat List')),
        //bottomNavigationBar: BottomAppBar(),
        body: Column(
      children: [
        SizedBox(height: 20),
        ChatList(),
      ],
    )
        //ChatList(),
        );
  }
}

class ChatList extends StatefulWidget {
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  String currentuserid = '';
  static String otherUserId = "";
  double _opacity = 0.0;
  @override
  void initState() {
    super.initState();
    _animateOpacity();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser();
      //  updateotherUserId(); // Update currentuserid when the authentication state changes
    });
  }

  void _animateOpacity() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  /* void updateotherUserId() {
    String user = otherUserId.toString();
    if (user != null) {
      otherUserId = user;
    } else {
      otherUserId = ''; // Set it to an empty string when no user is signed in.
    }
  }*/

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

          /*    final List<dynamic> participants = (chatDocuments['Participants'] as List<dynamic>) ?? [];
          final otherParticipant = participants.firstWhere(
            (participantId) = > participantId != currentuserid,
            orElse: () => null,
          );
          final List<dynamic> participants = (chatDocuments['Participants'] as List<dynamic>) ?? [];
final otherParticipant = participants.firstWhere(
  (participantId) => participantId.toString() != currentuserid,
  orElse: () => null,
);*/

          // Now, otherParticipant will contain the ID of the other participant

          print(currentuserid);

          //Retrieve the other partcicipant id

          return Column(
            children: [
              InkWell(
                onTap: () {
                  
                },
              child: Container(),
              ),
              ListView.builder(
                itemCount: chatDocuments.length,
                itemBuilder: (context, index) {
                  final chatDoc = chatDocuments[index];

                  // Access the 'chats' subcollection of the chat document
                  final chatSubcollection = chatDoc.reference.collection('chats');

                  // Retrieve the sender ID and receiver ID from the subcollection
                  return StreamBuilder<QuerySnapshot>(
                    stream: chatSubcollection.snapshots(),
                    builder: (context, subSnapshot) {
                      if (subSnapshot.hasData && subSnapshot.data != null) {
                        final docs = subSnapshot.data!.docs;

                        if (docs.isNotEmpty) {
                          // Assuming there's at least one document in the 'chats' subcollection
                          final chatData = docs.first;

                          // Access sender ID and receiver ID from the subcollection data
                          final senderId = chatData['senderid'];
                          final receiverId = chatData['receiverid'];
                          if (senderId != currentuserid) {
                            otherUserId = senderId;
                          } else if (receiverId != currentuserid) {
                            otherUserId = receiverId;
                          } else {
                            otherUserId = "";
                          }
                          print("id initialized before= $otherUserId");

                          return ListTile(
                            title: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(otherUserId)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  //return CircularProgressIndicator();
                                }
                                if (!snapshot.hasData || !snapshot.data!.exists) {
                                  return Container();
                                }
                                print("id initialized= $otherUserId");
                                final userData =
                                    snapshot.data!.data() as Map<String, dynamic>;
                                final otherUserName =
                                    userData['user_name'] as String? ?? 'User';

                                final otherUserProfilePhoto =
                                    userData['photo_url'] as String?;
                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                final FirebaseFirestore _firestore =
                                    FirebaseFirestore.instance;
                                /*return InkWell(
                                  onTap: () async {
                                    // Retrieve the selected user's ID without fetching all users from Firestore
                                    final QuerySnapshot<Map<String, dynamic>>
                                        snapshot = await _firestore
                                            .collection('Users')
                                            .where(FieldPath.documentId,
                                                isNotEqualTo:
                                                    _auth.currentUser?.uid)
                                            .limit(1)
                                            .get();

                                    if (snapshot.docs.isNotEmpty) {
                                      final user = snapshot.docs.first;
                                      final userId = user.id;

                                      // Navigate to the chat screen with the retrieved user's ID
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              ChatScreen(
                                                  chatDocumentId: chatDoc.id,
                                                  otheruserid: userId),
                                          /*transitionsBuilder: (context, animation,
                                              secondaryAnimation, child) {
                                            var begin = 0.0;
                                            var end = 1.0;
                                            var curve = Curves.ease;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(CurveTween(curve: curve));
                                            return ScaleTransition(
                                              scale: animation.drive(tween),
                                              child: child,
                                            );*/
                                        ),
                                      );
                                    }
                                  },*/
                                return InkWell(
                                  onTap: () async {
                                    await Future.delayed(
                                        Duration(milliseconds: 300));

                                    // Retrieve the selected user's ID from Firestore
                                    final QuerySnapshot snapshot =
                                        await _firestore.collection('Users').get();
                                    final users = snapshot.docs
                                        .where((doc) =>
                                            doc.id != _auth.currentUser?.uid)
                                        .toList();

                                    if (users.isNotEmpty) {
                                      final user = users.elementAt(index);
                                      final userId = user.id;

                                      // Navigate to the chat screen with the retrieved user's ID
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              ChatScreen(
                                                  chatDocumentId: chatDoc.id,
                                                  otheruserid: userId),
                                          /* transitionsBuilder: (context, animation,
                                              secondaryAnimation, child) {
                                            var begin = 0.0;
                                            var end = 1.0;
                                            var curve = Curves.ease;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(CurveTween(curve: curve));
                                            return ScaleTransition(
                                              scale: animation.drive(tween),
                                              child: child,
                                            );
                                          },*/
                                        ),
                                      );
                                    }
                                  },
                                  /*return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            ChatScreen(
                                                chatDocumentId: chatDoc.id,
                                                otheruserid: otherUserId),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
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
                                    );
                                  },*/
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 45,
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(

                                            //shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.circular(30),
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(60),
                                              topRight: Radius.circular(60),
                                              bottomLeft: Radius.circular(60),
                                              bottomRight: Radius.circular(60),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade700,
                                                // Color of the shadow
                                                spreadRadius:
                                                    1, // Spread radius of the shadow
                                                blurRadius:
                                                    1, // Blur radius of the shadow
                                                offset: Offset(1,
                                                    1), // Offset of the shadow (horizontal, vertical)
                                              ),
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                    141, 176, 190, 197),
                                                // Color of the shadow
                                                spreadRadius:
                                                    1, // Spread radius of the shadow
                                                blurRadius:
                                                    1, // Blur radius of the shadow
                                                offset: Offset(-1,
                                                    -1), // Offset of the shadow (horizontal, vertical)
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  const Color.fromARGB(
                                                      107, 238, 238, 238),
                                                  const Color.fromARGB(
                                                      98, 189, 189, 189),
                                                ])),
                                        child: AnimatedOpacity(
                                          opacity: _opacity,
                                          duration: Duration(milliseconds: 2000),
                                          curve: Curves.easeIn,
                                          child: CircleAvatar(
                                              child: ClipOval(
                                            child: SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        otherUserProfilePhoto!))),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Column(children: [
                                        Row(
                                          // Max Space between row elements
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: 20),
                                                AnimatedOpacity(
                                                  opacity: _opacity,
                                                  duration:
                                                      Duration(milliseconds: 5000),
                                                  curve: Curves.easeIn,
                                                  child: DefaultTextStyle(
                                                    style: GoogleFonts.acme(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                    child: Text(
                                                      otherUserName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // Line return
                                                Wrap(
                                                  children: [
                                                    Text(
                                                      'hey....',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "12:02",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                1 != 0
                                                    ? Container(
                                                        padding: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 99, 178, 223),
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Text(
                                                          1.toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 30,
                                          thickness: 1,
                                          //indent: 20,
                                          // endIndent: 0,
                                          color: Colors.grey,
                                        ),
                                      ])),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }

                      // Handle loading state, no documents, or error
                      return Container(); // or another loading indicator or error message
                    },
                  );
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Container();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String chatDocumentId;
  final String otheruserid;
  ChatScreen({required this.chatDocumentId, required this.otheruserid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double _opacity = 0.0;
  late String reciever;
  String currentuserid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    _animateOpacity();
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser();
      // Update currentuserid when the authentication state changes
    });
  }

  void _animateOpacity() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),

          leadingWidth: 250,
          leading: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.otheruserid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final userName = userData['user_name'];
              final userPhotoUrl = userData['photo_url'];

              return Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 2),
                  Container(
                    height: 33,
                    width: 33,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 1, // Blur radius of the shadow
                            offset: Offset(1,
                                1), // Offset of the shadow (horizontal, vertical)
                          ),
                          BoxShadow(
                            color: const Color.fromARGB(141, 176, 190, 197),
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 1, // Blur radius of the shadow
                            offset: Offset(-1,
                                -1), // Offset of the shadow (horizontal, vertical)
                          ),
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(107, 238, 238, 238),
                              const Color.fromARGB(98, 189, 189, 189),
                            ])),
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: CircleAvatar(
                          child: ClipOval(
                        child: SizedBox(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(userPhotoUrl),
                            )),
                      )),
                    ),
                  ),
                  SizedBox(width: 14),
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOutSine,
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 23,
              ),
              onPressed: () {},
            ),
          ],
          // Other AppBar properties...
        ),
        bottomNavigationBar: Bottomsection(userid: widget.otheruserid),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/avatar/wal.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(widget.chatDocumentId)
                .collection('chats')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final chatMessages = snapshot.data!.docs;
                /*Text(
                        messageText,
                        style: TextStyle(color: Colors.white),
                      ),*/
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
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isCurrentUserSender
                                  ? Color.fromARGB(145, 26, 53, 69)
                                  : Color.fromARGB(255, 0, 0, 0),
                              boxShadow: isCurrentUserSender
                                  ? [
                                      BoxShadow(
                                        color: Colors.grey.shade700,
                                        // Color of the shadow
                                        spreadRadius:
                                            1, // Spread radius of the shadow
                                        blurRadius:
                                            10, // Blur radius of the shadow
                                        offset: Offset(3,
                                            3), // Offset of the shadow (horizontal, vertical)
                                      ),
                                      BoxShadow(
                                        color: Colors.blueGrey.shade200,
                                        // Color of the shadow
                                        spreadRadius:
                                            1, // Spread radius of the shadow
                                        blurRadius:
                                            1, // Blur radius of the shadow
                                        offset: Offset(-1,
                                            -1), // Offset of the shadow (horizontal, vertical)
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.grey.shade700,
                                        // Color of the shadow
                                        spreadRadius:
                                            1, // Spread radius of the shadow
                                        blurRadius:
                                            10, // Blur radius of the shadow
                                        offset: Offset(3,
                                            3), // Offset of the shadow (horizontal, vertical)
                                      ),
                                      BoxShadow(
                                        color: Colors.blueGrey.shade200,
                                        // Color of the shadow
                                        spreadRadius:
                                            1, // Spread radius of the shadow
                                        blurRadius:
                                            1, // Blur radius of the shadow
                                        offset: Offset(-1,
                                            -1), // Offset of the shadow (horizontal, vertical)
                                      ),
                                    ],
                              gradient: isCurrentUserSender
                                  ? LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                          Color.fromARGB(255, 21, 27, 31),
                                          Color.fromARGB(21, 49, 154, 215)
                                        ])
                                  : LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                          Color.fromARGB(197, 0, 0, 0),
                                          Color.fromARGB(200, 0, 0, 0),
                                        ])),
                          child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeIn,
                            child: Text(
                              messageText,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ]));
  }
}

class Bottomsection extends StatefulWidget {
  //late String userid;
  String userid;
  Bottomsection({required this.userid});

  @override
  State<Bottomsection> createState() => _BottomsectionState();
}

class _BottomsectionState extends State<Bottomsection> {
  String msg = "";
  final controller = TextEditingController();
//late String userid; // Initialize userId as an empty string
  @override
  void initState() {
    // fetchUserid();
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser(); // Update currentuserid when the authentication state changes
    });
  }

  getMsg(msg) {
    this.msg = msg;
  }

  String currentuserid = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    return BottomAppBar(
        elevation: 15,
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: IconButton(
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                              0,
                              MediaQuery.of(context).size.height / 2,
                              0,
                              MediaQuery.of(context).size.height / 2),
                          items: [
                            PopupMenuItem(
                              child: PopUpContent(),
                            ),
                          ],
                        );
                      },
                      icon: Icon(Icons.attachment,
                          size: 30, color: Colors.white)),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    autofocus: false,
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      hintText: '      Say hi...',
                      suffixIcon: IconButton(
                        onPressed: () {
                          //  fetchUserid();
                          sendMsg(
                              msg: msg,
                              userId: currentuserid,
                              receiverId: widget.userid);
                          print(msg);
                          print("reciever " + widget.userid);
                          print("sender " + currentuserid);
                        },
                        icon: Icon(
                          Icons.send,
                          color: Color.fromARGB(193, 77, 140, 176),
                        ),
                      ),
                      //prefixIcon:
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    onChanged: (String msg) {
                      getMsg(msg);
                    },
                  ),
                )),
                SizedBox(width: 8),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(193, 77, 140, 176),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.keyboard_voice_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
