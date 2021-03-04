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

  Map<DateTime, int> selectedDates = {};

  @override
  Widget build(BuildContext context) {
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
              height: 360,
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
        margin: EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_backButton(), _continueButton()],
        ));
  }

  Widget _backButton() {
    return Container(
      child: Icon(
        Icons.chevron_left,
        color: Colors.blue,
        size: 50,
      ),
    );
  }

  Widget _continueButton() {
    return Container(
      width: 250.0,
      height: 55,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: _continueButtonBackgroundColor(),
        child: InkWell(
            onTap: null,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ПРОДОЛЖИТЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _continueButtonTextColor(),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Color _continueButtonBackgroundColor() {
    return selectedDates.isEmpty ? Colors.white : Colors.blue;
  }

  Color _continueButtonTextColor() {
    return selectedDates.isEmpty ? Colors.grey : Colors.white;
  }
}
