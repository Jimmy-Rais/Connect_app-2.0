import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Connect/signup.dart';
import 'chat.dart';
import 'main.dart';
import 'Page.dart';
import 'login.dart';
import 'signup.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
    );
  }
}

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                return HomePage();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()));
              } else {
                return signin();
              }
            })));
  }
}

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animateOpacity();
  }

  void _animateOpacity() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 20),
              curve: Curves.easeIn,*/
            Container(
              child: Image(image: AssetImage('images/avatar/connect2.jpg')),
            ),

            /*Container(
                child: Image(image: AssetImage('images/avatar/connect2.jpg'))),*/
            SizedBox(height: 35),
            Container(
                padding: EdgeInsets.only(right: 200),
                child: Text(
                  "",
                  style: TextStyle(
                    color: Color.fromARGB(255, 73, 43, 7),
                    fontSize: 25,
                    decoration: TextDecoration.none,
                  ),
                )),
            SizedBox(height: 25),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Container(
                width: 380,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email or phone number',
                    hintStyle: GoogleFonts.acme(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 202, 22, 22), width: 3),
                        borderRadius: BorderRadius.circular(18)),
                  ),
                ),
              ),
            ),
            /*Container(
              width: 380,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email or phone number',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),*/
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              child: Container(
                width: 380,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.acme(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 0.0),
                        borderRadius: BorderRadius.circular(18)),
                  ),
                ),
              ),
            ),
            /*  Container(
              width: 380,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),*/
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 190,
                ),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.easeIn,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.acme(
                          color: Color.fromARGB(255, 35, 152, 194),
                          fontSize: 15,
                        ),
                      )),
                ),
              ],
            ),
            /*TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 35, 152, 194),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                )),*/
            SizedBox(height: 30),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 2000),
              curve: Curves.easeIn,
              child: Container(
                  width: 280,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: SignIn,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 99, 178, 223),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18), // <-- Radius
                        ),
                      ),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.acme(
                          color: Colors.white,
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ))),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 2000),
              curve: Curves.easeIn,
              child: Container(
                  width: 280,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: SignIn,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(229, 230, 235, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18), // <-- Radius
                        ),
                      ),
                      child: Text(
                        'Login  with  Google',
                        style: GoogleFonts.acme(
                          color: Colors.grey,
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),
                      ))),
            ),
            /*  Container(
                width: 120,
                height: 70,
                child: ElevatedButton(
                    onPressed: SignIn,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 99, 178, 223),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ))),*/
            SizedBox(height: 80),
            AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 2500),
                curve: Curves.easeIn,
                child: Row(
                  children: [
                    SizedBox(width: 40),
                    Container(
                      padding: EdgeInsets.only(left: 75),
                      child: Text(
                        'New user?',
                        style: GoogleFonts.acme(
                          color: Color.fromARGB(255, 73, 43, 7),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      signup(),
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
                        child: Text(
                          "Create an account",
                          style: GoogleFonts.acme(
                            color: Color.fromARGB(255, 35, 152, 194),
                            fontSize: 15,
                          ),
                        )),
                  ],
                )),
            /*Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 75),
                  child: Text(
                    'New user?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 43, 7),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  signup(),
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
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 152, 194),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
              ],
            )*/
          ],
        ),
      ),
    );
  }

  Future SignIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

/*import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'main.dart';
import 'Page.dart';
import 'login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
    );
  }
}

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                return HomePage();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()));
              } else {
                return signin();
              }
            })));
  }
}

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: Image(image: AssetImage('images/avatar/connect2.jpg'))),
          SizedBox(height: 35),
          Container(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              )),
          SizedBox(height: 25),
          Container(
            width: 380,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email or phone number',
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: 380,
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.0),
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ),
          SizedBox(height: 18),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                ),
              )),
          Expanded(
              child: TextButton(
                  onPressed: SignIn,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Color.fromARGB(255, 99, 178, 223),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )))
        ],
      ),
    );
  }

  Future SignIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
*/
