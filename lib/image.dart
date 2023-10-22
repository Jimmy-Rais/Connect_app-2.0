import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Connect/main.dart';
import 'package:image_picker/image_picker.dart';
import 'userid.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'userid.dart';
import 'dart:ui';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Connect/main.dart';
import 'image_picker.dart';
import 'image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*class YourClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserName() async {
    User user = FirebaseAuth.instance.currentUser!;
    if (user != null) {
      DocumentSnapshot snapshot = await _firestore.collection('Users').doc(user.uid).get();
      if (snapshot.exists) {
        return snapshot.data()?.['user_name'] ?? '';
      } else {
        throw Exception('User data not found');
      }
    } else {
      throw Exception('User is not logged in');
    }
  }
}*/
final currentUser = FirebaseAuth.instance.currentUser;
String userId = currentUser?.uid ?? '';

class ImagePickerWidget1 extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget1> {
  File? _image;
  String caption = '';
  final picker = ImagePicker();
  getCaption(caption) {
    this.caption = caption;
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future takePhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(69, 77, 140, 176),
        /* Color.fromARGB(79, 158, 158, 158),*/
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              height: 45,
              width: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel, size: 30, color: Colors.white)),
                  SizedBox(width: 35),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_note,
                        size: 30,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
                width: 500,
                height: 530,
                child: (_image != null)
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'RobotoMono',
                            fontStyle: FontStyle.italic,
                          ),
                          child: Center(
                              child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Share your passions...\n\nSpread positivity...\n\nConnect with others...\n\n',
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                                speed: const Duration(milliseconds: 50),
                              ),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          )),
                        )
                        /* MyWidget(
                      asyncFunction: getImage,
                    ),*/
                        /*Placeholder(
                  fallbackHeight: 200,
                  fallbackWidth: 200,
                
                ),*/
                        )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: takePhoto,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: getImage,
                    icon: Icon(
                      Icons.insert_photo_rounded,
                      color: Colors.white,
                    )),
              ],
            ),
            /* ElevatedButton(
          onPressed: getImage,
          child: Text('Select Image'),
        ),
        ElevatedButton(
          onPressed: takePhoto,
          child: Text('Take Photo'),
        ),*/
            SizedBox(height: 10),
            Row(children: [
              SizedBox(width: 80),
              Container(
                height: 50,
                width: 200,
                child: TextField(
                  onChanged: getCaption,
                  style: TextStyle(
                    color: Colors.white, // set text color here
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: '      Add a caption...',
                    hintStyle: TextStyle(color: Colors.white),
                    /* prefixIcon: IconButton(
                        onPressed: getImage,
                        icon: Icon(
                          Icons.insert_photo_rounded,
                          color: Color.fromARGB(255, 99, 178, 223),
                        )),*/
                    /*suffixIcon: Icon(Icons.emoji_emotions_outlined,
                    size: 30, color: Color.fromARGB(255, 99, 178, 223)),*/
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3),
              IconButton(
                  onPressed: () {
                    _createStoriesWithPhoto;
                    createStories(
                      caption: caption,
                      photo: _image!,
                      userId: userId,
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30,
                  ))
            ]),
          ],
        )));
  }

  Future _createStoriesWithPhoto() async {
    if (_image != null) {
      // Pass the selected image to the createUser method
      await createStories(
        caption: caption,
        photo: _image!,
        userId: userId,
      );
    } else {
      // Show an error message if no image was selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select an image.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future createStories({
    required String caption,
    required File photo,
    required String userId,
  }) async {
    String fileName = path.basename(_image!.path);
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('photos/$fileName');
    await storageRef.putFile(_image!);
    final downloadURL = await storageRef.getDownloadURL();
    // Save the user data and photo download URL to Firestore
    final docUser = FirebaseFirestore.instance.collection('Stories').doc();
    final json = {
      'caption': caption,
      'photo_url': downloadURL,
      'userid': userId,
      'date': FieldValue.serverTimestamp(),
    };
    await docUser.set(json);
  }

/*class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Gallery'),
      ),*/
      body:   Column(
        children: [
          Container(
            height: 600,
            width: 500,
          ),
          SizedBox(height: 25),
          Row(
            children: [
              IconButton(
                onPressed: ,
                 icon:Icon(Icons.image),
                 
                 ),
                 SizedBox(width: 20),
                 IconButton(
                  onPressed: takePhoto
                   icon:Icon(Icons.camera_enhance_rounded))
            ],
          )
        ],
      )
    );
  }
}
*/
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'image_picker.dart';
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
      Container(height: 600,width:500),
      SizedBox(height: 10,),
      Row(
        children: [
          IconButton(
            onPressed:,
             icon:Icon(Icons.image_search,size: 20,color: Colors.white,),
             ),
             SizedBox(width: 15),
            IconButton(
            onPressed:,
             icon:Icon(Icons.camera_alt_outlined,size: 20,color: Colors.white),
             ), 
        ],
      )
     ],
    );
  }
}*/
}

class MyWidget extends StatelessWidget {
  final Future<dynamic> Function() asyncFunction;

  MyWidget({required this.asyncFunction});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: asyncFunction(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Text('Result: ${snapshot.data}');
          } else {
            return Text('No data');
          }
        } else {
          return HomePage();
        }
      },
    );
  }
}
