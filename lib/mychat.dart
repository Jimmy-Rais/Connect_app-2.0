import 'dart:ui';
import 'package:Connect/chats.dart';
import 'package:Connect/main.dart';
import 'package:Connect/userid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/*

return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: 850,
        width: 2000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/avatar/wal.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //child: Image(image: AssetImage("images/avatar/home.jpeg")),
      ),
      Container(
        padding: EdgeInsets.only(bottom: 10),
        // height: double.infinity,
        width: 280,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
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

        /* StreamBuilder<QuerySnapshot>(
            stream: ,.,,..,.,messagesCollection.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }

              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final messages = snapshot.data!.docs;
                  final sortedMessages = messages
                      .where((doc) => doc['timestamp'] != null)
                      .toList() // filter out documents with null timestamps
                    ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
                  if (index >= sortedMessages.length) {
                    // handle case where index is out of range
                    return Container();
                  }
                  final message = sortedMessages[index];
                  final timestamp = message['timestamp'] as Timestamp;
                  final dateTime = timestamp.toDate();
                  final formattedDateTime =
                      DateFormat('MMMM dd,hh:mm a').format(dateTime);
                  /* itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final message = snapshot.data!.docs[index];*/
                  return ListTile(
                      title: Stack(children: <Widget>[
                    Container(
                        constraints: BoxConstraints(
                            minWidth: 50,
                            maxWidth: double.infinity,
                            minHeight: 45,
                            maxHeight: double.infinity),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color.fromARGB(255, 2, 32, 48),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  message['message'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 130),
                                      child: Text(
                                        formattedDateTime,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.check,
                                      color: Colors.grey,
                                      size: 10,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ) /*FittedBox(
                      fit: BoxFit.none, // BoxFit.scaleDown,
                      child: Text(
                        message['message'],
                          style: TextStyle(color: Colors.white),
                      )),*/
                        //subtitle: Text(message['body']),
                        ),
                  ]));
                },
              );
            },
          )*/
/*Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Online 30 minutes ago",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),*/
      )
    ]));

*/

//final currentUser = FirebaseAuth.instance.currentUser;
//final userId = currentUser?.uid ?? '';
GlobalKey<_chatPage5State> mainWidgetKey = GlobalKey<_chatPage5State>();

final CollectionReference messagesCollection =
    FirebaseFirestore.instance.collection('messages').doc().collection('chats');

class chatPage5 extends StatefulWidget {
  //const chatPage({Key? key}) : super(key: key);
  final String userid;

  chatPage5({required this.userid});

  @override
  State<chatPage5> createState() => _chatPage5State();
}

class _chatPage5State extends State<chatPage5> {
  String chatDocumentId = ""; // Initialize with an empty string

  String currentuserid = '';
  // Function to update chatDocumentId
  void updateChatDocumentId(String newChatDocumentId) {
    chatDocumentId = newChatDocumentId; // Update the chatDocumentId
  }

  // Function to handle ListTile onTap
  void handleListTileTap(String chatDocId) {
    // Call the updateChatDocumentId function to update the chatDocumentId
    updateChatDocumentId(chatDocId);

    // ... (Navigate to ChattingSection if needed)
  }

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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            leadingWidth: 150,
            leading: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(widget.userid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  final Map<String, dynamic> userData =
                      snapshot.data!.data()! as Map<String, dynamic>;
                  final String userName = userData['user_name'];
                  String photoUrl = userData['photo_url'];

                  return InkWell(
                    onTap: () => {
                      /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StoryDetailsPage(
                                        storySnapshot: document))),*/
                    },
                    splashColor: Color.fromARGB(255, 99, 178, 223),
                    child: Container(
                      //padding: EdgeInsets.only(left: 25, right: 6, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(photoUrl),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            userName,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontStyle: FontStyle.italic,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            /* automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leadingWidth: 150,
        leading: Row(children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },*/

            /* Container(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(right: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/avatar/Jim.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Container(
              child: Text(
                "Jim",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),*/

            actions: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .where('Participants', arrayContains: currentuserid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final chatDocuments = snapshot.data!.docs;

                    // ... (The rest of your code from the original snippet)

                    return Container(
                      width: 300, // Adjust the width as needed
                      child: ListView.builder(
                        itemCount: chatDocuments.length,
                        itemBuilder: (context, index) {
                          final chatDoc = chatDocuments[index];
                          handleListTileTap(chatDoc.id);
                          /* setState(() {
                            chatDocumentId =
                                chatDoc.id; // Update the chatDocumentId
                          });*/

                          // Access the 'chats' subcollection of the chat document
                          final chatSubcollection =
                              chatDoc.reference.collection('chats');

                          // ... (The rest of your code for each ListTile)
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],

            /*IconButton(
                icon: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 23,
                ),
                onPressed: () {},
              ),*/
          )),
      body: chattingSection(chatDocumentId: chatDocumentId),
      bottomNavigationBar: Bottomsection(userid: widget.userid),
    );
  }
}

//Bottom section
class Bottomsection extends StatefulWidget {
  final String userid;
  Bottomsection({required this.userid});

  @override
  State<Bottomsection> createState() => _BottomsectionState();
}

class _BottomsectionState extends State<Bottomsection> {
  String msg = "";
  final controller = TextEditingController();
  getMsg(msg) {
    this.msg = msg;
  }

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
                          sendMsg(
                              msg: msg,
                              userId: currentuserid,
                              receiverId: widget.userid);
                          print(msg);
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

//Chatting section
class chattingSection extends StatefulWidget {
  final String chatDocumentId;
  chattingSection({required this.chatDocumentId});

  @override
  State<chattingSection> createState() => _chattingSectionState();
}

class _chattingSectionState extends State<chattingSection> {
  final List messages = [];
  String currentuserid = '';
  String chatDocumentId = ""; // Initialize with an empty string

  // Function to update chatDocumentId
  void updateChatDocumentId(String newChatDocumentId) {
    setState(() {
      chatDocumentId = newChatDocumentId; // Update the chatDocumentId
    });
  }

  // Function to handle ListTile onTap
  void handleListTileTap(String chatDocId) {
    // Call the updateChatDocumentId function to update the chatDocumentId
    updateChatDocumentId(chatDocId);

    // ... (Navigate to ChattingSection if needed)
  }

  @override
  void initState() {
    super.initState();
    updateUser();
    // Initialize currentuserid
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

                            return Scaffold(
                                body: Stack(children: <Widget>[
                              Container(
                                height: 850,
                                width: 2000,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/avatar/wal.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                //child: Image(image: AssetImage("images/avatar/home.jpeg")),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                // height: double.infinity,
                                width: 280,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: StreamBuilder<QuerySnapshot>(
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
                                          final messageText =
                                              message['messagetxt'];
                                          final senderId = message['senderid'];
                                          final receiverId =
                                              message['receiverid'];
                                          final participants = [senderId];
                                          final isCurrentUserSender = //senderId ? true : false;
                                              participants
                                                  .contains(currentuserid);

                                          return Align(
                                            alignment: isCurrentUserSender
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: isCurrentUserSender
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              ),
                                              child: Text(
                                                messageText,
                                                style: TextStyle(
                                                    color: Colors.white),
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

                                /* StreamBuilder<QuerySnapshot>(
            stream: ,.,,..,.,messagesCollection.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }

              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final messages = snapshot.data!.docs;
                  final sortedMessages = messages
                      .where((doc) => doc['timestamp'] != null)
                      .toList() // filter out documents with null timestamps
                    ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
                  if (index >= sortedMessages.length) {
                    // handle case where index is out of range
                    return Container();
                  }
                  final message = sortedMessages[index];
                  final timestamp = message['timestamp'] as Timestamp;
                  final dateTime = timestamp.toDate();
                  final formattedDateTime =
                      DateFormat('MMMM dd,hh:mm a').format(dateTime);
                  /* itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final message = snapshot.data!.docs[index];*/
                  return ListTile(
                      title: Stack(children: <Widget>[
                    Container(
                        constraints: BoxConstraints(
                            minWidth: 50,
                            maxWidth: double.infinity,
                            minHeight: 45,
                            maxHeight: double.infinity),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Color.fromARGB(255, 2, 32, 48),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  message['message'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 130),
                                      child: Text(
                                        formattedDateTime,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.check,
                                      color: Colors.grey,
                                      size: 10,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ) /*FittedBox(
                      fit: BoxFit.none, // BoxFit.scaleDown,
                      child: Text(
                        message['message'],
                          style: TextStyle(color: Colors.white),
                      )),*/
                        //subtitle: Text(message['body']),
                        ),
                  ]));
                },
              );
            },
          )*/
/*Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Online 30 minutes ago",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),*/
                              )
                            ]));
                          },
                        ),
                        onTap: () {
                          /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(chatDocumentId: chatDoc.id),
                            ),
                          );*/
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

//Write data on cloud Firestore
/*Future sendMsg(
    {required String msg,
    required String userId,
    required String userid}) async {
  final docUser = FirebaseFirestore.instance.collection('messages').doc(userid);
  final json = {
    'message': msg,
    'timestamp': FieldValue.serverTimestamp(),
    'sender_id': userId,
    'receiver_id': userid,
    //'userid': userid,
  };
  await docUser.set(json);
}*/
/*Future<void> sendMsg({
  required String msg,
  required String userId,
  required String receiverId,
}) async {
  final chatDocumentId = '$userId' + '_' + '$receiverId';
  final docUser = FirebaseFirestore.instance
      .collection('messages')
      .doc(chatDocumentId)
      .collection('chats')
      .doc(); // Use auto-generated ID for messages
  final json = {
    'messagetxt': msg,
    'readstatus': false,
    'senderid': userId,
    'receiverid': receiverId,
    'timestamp': FieldValue.serverTimestamp(),
  };
  await docUser.set(json);
}*/
Future<void> sendMsg({
  required String msg,
  required String userId,
  required String receiverId,
}) /*async {
  final chatDocumentId = '$userId' + '_' + '$receiverId';
  final docUser = FirebaseFirestore.instance
      .collection('messages')
      .doc(chatDocumentId)
      .collection('chats')
      .doc(); // Use auto-generated ID for messages
  final json = {
    'messagetxt': msg,
    'readstatus': false,
    'senderid': userId,
    'receiverid': receiverId,
    'timestamp': FieldValue.serverTimestamp(),
  };*/
async {
  // Create a chatDocumentId with sorted participant IDs without an underscore
  final sortedIds = [userId, receiverId]..sort();

  // Concatenate sorted IDs without any delimiter
  final chatDocumentId = sortedIds.join('');

  final docUser = FirebaseFirestore.instance
      .collection('messages')
      .doc(chatDocumentId)
      .collection('chats')
      .doc(); // Use auto-generated ID for messages
  final json = {
    'messagetxt': msg,
    'readstatus': false,
    'senderid': userId,
    'receiverid': receiverId,
    'timestamp': FieldValue.serverTimestamp(),
  };
  // Update participants field of the message document
  final participantArray = [userId, receiverId];
  await FirebaseFirestore.instance
      .collection('messages')
      .doc(chatDocumentId)
      .set({
    'Participants': participantArray,
  }, SetOptions(merge: true)); // Merge the new data with existing document

  // Add the new message to the chats subcollection
  await docUser.set(json);
}

//Read data
class PopUpContent extends StatefulWidget {
  @override
  _PopUpContentState createState() => _PopUpContentState();
}

class _PopUpContentState extends State<PopUpContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Camera'),
            onTap: () {
              // Do something when image option is selected
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Gallery'),
            onTap: () {
              // Do something when gallery option is selected
            },
          ),
        ),
        PopupMenuItem(
            child: ListTile(
          leading: Icon(Icons.file_copy),
          title: Text('Document'),
          onTap: () {
            // Do something when image option is selected
          },
        )),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Audio'),
            onTap: () {
              // Do something when audio option is selected
            },
          ),
        ),
        /*PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Location'),
            onTap: () {
              // Do something when location option is selected
            },
          ),
        ),*/
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Contact'),
            onTap: () {
              // Do something when contact option is selected
            },
          ),
        ),
      ],
    );
  }
}

/*import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chatPage extends StatelessWidget {
  const chatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leadingWidth: 150,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 99, 178, 223),
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Container(
              margin: EdgeInsets.only(right: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('images/avatar/Jim.jpg'),
              ),
            ),
            SizedBox(width: 5),
            Container(
              child: Text(
                "Jim",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              color: Color.fromARGB(255, 99, 178, 223),
              size: 23,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: chattingSection(),
      bottomNavigationBar: Bottomsection(),
    );
  }
}

//Bottom section
class Bottomsection extends StatelessWidget {
  Bottomsection({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 15,
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: '      Say hi...',
                  prefixIcon: IconButton(
                      onPressed: () {
                        final name = controller.text;
                        createUser(name: name);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 99, 178, 223),
                      )),
                  suffixIcon: Icon(Icons.emoji_emotions_outlined,
                      size: 30, color: Color.fromARGB(255, 99, 178, 223)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 178, 223),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.keyboard_voice_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Chatting section
class chattingSection extends StatelessWidget {
  const chattingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Online 30 minutes ago",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}

Future createUser({required String name}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc('my-idi');
  final json = {
    'date': 13,
    'message': 'Salut',
    'name': name,
  };
  await docUser.set(json);
}
*/
