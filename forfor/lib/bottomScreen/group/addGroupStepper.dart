import 'package:flutter/material.dart';
import 'package:forfor/widget/my_colors.dart';
import 'package:forfor/widget/my_text.dart';

class StepperGroupAdd extends StatefulWidget {
  @override
  _StepperGroupAddState createState() => _StepperGroupAddState();
}

class _StepperGroupAddState extends State<StepperGroupAdd> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
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
              Padding(padding: EdgeInsets.only(top: 40)),
              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text(
                        'Required',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Group title'),
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
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
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
                      title: new Text('rule',
                          style: TextStyle(color: Colors.black, fontSize: 22)),
                      content: Column(
                        children: <Widget>[
                          Container(
                              height: 300, width: 250, child: Text("!11")),
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
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
