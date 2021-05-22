import 'package:academ_gora/screens/account/instructor_account/set_workout_time_screen.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:flutter/material.dart';

class InstructorAccountScreen extends StatefulWidget {
  const InstructorAccountScreen({Key key}) : super(key: key);

  @override
  _InstructorAccountScreenState createState() =>
      _InstructorAccountScreenState();
}

class _InstructorAccountScreenState extends State<InstructorAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/instructor_profile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          RaisedButton(
              child: Text("На главную"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (route) => false);
              }),
          RaisedButton(
              child: Text("Редактировать профиль"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => SetWorkoutTimeScreen()),
                    (route) => false);
              }),
          RaisedButton(
              child: Text("Выйти"),
              onPressed: () async {
                await FirebaseAuthUi.instance().logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => AuthScreen()),
                      (route) => false);
                });
              }),
        ],
      ),
    ));
  }
}
