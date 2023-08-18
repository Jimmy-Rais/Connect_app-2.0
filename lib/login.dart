import 'dart:ui';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'main.dart';
import 'signup.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'motion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: Container(
              child: Image(image: AssetImage('images/avatar/connect.jpg')),
            ),
          ),
          /*Container(
            child: Image(image: AssetImage('images/avatar/connect.jpg')),
          ),*/
          SizedBox(height: 120),
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            child: SizedBox(
              height: 80,
              width: 250,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            signin(),
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
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 99, 178, 223),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18), // <-- Radius
                    ),
                  ),
                  child: Text(
                    "SIGN IN",
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )),
            ),
          ),
          /* SizedBox(
            height: 80,
            width: 250,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          signin(),
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
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 99, 178, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18), // <-- Radius
                  ),
                ),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                )),
          ),*/
          SizedBox(height: 50),
          AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 2500),
              curve: Curves.easeIn,
              child: SizedBox(
                height: 80,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
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
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 99, 178, 223),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18), // <-- Radius
                    ),
                  ),
                  child: Text(
                    "SIGN UP",
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              )),

          /*SizedBox(
            height: 80,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
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
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 99, 178, 223),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18), // <-- Radius
                ),
              ),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),*/
          SizedBox(height: 160),
          Row(
            children: [
              SizedBox(
                width: 135,
              ),
              Text(
                "Made  in  DR CONGO",
                style: GoogleFonts.acme(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 15,
                width: 15,
                child: Flag.fromString(
                  'CD',
                  height: 200,
                  width: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          /*  Text(
            "Welcome to connect",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),*/
          /* Positioned(
              right: 100,
              top: 80,
              child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'RobotoMono',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Welcome to connect',
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                        speed: const Duration(milliseconds: 70),
                      ),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ))),*/
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

/*import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'main.dart';
import 'signup.dart';
import 'signin.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(children: [
      Container(
        child: Image(image: AssetImage('images/avatar/connect.jpg')),
      ),
      SizedBox(height: 120),
      SizedBox(
        height: 80,
        width: 250,
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      signin(),
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

              /* Navigator.push(
                  context, MaterialPageRoute(builder: (context) => signin()));*/
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 99, 178, 223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18), // <-- Radius
              ),
            ),
            child: Text(
              "SIGN IN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            )),
      ),
      SizedBox(height: 50),
      SizedBox(
        height: 80,
        width: 250,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
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
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 99, 178, 223),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18), // <-- Radius
            ),
          ),
          child: Text(
            "SIGN UP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      SizedBox(height: 50),
      /*AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            "Connect with the World:\nExperience the Next Level of\nSocial Media with Connect",
            textStyle: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            speed: const Duration(microseconds: 100),
          )
        ],
        onTap: () {
          print("Tap Event");
        },
      )*/
    ])));
  }
}
*/