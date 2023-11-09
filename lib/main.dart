import 'dart:ui';
import 'package:Connect/stories.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'login.dart';
import 'signin.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Page.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:firebase_database/firebase_database.dart';
import 'chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'image_picker.dart';
import 'image.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'AllUsers.dart';
import 'Pick.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'esp.dart';
import 'mychats2.dart';
import 'mychat.dart';
import 'api/firebase_api.dart';

/*Future<void> getUserData() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  final userName = userDoc.data()?['user_name'];
}*/
DatabaseReference ref = FirebaseDatabase.instance.ref();

// Access a child of the current reference
DatabaseReference child = ref.child("");

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
  await FirebaseApi().initNotifications();
  runApp(
    MyApp(),
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

  late String? _userId;
  late String _username;
  int _currentIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Container(),
      //AllUsersWidget(),
      ChatList(),
      //chatPage5(userid: userId),
      MyStories(),
    ];
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Color.fromARGB(73, 66, 66, 66),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: AppBar(
                title: DefaultTextStyle(
                  style: GoogleFonts.acme(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ScaleAnimatedText('Connect',
                          textStyle: GoogleFonts.acme(
                            fontSize: 15,
                          )),
                      ScaleAnimatedText('Connect'),
                      ScaleAnimatedText('Connect'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                    repeatForever: true,
                  ),
                ),
                backgroundColor: Color.fromARGB(73, 66, 66, 66),
                /*_isDarkMode ? Colors.grey[800] : Colors.grey[100],*/
                leading: Center(
                    child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 25),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('images/avatar/shalom.jpg'),
                      ),
                    ),
                  ],
                )),
                actions: [
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: (() => Scaffold.of(context).openDrawer()),
                      icon: const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      ),
                    );
                  })
                ],
              )),
          drawer: Drawer(
            backgroundColor: Color.fromRGBO(66, 66, 66, 1),
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
                                        'Tanatswa Shalom',
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        speed:
                                            const Duration(milliseconds: 200),
                                      ),
                                    ],
                                  ),
                                ])),
                            Container(
                                padding: EdgeInsets.all(27),
                                child: AvatarGlow(
                                  startDelay: Duration(milliseconds: 1000),
                                  glowColor: Colors.white,
                                  endRadius: 80,
                                  showTwoGlows: true,
                                  repeatPauseDuration:
                                      Duration(milliseconds: 100),
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage:
                                        AssetImage('images/avatar/shalom.jpg'),
                                  ),
                                ))
                          ],
                        ))),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AllUsersWidget(),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MyStories(),
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
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => login()));
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
                //SizedBox(height: 50),
                Column(
                  children: [
                    /*       ElevatedButton(
                      onPressed: () {
                        _changeLedStatus(true); // Turn LED ON
                      },
                      child: Text('Turn ON'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _changeLedStatus(false); // Turn LED OFF
                      },
                      child: Text('Turn OFF'),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 150),
                      child: Text(
                        "Connect v11.31.0.51",
                        style: GoogleFonts.acme(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      'LED Status: $ledStatus',
                      style: TextStyle(fontSize: 18),
                    ),*/
                    SizedBox(height: 110),
                    Container(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: Text(
                        "Made  by  jimmyrais63@gmail.com",
                        style: GoogleFonts.acme(
                          fontSize: 10,
                          color: const Color.fromARGB(92, 158, 158, 158),
                        ),
                      ),
                    ),
                  ],
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
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          /*Column(
          children: [
            //FavoriteSection(),
            Expanded(
              child: MessageSection(),
            ),
          ],
        ),*/
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0)),
            ),
            height: 100,
            child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.call,
                      // color: Color.fromARGB(105, 77, 140, 176),
                    ),
                    label: "Call",
                    backgroundColor: Color.fromARGB(10, 158, 158, 158),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.chat_bubble_outlined,
                        //color: Color.fromARGB(105, 77, 140, 176),
                      ),
                      label: "Chats",
                      backgroundColor: Color.fromARGB(10, 158, 158, 158)),
                  BottomNavigationBarItem(
                    icon: Icon(Icons
                        .add_a_photo), // color: Color.fromARGB(105, 77, 140, 176)),
                    label: "Stories",
                    backgroundColor: Color.fromARGB(2, 158, 158, 158),
                    //Color.fromARGB(105, 77, 140, 176),
                  ),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: _currentIndex,
                selectedItemColor:
                    Colors.white, //Color.fromARGB(105, 77, 140, 176),
                iconSize: 24,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                elevation: 1),
          ),
          floatingActionButton: _currentIndex == 1
              ? FloatingActionButton(
                  heroTag: 'Chats',
                  backgroundColor: _isDarkMode
                      ? Color.fromARGB(255, 77, 140, 176)
                      : Color.fromARGB(248, 107, 165,
                          212), //Color.fromARGB(105, 77, 140, 176),
                  onPressed: () {
                    showMenu(
                      color: _isDarkMode
                          ? Colors.grey[800]
                          : Color.fromARGB(255, 245, 245, 245),
                      context: context,
                      position: RelativeRect.fromLTRB(120.0,
                          MediaQuery.of(context).size.height - 80.0, 80.0, 0.0),
                      items: [
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      AllUsersWidget(),
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
                            },
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
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ChatListScreen(),
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
                            },
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
                )
              : _currentIndex == 2
                  ? SpeedDialFabWidget(
                      secondaryIconsList: [
                        Icons.add_a_photo,
                        Icons.photo,
                        Icons.edit,
                      ],
                      secondaryIconsText: [
                        "Camera",
                        "Gallery",
                        "Text",
                      ],
                      secondaryIconsOnPress: [
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImagePickerWidget1(),
                            ),
                          );
                        },
                        ImageUtils.getPhoto,
                        () => {},
                      ],
                      secondaryBackgroundColor:
                          Color.fromARGB(105, 77, 140, 176),
                      secondaryForegroundColor: Colors.white,
                      primaryBackgroundColor: Color.fromARGB(105, 77, 140, 176),
                      primaryForegroundColor: Colors.white,
                    )
                  : null,
        ));
  }

  @override
  void initState2() {
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

class FavoriteSection extends StatefulWidget {
  FavoriteSection({Key? key}) : super(key: key);

  @override
  State<FavoriteSection> createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends State<FavoriteSection> {
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
  final double _itemSpacing = 15.0;
  final double _itemWidth = 70.0;
  late ScrollController _scrollController;
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.animateTo(
          _scrollController.offset + _itemWidth + _itemSpacing,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

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
                  onPressed: () {
                    /*  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AnimatedRowScrolling(),
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
                    );*/
                  },
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MyStories(),
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
                    child: Text("STORIES",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
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
              controller: _scrollController,
              child: Row(
                children: FavoriteContacts.map((fav) {
                  return Container(
                    margin: EdgeInsets.only(left: _itemSpacing),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: _itemWidth,
                          width: _itemWidth,
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
                      /* Container(
                        height: 1.2,
                        color: Colors.grey,
                      )*/
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

class AnimatedRowScrolling extends StatefulWidget {
  @override
  _AnimatedRowScrollingState createState() => _AnimatedRowScrollingState();
}

class _AnimatedRowScrollingState extends State<AnimatedRowScrolling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _containerWidth = 100.0;
  final double _spacing = 16.0;
  final double _animationDuration = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _animationDuration.toInt()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _containerWidth,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Row(
            children: List.generate(
              5,
              (index) {
                final animationValue = (_controller.value + index / 5) %
                    1.0; // pour boucler l'animation

                return Padding(
                  padding: EdgeInsets.only(right: _spacing),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _containerWidth,
                    height: _containerWidth,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    transform: Matrix4.translationValues(
                      -animationValue * _containerWidth,
                      0,
                      0,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
