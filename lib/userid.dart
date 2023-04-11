import 'dart:ui';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'image_picker.dart';
import 'image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class userid extends StatefulWidget {
  const userid({super.key});

  @override
  State<userid> createState() => _useridState();
}

class _useridState extends State<userid> {
  String user_name = "";
  String birth_date = "";
  File? _image;

  Future _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  getUserName(user_name) {
    this.user_name = user_name;
  }

  getUserBirthdate(birth_date) {
    this.birth_date = birth_date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 90),
        Container(
            child: Text(
          "Personal informations",
          style: TextStyle(
            color: Color.fromARGB(255, 73, 43, 7),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )),
        SizedBox(height: 45),
        Stack(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Color.fromARGB(181, 50, 114, 167),
              child: ClipOval(
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: (_image != null)
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Container(
                          child: CircleAvatar(
                            child: Image(
                                image:
                                    AssetImage('images/avatar/default.jpeg')),
                          ),
                        ),
                ),
              ),
            ),
            /* ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Image'),
            ),*/
            /*  if (_image != null) Image.file(_image!),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Image'),
            ),*/
            Positioned(
              bottom: -14,
              right: -14,
              child: IconButton(
                  onPressed: _getImageFromGallery,
                  /*_createUserWithPhoto*/
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Color.fromARGB(163, 33, 159, 243),
                  )),
            )
          ],
        ),
        SizedBox(height: 45),
        Container(
          //padding: EdgeInsets.only(left: 25),
          width: 380,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'User name',
              prefixIcon: Icon(Icons.mail),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(18)),
            ),
            onChanged: getUserName,
          ),
        ),
        SizedBox(height: 35),
        Container(
          width: 380,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Birth date (17/12/2000)',
              prefixIcon: Icon(Icons.calendar_today_outlined),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(18)),
            ),
            onChanged: getUserBirthdate,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        /*Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: IconButton(
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
              icon: Icon(Icons.insert_photo)),
        ),*/
        SizedBox(height: 30),
        SizedBox(height: 30),
        Container(
            height: 70,
            width: 120,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                  _createUserWithPhoto;
                  createUser(
                      user_name: user_name,
                      birth_date: birth_date,
                      photo: _image!);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 99, 178, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18), // <-- Radius
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )))
      ])),
    );
  }

  Future _createUserWithPhoto() async {
    if (_image != null) {
      // Pass the selected image to the createUser method
      await createUser(
        user_name: user_name,
        birth_date: birth_date,
        photo: _image!,
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

  Future createUser(
      {required String user_name,
      required String birth_date,
      required File photo}) async {
    String fileName = path.basename(_image!.path);
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('photos/$fileName');
    await storageRef.putFile(_image!);
    final downloadURL = await storageRef.getDownloadURL();

    // Save the user data and photo download URL to Firestore
    final docUser = FirebaseFirestore.instance.collection('Users').doc();
    final json = {
      'user_name': user_name,
      'birth_date': birth_date,
      'photo_url': downloadURL,
    };
    await docUser.set(json);
  }
}
