import 'dart:ui';

import 'package:Connect/chats.dart';
import 'package:Connect/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currentUser = FirebaseAuth.instance.currentUser;
final userId = currentUser?.uid ?? '';
final CollectionReference messagesCollection =
    FirebaseFirestore.instance.collection('Messages');

class chatPage extends StatelessWidget {
  const chatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            },
          ),
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
        ]),
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
      ),
      body: chattingSection(),
      bottomNavigationBar: Bottomsection(),
    );
  }
}

//Bottom section
class Bottomsection extends StatefulWidget {
  Bottomsection({Key? key}) : super(key: key);

  @override
  State<Bottomsection> createState() => _BottomsectionState();
}

class _BottomsectionState extends State<Bottomsection> {
  String msg = "";
  final controller = TextEditingController();
  getMsg(msg) {
    this.msg = msg;
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
                          sendMsg(msg: msg, userId: userId);
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
  const chattingSection({Key? key}) : super(key: key);

  @override
  State<chattingSection> createState() => _chattingSectionState();
}

class _chattingSectionState extends State<chattingSection> {
  final List Messages = [];
  @override
  Widget build(BuildContext context) {
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
            stream: messagesCollection.snapshots(),
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
                            minWidth: 10,
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
                                      padding: const EdgeInsets.only(left: 140),
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
          )
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
  }
}

//Write data on cloud Firestore
Future sendMsg({required String msg, required String userId}) async {
  final docUser = FirebaseFirestore.instance.collection('Messages').doc();
  final json = {
    'message': msg,
    'timestamp': FieldValue.serverTimestamp(),
    'user_id': userId,
  };
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
