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
  bool selectCategoryButton = false;

  initState() {
    super.initState();
    _rule = Rule.All;
  }

  int? _selectedIndex;
  List<String> _options = [
    'language',
    'journey',
    'living',
    'living',
    'living',
    'living'
  ];

  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(color: Colors.black, fontSize: 12)),
        elevation: 2,
        pressElevation: 5,
        backgroundColor: Colors.orange[50],
        selectedColor: Colors.orange[300],
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: choiceChip));
    }

    return Wrap(
      // This next line does the trick.
      spacing: 6,
      direction: Axis.horizontal,
      children: chips,
    );
  }

  addGroup() {
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomEventDialog());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                          // Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Row(
                          //       children: [
                          //         Text("style",
                          //             style: TextStyle(
                          //                 color: Colors.black, fontSize: 18)),
                          //         Padding(padding: EdgeInsets.only(top: 10)),
                          //         Container(
                          //             width: 200,
                          //             height: 100,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: Colors.grey[400]!)),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   width: 30,
                          //                   height: 100,
                          //                   padding: EdgeInsets.only(
                          //                       left: 10, top: 10),
                          //                   child: Column(children: [
                          //                     Image.asset(
                          //                       'assets/icon/padlock.png',
                          //                       width: 30,
                          //                       height: 35,
                          //                     ),
                          //                     Radio(
                          //                         value: Rule.All,
                          //                         groupValue: _rule,
                          //                         onChanged: (Rule? value) {
                          //                           setState(() {
                          //                             _rule = value;
                          //                             print(value.toString());
                          //                           });
                          //                         }),
                          //                   ]),
                          //                 ),
                          //                 Expanded(
                          //                   flex: 1,
                          //                   child: Container(
                          //                       height: 100,
                          //                       child: VerticalDivider(
                          //                           color: Colors.grey[900])),
                          //                 ),
                          //                 Padding(
                          //                     padding:
                          //                         EdgeInsets.only(left: 10)),
                          //                 Container(
                          //                   width: 30,
                          //                   height: 100,
                          //                   padding: EdgeInsets.only(
                          //                       left: 10, top: 10),
                          //                   child: Column(children: [
                          //                     Image.asset(
                          //                       'assets/icon/unlock.png',
                          //                       width: 30,
                          //                       height: 35,
                          //                     ),
                          //                     // Text("Invite",
                          //                     //     style: TextStyle(
                          //                     //         color: Colors.black,
                          //                     //         fontSize: 22)),
                          //                     Radio(
                          //                         value: Rule.Invite,
                          //                         groupValue: _rule,
                          //                         onChanged: (Rule? value) {
                          //                           setState(() {
                          //                             _rule = value;
                          //                             print(_rule.toString());
                          //                           });
                          //                         }),
                          //                   ]),
                          //                 ),
                          //               ],
                          //             )),
                          //         Padding(padding: EdgeInsets.only(top: 10)),
                          //       ],
                          //     )),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: 150,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.orange[600]!),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text("Page?",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20))),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: width * 0.5,
                                    height: 90,
                                    child: Row(
                                      children: [
                                        Container(
                                            width: width * 0.2,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/icon/padlock.png',
                                                  width: 30,
                                                  height: 35,
                                                ),
                                                Radio(
                                                    value: Rule.All,
                                                    groupValue: _rule,
                                                    onChanged: (Rule? value) {
                                                      setState(() {
                                                        _rule = value;
                                                        print(value.toString());
                                                      });
                                                    }),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: 100,
                                              child: VerticalDivider(
                                                  color: Colors.grey[900])),
                                        ),
                                        Container(
                                            width: width * 0.2,
                                            height: 90,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/icon/unlock.png',
                                                  width: 30,
                                                  height: 35,
                                                ),
                                                Radio(
                                                    value: Rule.Invite,
                                                    groupValue: _rule,
                                                    onChanged: (Rule? value) {
                                                      setState(() {
                                                        _rule = value;
                                                        print(value.toString());
                                                      });
                                                    }),
                                              ],
                                            ))
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1.5,
                            color: Colors.grey[900],
                          ),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.orange[600]!),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text("Category",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Container(
                                          height: 130,
                                          child: _buildChips(),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          )
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
