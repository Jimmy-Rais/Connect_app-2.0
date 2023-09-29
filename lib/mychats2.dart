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
          String? otherUserId;
          return ListView.builder(
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
                      }
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
                              return Text('User data not found');
                            }

                            final userData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            final otherUserName =
                                userData['user_name'] as String? ?? 'User';
                            final otherUserProfilePhoto =
                                userData['photo_url'] as String?;
                            print("sender id=" + senderId);
                            print("reciever id=" + receiverId);
                            return Row(
                              children: [
                                //SizedBox(height: 1),
                                //Padding(
                                //padding: EdgeInsets.only(top: 1, left: 8)),
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
                                  child: CircleAvatar(
                                      child: ClipOval(
                                    child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              otherUserProfilePhoto ?? ''),
                                          /* Back(
                                        fit: BoxFit.cover,
                                      image: AssetImage('images/Jim.JPG'),
                                      ),
                                    ),*/
                                        )),
                                  )),
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
                                        // Start from the right
                                        //crossAxisAlignment:
                                        // CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            otherUserName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
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
                                    /*SizedBox(
                                    width: 16), // Adjust the spacing as needed
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      otherUserName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      "hey...",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                      ),
                                    )
                                  ],
                                ),
                              ],*/
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
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  chatDocumentId: chatDoc.id,
                                  userid: otherUserId ?? ""),
                            ),
                          );
                        },
                      );

                      /*    return ListTile(
                        title: Text(
                          'Chat with $otherUserId',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(chatDocumentId: chatDoc.id),
                            ),
                          );
                        },
                      );*/
                    }
                  }

                  // Handle loading state, no documents, or error
                  return Text(
                      ''); // or another loading indicator or error message
                },
              );
            },
          );

          /*  return
           ListView.builder(
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
          );*/
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
  final String userid;
  ChatScreen({required this.chatDocumentId, required this.userid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String reciever;
  String currentuserid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser();
      // Update currentuserid when the authentication state changes
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
                .doc(widget.userid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              }
              /* if (!snapshot.data.exists) {
        return Text('User Not Found');
      }*/

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
                    child: CircleAvatar(
                        child: ClipOval(
                      child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userPhotoUrl),
                            /* Back(
                                        fit: BoxFit.cover,
                                      image: AssetImage('images/Jim.JPG'),
                                      ),
                                    ),*/
                          )),
                    )),
                  ),
                  /*Container(
                    height: 70,
                width: 70,
                padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userPhotoUrl),
                    ),
                  ),*/
                  SizedBox(width: 14),
                  Column(
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
        bottomNavigationBar: Bottomsection(userid: widget.userid),
        /*bottomNavigationBar: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return Text('Loading...');
            }
            final users = snapshot.data!.docs
                .where((doc) => doc.id != _auth.currentUser!.uid);
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users.elementAt(index);
                  final photoUrl = user.get('photo_url');
                  final userName = user.get('user_name');
                  final userid = user.id;
                });
            //return Bottomsection(userid: userid);
          }),*/
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
                                  ? Color.fromARGB(255, 49, 154, 215)
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
                                          Color.fromARGB(255, 29, 120, 173),
                                          Color.fromARGB(209, 49, 154, 215),
                                        ])
                                  : LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                          Color.fromARGB(197, 0, 0, 0),
                                          Color.fromARGB(200, 0, 0, 0),
                                        ])),
                          child: Text(
                            messageText,
                            style: TextStyle(color: Colors.white),
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

/*Stack(children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/avatar/wal.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      //child: Image(image: AssetImage("images/avatar/home.jpeg")),
                    ),
                    Container(
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
                  ]),*/
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
  // Method to get the userid asynchronously
  // Initialize userId as an empty string

  // Method to get the userid asynchronously
  /*Future<void> callUserId() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      final users = snapshot.docs.where((doc) {
        return doc.id != FirebaseAuth.instance.currentUser?.uid;
      });

      if (users.isNotEmpty) {
        final user = users.first;
        setState(() {
          userid = user.id;
          print("jim see this " +
              userid); // Assign userid to the local variable userId
        });
      }
    } catch (e) {
      print('Error retrieving userid: $e');
    }
  }*/

  getMsg(msg) {
    this.msg = msg;
  }

  // Fetch the userid when needed
  /*Future<void> fetchUserid() async {
    await callUserId();
  }*/

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
