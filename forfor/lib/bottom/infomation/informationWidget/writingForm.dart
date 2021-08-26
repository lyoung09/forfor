import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WritingWidget extends StatefulWidget {
  final FocusNode descriptionFocusNode;

  const WritingWidget({
    required this.descriptionFocusNode,
  });

  @override
  _WritingWidgetState createState() => _WritingWidgetState();
}

class _WritingWidgetState extends State<WritingWidget> {
  final _WritingWidgetKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _WritingWidgetKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.0),
                Text(
                  'Description',
                  style: TextStyle(
                    //color: CustomColors.firebaseGrey,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                // TextFormField(
                //     maxLines: 10,
                //     controller: _descriptionController,
                //     focusNode: widget.descriptionFocusNode,
                //     keyboardType: TextInputType.text,
                //     validator: (value) => Validator.validateField(
                //           value: value,
                //         ),
                //     decoration: InputDecoration(
                //       hintText: 'Enter your note description',
                //     )),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.descriptionFocusNode.unfocus();

                      if (_WritingWidgetKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await FirebaseFirestore.instance
                            .collection("posting")
                            .doc()
                            .set({
                          'description': _descriptionController.text,
                        });

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'ADD ITEM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          //color: CustomColors.firebaseGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
