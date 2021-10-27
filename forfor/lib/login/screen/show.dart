import 'package:flutter/material.dart';

import 'package:forfor/login/widget/button/signupButton/googlebutton.dart';
import 'package:forfor/login/widget/button/signupButton/kakaobutton.dart';
import 'package:get/get.dart';

import 'login_main.dart';

class MainLogin extends StatefulWidget {
  const MainLogin({Key? key}) : super(key: key);

  @override
  _MainLoginState createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  initState() {
    super.initState();
  }

  email() {
    Get.to(() => Login());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.yellow),
              )),
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
              )),
          Container(
            child: Divider(
              thickness: 2.5,
              color: Colors.grey[400],
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  15.0) //                 <--- border radius here
                              ),
                        ),
                        child: InkWell(
                          onTap: email,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icon/email.png",
                                  height: 25.0,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7.0)),

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Login()));

                                Text(
                                  'Email Login',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'nanumB'),
                                ),
                              ]),
                        )),
                    SizedBox(height: 15.0),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: width * 0.2,
                            ),
                            GoogleButton(),
                            SizedBox(
                              width: width * 0.15,
                            ),
                            KaKaoButton(),
                            SizedBox(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
