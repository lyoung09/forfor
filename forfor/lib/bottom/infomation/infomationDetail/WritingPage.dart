import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
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
    final imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                Icons.save_rounded,
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
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: TextFormField(
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
                    )),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        child: _image == null
                            ? null
                            : Image.file(
                                File(_image),
                                scale: 1,
                              ),
                      ),
                    ],
                  ),
                ))
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
