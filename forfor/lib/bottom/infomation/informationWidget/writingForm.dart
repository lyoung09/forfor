import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

class WritingWidget extends StatefulWidget {
  @override
  _WritingWidgetState createState() => _WritingWidgetState();
}

class _WritingWidgetState extends State<WritingWidget> {
  ZefyrController _controller = ZefyrController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Container(
          width: 500,
          height: 500,
          child: Column(
            children: [
              ZefyrToolbar.basic(controller: _controller),
              Expanded(
                child: ZefyrEditor(
                  controller: _controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
