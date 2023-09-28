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
      //bottomNavigationBar: BottomAppBar(),
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

          /*    final List<dynamic> participants = (chatDocuments['Participants'] as List<dynamic>) ?? [];
          final otherParticipant = participants.firstWhere(
            (participantId) => participantId != currentuserid,
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
                              return CircularProgressIndicator();
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

                            return Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(otherUserProfilePhoto ?? ''),
                                ),
                                SizedBox(
                                    width: 16), // Adjust the spacing as needed
                                Text(
                                  otherUserName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            );
                          },
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
                  return CircularProgressIndicator(); // or another loading indicator or error message
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
  String chatDocumentId;

  ChatScreen({required this.chatDocumentId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
          title: Text('Chat54'),
          leading: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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

                      // return Text(userid);
                    });
              })),
      bottomNavigationBar: Bottomsection(),
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
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isCurrentUserSender ? Colors.blue : Colors.grey,
                      ),
                      child: Text(
                        messageText,
                        style: TextStyle(color: Colors.black),
                      )),
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

class Bottomsection extends StatefulWidget {
  //late String userid;
  Bottomsection({Key? key}) : super(key: key);

  @override
  State<Bottomsection> createState() => _BottomsectionState();
}

class _BottomsectionState extends State<Bottomsection> {
  String msg = "";
  final controller = TextEditingController();
  late String userid; // Initialize userId as an empty string
  @override
  void initState() {
    fetchUserid();
    super.initState();
    updateUser(); // Initialize currentuserid
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      updateUser(); // Update currentuserid when the authentication state changes
    });
  }
  // Method to get the userid asynchronously
  // Initialize userId as an empty string

  // Method to get the userid asynchronously
  Future<void> callUserId() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      final users = snapshot.docs.where((doc) {
        return doc.id != FirebaseAuth.instance.currentUser?.uid;
      });

      if (users.isNotEmpty) {
        final user = users.first;
        setState(() {
          userid = user.id; // Assign userid to the local variable userId
        });
      }
    } catch (e) {
      print('Error retrieving userid: $e');
    }
  }

  getMsg(msg) {
    this.msg = msg;
  }

  // Fetch the userid when needed
  Future<void> fetchUserid() async {
    await callUserId();
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
                          fetchUserid();
                          sendMsg(
                              msg: msg,
                              userId: currentuserid,
                              receiverId: userid);
                          print(msg);
                          print(userid);
                          print("this" + currentuserid);
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
