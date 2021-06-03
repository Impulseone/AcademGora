import 'package:academ_gora/model/instructor.dart';
import 'package:academ_gora/model/reg_to_instructor_data.dart';
import 'package:academ_gora/model/workout.dart';
import 'package:collection/equality.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'helpers_widgets/instructor_list/instructor_widget.dart';
import 'registration_parameters_screen.dart';

class InstructorsListScreen extends StatefulWidget {
  @override
  InstructorsListScreenState createState() => InstructorsListScreenState();
}

class InstructorsListScreenState extends State<InstructorsListScreen> {
  List<Instructor> instructors = [];
  final dbRef = FirebaseDatabase.instance.reference();

  RegToInstructorData regToInstructorData;
  WorkoutSingleton _workoutSingleton = WorkoutSingleton();

  double _screenHeight;

  @override
  Widget build(BuildContext context) {
    _getAllInstructorsOfSelectedSport();
    _screenHeight = MediaQuery.of(context).size.height;
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
                itemCount: instructors.length,
                itemBuilder: (context, index) {
                  return _instructorWidget(instructors[index], index);
                },
              ),
            ),
            _buttons()
          ])),
    );
  }

  Widget _instructorWidget(Instructor instructor, int index) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
            top: index == 0
                ? BorderSide(width: 0.5, color: Colors.grey)
                : BorderSide(color: Colors.transparent),
          ),
        ),
        child: Container(child: InstructorWidget(instructor, this)));
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
    WorkoutSingleton workoutSingleton = WorkoutSingleton();
    workoutSingleton.instructorName = regToInstructorData.instructorName;
    workoutSingleton.from = regToInstructorData.time;
    if (workoutSingleton.date == null) workoutSingleton.date = DateFormat('ddMMyyyy').format(regToInstructorData.date);
    if (workoutSingleton.id == null)
      workoutSingleton.id =
          regToInstructorData.date.millisecondsSinceEpoch.toString();
    workoutSingleton.instructorPhoneNumber = regToInstructorData.phoneNumber;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => RegistrationParametersScreen()));
  }

  void _getAllInstructorsOfSelectedSport() async {
    dbRef.child("Инструкторы").once().then((value) {
      if (value.value != null) {
        Map<dynamic, dynamic> instructorDataMap =
            value.value as Map<dynamic, dynamic>;
        List<Instructor> instructorsFromDb = [];

        instructorDataMap.forEach((key, value) {
          if (value["Вид спорта"] == _workoutSingleton.sportType) {
            Instructor instructor = Instructor.fromJson(value);
            instructor.id = key;
            instructorsFromDb.add(instructor);
          }
        });
        Function eq = const ListEquality().equals;
        if (!eq(instructors, instructorsFromDb)) {
          setState(() {
            instructors = instructorsFromDb;
          });
        }
      }
    });
  }
}
