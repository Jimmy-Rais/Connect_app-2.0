import 'package:Connect/chat.dart';
import 'package:Connect/mychats2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mychat.dart';
import 'user.dart';

class AllUsersWidget extends StatefulWidget {
  @override
  _AllUsersWidgetState createState() => _AllUsersWidgetState();
}

class _AllUsersWidgetState extends State<AllUsersWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? currentuserid = FirebaseAuth.instance.currentUser?.uid;
  /*String userId = ''; // Initialize userId as an empty string

  // Call the method to retrieve the userid
  Future<void> fetchUserId() async {
    final userData = UserData();
    final userid = await userData.callUserId();
    setState(() {
      userId = userid;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(5, 66, 66, 66),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(73, 66, 66, 66),
        title: Text(
          'Start a new discussion',
          style: TextStyle(fontSize: 18),
        ),
      ),
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
          final users = snapshot.data?.docs
                  .where((doc) => doc.id != _auth.currentUser?.uid)
                  .toList() ??
              [];

          /*final users = snapshot.data!.docs
              .where((doc) => doc.id != _auth.currentUser!.uid);*/
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              final user = users.elementAt(index);
              final photoUrl = user.get('photo_url');
              final userName = user.get('user_name');
              final userid = user.id;
              print("All user..." + userid);
              final sortedIds = [currentuserid, userid]..sort();

              // Concatenate sorted IDs without any delimiter
              final chatDocumentId = sortedIds.join('');
              //  List<String> sortedUserIds = List.from([currentuserid, userid])..sort().toString().j=;
              print(chatDocumentId);
              return InkWell(
                  onTap: () {
                    //Navigate to user detail page and pass userId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            chatDocumentId: chatDocumentId, userid: userid),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15),
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
                                        const Color.fromARGB(98, 189, 189, 189),
                                      ])),
                              child: CircleAvatar(
                                  child: ClipOval(
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(photoUrl),
                                      /* Back(
                                        fit: BoxFit.cover,
                                      image: AssetImage('images/Jim.JPG'),
                                      ),
                                    ),*/
                                    )),
                              )),
                            ),
                            SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Online",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        /* ListTile(
                          onTap: () {
                            //Navigate to user detail page and pass userId
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    chatDocumentId: chatDocumentId,
                                    userid: userid),
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
                        ),*/
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
