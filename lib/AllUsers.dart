import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mychat.dart';

class AllUsersWidget extends StatefulWidget {
  @override
  _AllUsersWidgetState createState() => _AllUsersWidgetState();
}

class _AllUsersWidgetState extends State<AllUsersWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(5, 66, 66, 66),
      /* appBar: AppBar(
        backgroundColor: Color.fromARGB(219, 7, 44, 66),
        title: Text(
          'Start a new chat',
          style: TextStyle(fontSize: 18),
        ),
      ),*/
      floatingActionButton: null,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: ListTile(
                      onTap: () {
                        // Navigate to user detail page and pass userId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chatPage5(userid: user.id),
                          ),
                        );
                      },
                      leading: Container(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(photoUrl),
                        ),
                      ),
                      title: Text(
                        userName,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
