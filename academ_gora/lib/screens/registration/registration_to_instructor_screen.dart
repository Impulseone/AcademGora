import 'package:academ_gora/screens/registration/helpers_widgets/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'helpers_widgets/date_widget.dart';
import 'helpers_widgets/select_kind_of_sport.dart';

class RegistrationToInstructorScreen extends StatefulWidget {
  @override
  RegistrationToInstructorScreenState createState() =>
      RegistrationToInstructorScreenState();
}

class RegistrationToInstructorScreenState
    extends State<RegistrationToInstructorScreen> {
  int kindOfSportSelected = -1;
  DateTime selectedDate;
  String _firstCurrentlySelected;
  String _secondCurrentlySelected;

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
      child: Column(
        children: [
          SelectKindOfSportWidget(this, kindOfSportSelected),
          _horizontalDivider(),
          DateWidget(this, selectedDate),
          _horizontalDivider(),
          TimeWidget(_firstCurrentlySelected, _secondCurrentlySelected),
          _warningText(),
          _continueButton(),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("ИЛИ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey))),
          _selectCoachButton()
        ],
      ),
    ));
  }

  Widget _horizontalDivider() {
    return Container(
      color: Colors.grey,
      height: 1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
    );
  }

  Widget _warningText() {
    return Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Text(
          "Укажите конкретное время или желаемый интервал для начала занятия",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.lightBlue),
        ));
  }

  Widget _continueButton() {
    return Container(
      width: 280.0,
      height: 55,
      margin: EdgeInsets.only(top: 18),
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
    if (kindOfSportSelected != -1 && selectedDate != null) {
      return Colors.blue;
    } else
      return Colors.white;
  }

  Color _continueButtonTextColor() {
    if (kindOfSportSelected != -1 && selectedDate != null) {
      return Colors.white;
    } else
      return Colors.grey;
  }

  Widget _selectCoachButton() {
    return Container(
      width: 250.0,
      height: 55,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          border: Border.all(
              color: selectedDate == null ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.transparent,
        child: InkWell(
            onTap: null,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _selectCoachText("выбрать определенного"),
                    _selectCoachText("инструктора")
                  ]),
            )),
      ),
    );
  }

  Widget _selectCoachText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: selectedDate == null ? Colors.blue : Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal),
    );
  }
}
