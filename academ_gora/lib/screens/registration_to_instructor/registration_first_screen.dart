import 'package:academ_gora/model/workout.dart';
import 'package:academ_gora/screens/registration_to_instructor/registration_parameters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'helpers_widgets/horizontal_divider.dart';
import 'helpers_widgets/reg_to_instructor/date_widget.dart';
import 'helpers_widgets/reg_to_instructor/select_kind_of_sport.dart';
import 'helpers_widgets/reg_to_instructor/time_widget.dart';
import 'instructors_list_screen.dart';

import 'package:intl/intl.dart';

class RegistrationFirstScreen extends StatefulWidget {
  @override
  RegistrationFirstScreenState createState() => RegistrationFirstScreenState();
}

class RegistrationFirstScreenState extends State<RegistrationFirstScreen> {
  int kindOfSport = -1;
  DateTime selectedDate;
  String _fromTime;
  String _toTime;
  double _screenHeight;
  double _screenWidth;

  WorkoutSingleton workoutSingleton = WorkoutSingleton();

  @override
  void initState() {
    super.initState();
    workoutSingleton.clear();
  }

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
      child: Column(
        children: [
          SelectKindOfSportWidget(this, kindOfSport),
          horizontalDivider(20, 20, 20, 20),
          DateWidget(this, selectedDate),
          horizontalDivider(20, 20, 20, 20),
          TimeWidget(_fromTime, _toTime),
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

  Widget _warningText() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.02, left: 10, right: 10),
        child: Text(
          "Укажите конкретное время или желаемый интервал для начала занятия",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.lightBlue),
        ));
  }

  Widget _continueButton() {
    return Container(
      width: _screenWidth * 0.75,
      height: _screenHeight * 0.08,
      margin: EdgeInsets.only(top: 18),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: _continueButtonBackgroundColor(),
        child: InkWell(
            onTap: (kindOfSport != -1 && selectedDate != null)
                ? _openNextScreen
                : null,
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

  void _openNextScreen() {
    final DateTime now = selectedDate;
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formattedDate = formatter.format(now);
    if (workoutSingleton.date == null) workoutSingleton.date = formattedDate;

    workoutSingleton.id = selectedDate.millisecondsSinceEpoch.toString();

    String sportType = kindOfSport == 0 ? SportType.skiing : SportType.snowboard;
    workoutSingleton.sportType = sportType;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => InstructorsListScreen()));
  }

  Color _continueButtonBackgroundColor() {
    if (kindOfSport != -1 && selectedDate != null) {
      return Colors.blue;
    } else
      return Colors.white;
  }

  Color _continueButtonTextColor() {
    if (kindOfSport != -1 && selectedDate != null) {
      return Colors.white;
    } else
      return Colors.grey;
  }

  Widget _selectCoachButton() {
    return Container(
      width: _screenWidth * 0.75,
      height: _screenHeight * 0.08,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          border: Border.all(color: _selectCoachButtonColor()),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.transparent,
        child: InkWell(
            onTap: (kindOfSport != -1 && selectedDate == null)
                ? _openInstructorsListScreen
                : null,
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

  void _openInstructorsListScreen() {
    workoutSingleton.sportType = kindOfSport == 0 ? SportType.skiing : SportType.snowboard;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => InstructorsListScreen()));
  }

  Widget _selectCoachText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: _selectCoachButtonColor(),
          fontSize: 16,
          fontWeight: FontWeight.normal),
    );
  }

  Color _selectCoachButtonColor() {
    if (kindOfSport == -1)
      return Colors.grey;
    else
      return selectedDate == null ? Colors.blue : Colors.grey;
  }
}
