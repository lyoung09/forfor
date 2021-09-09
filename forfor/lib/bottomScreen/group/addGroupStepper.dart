import 'package:flutter/material.dart';
import 'package:forfor/widget/custom_dialog.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';

class StepperGroupAdd extends StatefulWidget {
  @override
  _StepperGroupAddState createState() => _StepperGroupAddState();
}

class _StepperGroupAddState extends State<StepperGroupAdd> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  Rule? _rule;

  initState() {
    super.initState();
    _rule = Rule.All;
  }

  Widget selectCategory() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab1",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.lightGreen[500],
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "FRIENDS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab2",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.yellow[600],
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "GROUPS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab3",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.purple[400],
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "NEARBY",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab4",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.blue[400],
                      child: Icon(
                        Icons.near_me,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "MOMENT",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab5",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.indigo[300],
                      child: Icon(
                        Icons.crop_original,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "ALBUMS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab6",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.green[500],
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "LIKES",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab7",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.lightGreen[400],
                      child: Icon(
                        Icons.subject,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "ARTICLES",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "fab8",
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.orange[300],
                      child: Icon(
                        Icons.textsms,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Container(height: 5),
                    Text(
                      "REVIEWS",
                      style: MyText.caption(context)!
                          .copyWith(color: MyColors.grey_40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addGroup() {
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomEventDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[400],
        title:
            Text("그룹 만들기", style: TextStyle(color: Colors.black, fontSize: 32)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: 30,
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [],
      ),
      body: Theme(
        data: ThemeData(
            buttonColor: Colors.grey[400],
            accentColor: Colors.orange,
            primarySwatch: Colors.orange,
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.grey[400], fontSize: 22),
              bodyText2: TextStyle(color: Colors.black, fontSize: 22),
            ),
            colorScheme: ColorScheme.light(primary: Colors.orange)),
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 32)),
              Text("make language group",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Padding(padding: EdgeInsets.only(top: 25)),
              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  controlsBuilder: (BuildContext context,
                      {VoidCallback? onStepContinue,
                      VoidCallback? onStepCancel}) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: _currentStep == 2
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: addGroup,
                                      child: Text("Add group"),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          elevation: 1),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20)),
                                  Container(
                                    width: 130,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: cancel,
                                      child: Text("cancel"),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          elevation: 1),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: cancel,
                                      child: Text("cancel"),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          elevation: 1),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Container(
                                    width: 80,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: continued,
                                      child: Text("next"),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          elevation: 1),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                  steps: <Step>[
                    Step(
                      title: new Text(
                        'Required',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      subtitle: _currentStep == 0
                          ? new Text(
                              "At least one image and name",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                          : Text(""),
                      content: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 200,
                                  height: 120,
                                  child: Icon(Icons.add),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Group title',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.grey[900]!, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.grey[900]!, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Extra',
                          style: TextStyle(color: Colors.black, fontSize: 22)),
                      subtitle: _currentStep == 1
                          ? new Text(
                              "You can add description.\n if u dont want to add,just skip",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                          : Text(""),
                      content: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 20)),
                          TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "introduce your group",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('choice',
                          style: TextStyle(color: Colors.black, fontSize: 22)),
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                elevation: 3,
                                child: Column(
                                  children: [
                                    Text("Join Group style",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 22)),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/icon/padlock.png',
                                                  width: 35,
                                                  height: 35,
                                                ),
                                                Text("All",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22)),
                                                Radio(
                                                    value: Rule.All,
                                                    groupValue: _rule,
                                                    onChanged: (Rule? value) {
                                                      setState(() {
                                                        _rule = value;
                                                        print(value.toString());
                                                      });
                                                    }),
                                              ]),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10)),
                                        Container(
                                          width: 120,
                                          height: 120,
                                          padding: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(children: [
                                            Image.asset(
                                              'assets/icon/unlock.png',
                                              width: 35,
                                              height: 35,
                                            ),
                                            Text("Invite",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22)),
                                            Radio(
                                                value: Rule.Invite,
                                                groupValue: _rule,
                                                onChanged: (Rule? value) {
                                                  setState(() {
                                                    _rule = value;
                                                    print(_rule.toString());
                                                  });
                                                }),
                                          ]),
                                        ),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                  ],
                                )),
                          ),
                          // Container(height: 220, child: selectCategory())
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2
        ? setState(() {
            _currentStep += 1;
            FocusScope.of(context).requestFocus(new FocusNode());
          })
        : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

enum Rule { All, Invite }
