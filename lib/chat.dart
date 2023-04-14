import 'dart:ui';

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
        leading: Row(children: [
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
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
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
                    size: 30, color: Color.fromARGB(255, 99, 178, 223))),
            Expanded(
              child: TextField(
                autofocus: false,
                controller: controller,
                decoration: InputDecoration(
                  hintText: '      Say hi...',
                  suffixIcon: IconButton(
                    onPressed: () {
                      sendMsg(msg: msg);
                      print(msg);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 99, 178, 223),
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
                fontSize: 12,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

Future sendMsg({required String msg}) async {
  final docUser = FirebaseFirestore.instance.collection('Messages').doc();
  final json = {
    'message': msg,
  };
  await docUser.set(json);
}

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
