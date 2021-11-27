import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class GroupWriting extends StatefulWidget {
  @override
  _GroupWritingState createState() => _GroupWritingState();
}

class _GroupWritingState extends State<GroupWriting> {
  String result = "";
  final _formKey = GlobalKey<FormState>();
  final FirebaseStorage storage = FirebaseStorage.instance;

  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  var _image;
  int numLines = 0;

  late FocusNode focusNode;
  initState() {
    super.initState();
    focusNode = FocusNode();
  }

  _imgFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    setState(() {
      _image = imageFile!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        //title: Text(),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  print(_formKey.currentState!.validate());
                }
              },
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                TextFormField(
                  cursorColor: Colors.black,
                  textAlign: TextAlign.left,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  autofocus: true,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintText: "자유롭게 적어주세요~",
                    isDense: true,
                    // border: new OutlineInputBorder(
                    //   borderRadius: const BorderRadius.all(
                    //     const Radius.circular(0.0),
                    //   ),
                    //   borderSide: new BorderSide(
                    //     color: Colors.black,
                    //     width: 1.5,
                    //   ),
                    // ),
                  ),
                  onChanged: (e) {
                    setState(() {
                      numLines = '\n'.allMatches(e).length + 1;
                      print(numLines);
                    });
                  },
                  validator: (value) {
                    if (value?.isEmpty == true || value!.length < 10) {
                      return '10자 이상은 써주셔야되요ㅠㅠ';
                    }
                    return null;
                  },
                ),
                _image == null
                    ? Container(
                        height: 0,
                        width: 0,
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        child: Image.file(
                          File(_image),
                          scale: 1,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: bottom(),
    );
  }

  Widget bottom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          IconButton(onPressed: _imgFromGallery, icon: Icon(Icons.album)),
          Padding(padding: EdgeInsets.only(left: 20)),
          IconButton(onPressed: () {}, icon: Icon(Icons.voicemail)),
          Padding(padding: EdgeInsets.only(left: 20)),
          //IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
        ],
      ),
    );
  }
}
