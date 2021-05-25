import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storeage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Myhomepage extends StatefulWidget {
  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  CollectionReference data = FirebaseFirestore.instance.collection('Data');
  var details = {"name": "sandeep", "email": "sandeeptk466@gmail.com"};
  late File file;
  var image;
  Future Getimage() async {
    image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (image == null) {
      } else {
        file = File(image.path);
        print("hello");
        print(file);
      }
    });
    print('here');
    print(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: InkWell(
                onTap: () {
                  Getimage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  child: image == null ? Text("Impty") : Image.file(file),
                )),
          ),
          //firestore data upload
          MaterialButton(
            color: Colors.red,
            onPressed: () async {
              firebase_storeage.Reference reference = firebase_storeage
                  .FirebaseStorage.instance
                  .ref()
                  .child("BEST");
              UploadTask uploadTask = reference.putFile(file);
              TaskSnapshot _snapshot = await uploadTask.snapshot;
              String url = await _snapshot.ref.getDownloadURL();
              print(url);
            },
            child: Text('push photo'),
          ),
          //cloud store data upload
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              data.add(details);
            },
            child: Text('push'),
          ),
        ],
      )),
    );
  }
}
