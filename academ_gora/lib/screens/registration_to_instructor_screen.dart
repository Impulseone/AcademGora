import 'package:academ_gora/screens/helpers_widgets/date_widget.dart';
import 'package:academ_gora/screens/helpers_widgets/select_kind_of_sport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;

class RegistrationToInstructorScreen extends StatefulWidget {
  @override
  _RegistrationToInstructorScreenState createState() =>
      _RegistrationToInstructorScreenState();
}

class _RegistrationToInstructorScreenState
    extends State<RegistrationToInstructorScreen> {
  int _kindOfSportSelected = -1;
  DateTime _selectedDate;

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
          SelectKindOfSportWidget(kindOfSportSelected: _kindOfSportSelected),
          _horizontalDivider(),
          DateWidget(_selectedDate),
          _horizontalDivider(),
          _timeWidget(),
          _warningText(),
          _continueButton(),
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

  Widget _timeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeNameWidget(),
        _timeField(50, 10),
        Text("-"),
        _timeField(10, 0)
      ],
    );
  }

  Widget _timeNameWidget() {
    return Row(
      children: [
        Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 10),
            child: Image.asset("assets/registration_to_instructor/4_e4.png")),
        Container(
            margin: EdgeInsets.only(right: 8),
            child: Text(
              "ВРЕМЯ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _timeField(double leftMargin, double rightMargin) {
    return Container(
      width: 80,
      height: 30,
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }


  Widget _warningText() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          "Укажите конкретное время или желаемый интервал для начала занятия",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.lightBlue),
        ));
  }



  Widget _continueButton() {
    return Container(
      width: 300.0,
      height: 60,
      margin: EdgeInsets.only(top: 25),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
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
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _selectCoachButton() {
    return Container(
      width: 300.0,
      height: 60,
      margin: EdgeInsets.only(top: 15),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
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
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
