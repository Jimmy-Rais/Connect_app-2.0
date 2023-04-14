import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'login.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Page.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'image_picker.dart';
import 'image.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class MyState extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Connect",
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = true;

  late int _lastBackPressedTime;
  Future<bool> _onWillPop() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Press back again to exit'),
    ));
    // Return false to prevent the app from exiting immediately
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? Colors.grey[800] : Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(105, 77, 140, 176),
          /*_isDarkMode ? Colors.grey[800] : Colors.grey[100],*/
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: (() => Scaffold.of(context).openDrawer()),
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            );
          }),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            )
            /*   IconButton(
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              icon: Icon(
                Icons.switch_access_shortcut,
                size: 30,
                color: Colors.black,
              ),
            ),*/
          ],
        ),
        drawer: Drawer(
          backgroundColor: _isDarkMode
              ? Colors.grey[800]
              : Color.fromARGB(255, 245, 245, 245),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                  height: 320,
                  child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(105, 77, 140, 176),
                        /*Color.fromARGB(255, 99, 178, 223),*/
                      ),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 2, right: 50),
                              child: Row(children: [
                                Text(
                                  "User : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'Jimmy Rais',
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      speed: const Duration(milliseconds: 200),
                                    ),
                                  ],
                                ),
                              ])),
                          Container(
                              padding: EdgeInsets.all(27),
                              child: AvatarGlow(
                                startDelay: Duration(milliseconds: 1000),
                                glowColor: Color.fromARGB(255, 194, 14, 14),
                                endRadius: 80,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    Duration(milliseconds: 100),
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      AssetImage('images/avatar/Pierre.jpg'),
                                ),
                              ))
                        ],
                      ))),
              ListTile(
                leading: Icon(
                  Icons.contact_page_rounded,
                ),
                title: const Text('Contacts',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                ),
                title: const Text('Groups',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(
                  Icons.remove_red_eye,
                ),
                title: const Text('Online Contacts',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(
                  Icons.call,
                ),
                title: const Text('Calls History',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(
                  Icons.filter_1_outlined,
                ),
                title: const Text('Stories',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: const Text('Settings',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              ListTile(
                onTap: () {
                  showPlatformDialog(
                      context: context,
                      builder: ((context) => BasicDialogAlert(
                            title: Text('Log out?',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            content: Text('Action cannot be undone',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            actions: <Widget>[
                              BasicDialogAction(
                                title: Text('Cancel',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              BasicDialogAction(
                                title: Text('Yes',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => login()));
                                  FirebaseAuth.instance.signOut();
                                },
                              ),
                            ],
                          )));
                },
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.logout_outlined, size: 25),
                ),
                title: const Text('Log out',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              /*ListTile(
                leading: IconButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: Icon(Icons.exit_to_app_sharp),
                ),
                title: const Text('Exit',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),*/
              SizedBox(height: 60),
            ],
          ),
        ),
        body: Column(
          children: [
            FavoriteSection(),
            Expanded(
              child: MessageSection(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 99, 178, 223),
          onPressed: () {
            showMenu(
              color: _isDarkMode
                  ? Colors.grey[800]
                  : Color.fromARGB(255, 245, 245, 245),
              context: context,
              position: RelativeRect.fromLTRB(
                  120.0, MediaQuery.of(context).size.height - 80.0, 80.0, 0.0),
              items: [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: _isDarkMode
                          ? Color.fromARGB(255, 245, 245, 245)
                          : Colors.grey[800],
                    ),
                    title: Text(
                      'New discussion',
                      style: TextStyle(
                        color: _isDarkMode
                            ? Color.fromARGB(255, 245, 245, 245)
                            : Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.key,
                      color: _isDarkMode
                          ? Color.fromARGB(255, 245, 245, 245)
                          : Colors.grey[800],
                    ),
                    title: Text(
                      'Archived',
                      style: TextStyle(
                        color: _isDarkMode
                            ? Color.fromARGB(255, 245, 245, 245)
                            : Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: _isDarkMode
                          ? Color.fromARGB(255, 245, 245, 245)
                          : Colors.grey[800],
                    ),
                    title: Text(
                      'Channels',
                      style: TextStyle(
                        color: _isDarkMode
                            ? Color.fromARGB(255, 245, 245, 245)
                            : Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Add a callback to the system back button
    // to call the _onWillPop() method when pressed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // The callback is executed after the frame is drawn
      // to prevent any animation from being interrupted
      // when the app is closed
      RawKeyboard.instance.addListener((event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          // When the escape key is pressed, call the _onWillPop() method
          _onWillPop().then((value) {
            if (value) {
              // If the _onWillPop() method returns true,
              // exit the app using the SystemNavigator.pop() method
              SystemNavigator.pop();
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // Remove the callback when the widget is disposed
    RawKeyboard.instance.removeListener((event) {});
    super.dispose();
  }
}

class MenuSection extends StatelessWidget {
  final List MenuItems = ["Messages", "Statut", "Online", "Call", "Group"];
  MenuSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: MenuItems.map((items) {
              return Container(
                margin: EdgeInsets.only(right: 55),
                child: Text(
                  items,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class FavoriteSection extends StatelessWidget {
  final List FavoriteContacts = [
    {
      'name': 'Jim',
      'profile': 'images/avatar/Jim.jpg',
    },
    {
      'name': 'Joe',
      'profile': 'images/avatar/Joe.jpg',
    },
    {
      'name': 'Dan',
      'profile': 'images/avatar/Dan.jpg',
    },
    {
      'name': 'Amanda',
      'profile': 'images/avatar/Amanda.jpg',
    },
    {
      'name': 'Lucas',
      'profile': 'images/avatar/Lucas.jpg',
    },
    {
      'name': 'Louise',
      'profile': 'images/avatar/Louise.jpg',
    },
    {
      'name': 'Arnold',
      'profile': 'images/avatar/Arnold.jpg',
    },
  ];
  FavoriteSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myState = Provider.of<MyState>(context);

    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15), //Contenu à la verticale
        decoration: BoxDecoration(
          color: const Color.fromARGB(105, 77, 140, 176),
          /*Color.fromARGB(255, 99, 178, 223),*/
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(-60),
            bottomRight: Radius.circular(-60),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "STORIES",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 180),
                /*IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                      );
                    },
                    icon: Icon(
                      Icons.insert_photo,
                      size: 23,
                      color: Colors.white,
                    )),*/
                IconButton(
                  onPressed: () {
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
                    );
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FavoriteContacts.map((fav) {
                  return Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(fav['profile']),
                          ),
                        ),
                        SizedBox(
                            height: 6), // Create space between these two parts
                        Text(
                          fav['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class change extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class MessageSection extends StatelessWidget {
  final List Messages = [
    {
      'sendername': 'Jim',
      'senderprofile': 'images/avatar/Jim.jpg',
      'message': 'Hello',
      'unread': 0,
      'date': '8:34',
    },
    {
      'sendername': 'Amanda',
      'senderprofile': 'images/avatar/Amanda.jpg',
      'message': 'Salut',
      'unread': 2,
      'date': '12:20',
    },
    {
      'sendername': 'Gloire',
      'senderprofile': 'images/avatar/Amanda.jpg',
      'message': 'Bonjour',
      'unread': 1,
      'date': '19:00',
    },
    {
      'sendername': 'Erick',
      'senderprofile': 'images/avatar/Erick.jpg',
      'message': 'Je suis là!',
      'unread': 4,
      'date': '19:05',
    },
    {
      'sendername': 'Michel',
      'senderprofile': 'images/avatar/Michel.jpg',
      'message': 'On se voit demain',
      'unread': 2,
      'date': '20:12',
    },
    {
      'sendername': 'Lucas',
      'senderprofile': 'images/avatar/Lucas.jpg',
      'message': 'Bonsoir!',
      'unread': 0,
      'date': '20:22',
    },
    {
      'sendername': 'Jordan',
      'senderprofile': 'images/avatar/Jordan.jpg',
      'message': 'Tu vas bien?',
      'unread': 1,
      'date': '20:34',
    },
    {
      'sendername': 'Louise',
      'senderprofile': 'images/avatar/Louise.jpg',
      'message': 'Hey',
      'unread': 3,
      'date': '21:00',
    },
    {
      'sendername': 'Pierre',
      'senderprofile': 'images/avatar/Pierre.jpg',
      'message': 'Bonsoir',
      'unread': 5,
      'date': '21:34',
    },
    {
      'sendername': 'Claire',
      'senderprofile': 'images/avatar/Claire.jpg',
      'message': 'Salut',
      'unread': 2,
      'date': '22:00',
    },
  ];
  MessageSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: Messages.map((Mess) {
          // Click detection
          return InkWell(
            onTap: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      chatPage(),
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
              padding: EdgeInsets.only(left: 7, right: 10, top: 15),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Mess['senderprofile']),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        // Max Space between row elements
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            // Start from the right
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Mess['sendername'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // Line return
                              Wrap(
                                children: [
                                  Text(
                                    Mess['message'],
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
                            children: [
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
                            ],
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
                  ))
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
// Chat Page
