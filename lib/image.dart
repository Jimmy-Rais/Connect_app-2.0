import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:image_picker/image_picker.dart';
import 'userid.dart';

class ImagePickerWidget1 extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget1> {
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future takePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              height: 60,
              width: 600,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Color.fromARGB(255, 99, 178, 223),
                      )),
                  SizedBox(width: 90),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions_rounded,
                        size: 30,
                        color: Color.fromARGB(255, 99, 178, 223),
                      )),
                  SizedBox(width: 35),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.rotate_90_degrees_ccw,
                        size: 30,
                        color: Color.fromARGB(255, 99, 178, 223),
                      )),
                  SizedBox(width: 35),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_note,
                        size: 30,
                        color: Color.fromARGB(255, 99, 178, 223),
                      ))
                ],
              ),
            ),
            Container(
              width: 500,
              height: 500,
              child: _image != null
                  ? Image.file(_image!)
                  : MyWidget(
                      asyncFunction: getImage,
                    ),
              /*Placeholder(
                  fallbackHeight: 200,
                  fallbackWidth: 200,
                
                ),*/
            ),

            /* ElevatedButton(
          onPressed: getImage,
          child: Text('Select Image'),
        ),
        ElevatedButton(
          onPressed: takePhoto,
          child: Text('Take Photo'),
        ),*/
            SizedBox(height: 60),
            Row(children: [
              SizedBox(width: 35),
              Container(
                height: 50,
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '      Add a caption...',
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.insert_photo_rounded,
                          color: Color.fromARGB(255, 99, 178, 223),
                        )),
                    /*suffixIcon: Icon(Icons.emoji_emotions_outlined,
                    size: 30, color: Color.fromARGB(255, 99, 178, 223)),*/
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                ),
              ),
              SizedBox(width: 3),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 99, 178, 223),
                    size: 30,
                  ))
            ]),
          ],
        )));
  }
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