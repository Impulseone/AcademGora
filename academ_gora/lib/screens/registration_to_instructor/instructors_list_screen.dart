import 'package:academ_gora/model/reg_to_instructor_data.dart';
import 'package:academ_gora/screens/registration_to_instructor/registration_parameters_screen.dart';
import 'package:flutter/material.dart';

import 'helpers_widgets/instructor_list/instructor_widget.dart';

class InstructorsListScreen extends StatefulWidget {
  @override
  InstructorsListScreenState createState() => InstructorsListScreenState();
}

class InstructorsListScreenState extends State<InstructorsListScreen> {
  final items = [
    "Ярославский Александр",
    "Крюкова Ольга",
    "Карманова Евгения",
    "Трофимов Павел"
  ];

  RegToInstructorData regToInstructorData;

  double _screenHeight;
  double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/registration_to_instructor/1_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            Container(
              height: _screenHeight * 0.72,
              margin: EdgeInsets.only(top: 50, left: 15, right: 15),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _instructorWidget('${items[index]}', index);
                },
              ),
            ),
            _buttons()
          ])),
    );
  }

  Widget _instructorWidget(String text, int index) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
            top: index == 0
                ? BorderSide(width: 0.5, color: Colors.grey)
                : BorderSide(color: Colors.transparent),
          ),
        ),
        child: Container(child: InstructorWidget(text, this)));
  }

  Widget _buttons() {
    return Container(
        margin: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_backButton(), _continueButton()],
        ));
  }

  Widget _backButton() {
    return GestureDetector(
        onTap: _onBackPressed,
        child: Container(
          child: Icon(
            Icons.chevron_left,
            color: Colors.blue,
            size: 50,
          ),
        ));
  }

  Widget _continueButton() {
    return Container(
      width: 200,
      height: 55,
      margin: EdgeInsets.only(right: 20),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: _continueButtonBackgroundColor(),
        child: InkWell(
            onTap:
                regToInstructorData == null ? null : _openRegParametersScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ПРОДОЛЖИТЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _continueButtonTextColor(),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Color _continueButtonBackgroundColor() {
    return regToInstructorData == null ? Colors.white : Colors.blue;
  }

  Color _continueButtonTextColor() {
    return regToInstructorData == null ? Colors.grey : Colors.white;
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  void _openRegParametersScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => RegistrationParametersScreen()));
  }
}
