import 'package:academ_gora/controller/firebase_requests_controller.dart';
import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/model/workout.dart';
import 'package:academ_gora/screens/account/helpers_widgets/workout_widget.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/extension.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UserAccountScreen extends StatefulWidget {
  @override
  UserAccountScreenState createState() => UserAccountScreenState();
}

class UserAccountScreenState extends State<UserAccountScreen> {
  List<Workout> workouts = [];
  FirebaseRequestsController _firebaseController = FirebaseRequestsController();

  @override
  Widget build(BuildContext context) {
    _getAllWorkouts();
    return Scaffold(
        body: Container(
      decoration: screenDecoration("assets/account/0_bg.png"),
      child: Column(
        children: [
          _topAccountInfo(),
          _workoutsTitle(),
          _workoutsList(),
          _backToMainScreenButton()
        ],
      ),
    ));
  }

  Widget _topAccountInfo() {
    return Container(
        margin: EdgeInsets.only(top: screenHeight * 0.07, right: 10),
        child: Column(
          children: [_accountTextWidget(), _phoneTextWidget(), _logoutButton()],
        ));
  }

  Widget _accountTextWidget() {
    return Container(
        alignment: Alignment.topRight,
        child: Text(
          "Личный кабинет",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ));
  }

  Widget _phoneTextWidget() {
    return Container(
        margin: EdgeInsets.only(top: 6),
        alignment: Alignment.topRight,
        child: Text(
          FirebaseAuth.instance.currentUser.phoneNumber,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Widget _logoutButton() {
    return GestureDetector(
        onTap: _openAuthScreen,
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "ВЫЙТИ",
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 20,
                    width: 20,
                    child: Image.asset("assets/account/e1.png"))
              ],
            )));
  }

  Widget _backToMainScreenButton() {
    return GestureDetector(
        onTap: _openMainScreen,
        child: Container(
          alignment: Alignment.center,
          width: screenWidth * 0.5,
          height: screenHeight * 0.07,
          margin: EdgeInsets.only(top: screenHeight * 0.01),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(26))),
          child: Text(
            "НА ГЛАВНУЮ",
            style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  void _openAuthScreen() async {
    await FirebaseAuthUi.instance().logout().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
    });
  }

  void _openMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
  }

  Widget _workoutsTitle() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 20, bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          "мои занятия",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ));
  }

  Widget _workoutsList() {
    return Container(
      height: screenHeight * 0.6,
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WorkoutWidget(
                    workout: workouts[index], userAccountScreenState: this),
                index != workouts.length - 1
                    ? Container(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.keyboard_arrow_down),
                      )
                    : Container()
              ],
            ));
          }),
    );
  }

  void _getAllWorkouts() async {
    await UserRole.getUserRole().then((value) => {
          _firebaseController
              .get("$value/${FirebaseAuth.instance.currentUser.uid}/Занятия")
              .then((value) {
            if (value == null && workouts.length != 0) {
              setState(() {
                workouts = [];
              });
            }
            if (value != null) {
              Map<dynamic, dynamic> workoutDataMap = value;
              List<Workout> workoutsFromDb = [];
              workoutDataMap.forEach((key, value) {
                if (_compareWorkoutDates(value["Дата"]))
                  workoutsFromDb.add(Workout.fromJson(value));
                else
                  _deleteWorkout(key);
              });
              Function eq = const ListEquality().equals;
              if (!eq(workouts, workoutsFromDb)) {
                setState(() {
                  workouts = workoutsFromDb;
                });
              }
            }
          })
        });
  }

  bool _compareWorkoutDates(String workoutDate) {
    String formattedDate =
        "${workoutDate.substring(4, 8)}-${workoutDate.substring(2, 4)}-${workoutDate.substring(0, 2)}";
    DateTime workoutDateTime = DateTime.parse(formattedDate);
    DateTime now = DateTime.now();
    if (workoutDateTime.year >= now.year &&
        workoutDateTime.day >= now.day &&
        workoutDateTime.month >= now.month) {
      return true;
    } else
      return false;
  }

  void _deleteWorkout(String workoutId) {
    _firebaseController.delete(
        "Пользователи/${FirebaseAuth.instance.currentUser.uid}/Занятия/$workoutId");
  }
}
