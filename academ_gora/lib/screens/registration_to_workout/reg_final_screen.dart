import 'package:academ_gora/model/workout.dart';
import 'package:academ_gora/screens/account/user_account_screen.dart';
import 'package:academ_gora/screens/extension.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class RegistrationFinalScreen extends StatefulWidget {
  @override
  _RegistrationFinalScreenState createState() =>
      _RegistrationFinalScreenState();
}

class _RegistrationFinalScreenState extends State<RegistrationFinalScreen> {

  WorkoutSingleton workoutSingleton = WorkoutSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: screenDecoration("assets/reg_final/0_bg.png"),
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.1),
              child: Column(
                children: [
                  _textWidget("Запись оформлена\n"),
                  _textWidget(
                      "Ждем вас на занятии\n${_parseDate(workoutSingleton.date)} в ${workoutSingleton.from}\nв СК \"Академический\"\n"),
                  _textWidget(
                      "Информация о занятии\nдоступна в личном\nкабинете"),
                  _buttonWidget("В личный кабинет", screenHeight * 0.3),
                  _buttonWidget("На главную", 20),
                ],
              ),
            )));
  }

  String _parseDate(String date) {
    return "${date.substring(0, 2)}.${date.substring(2, 4)}.${date.substring(4, 8)}";
  }

  Widget _textWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buttonWidget(String text, double marginTop) {
    return Container(
      width: 280.0,
      height: screenHeight * 0.09,
      margin: EdgeInsets.only(top: marginTop),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: text == "В личный кабинет"
                ? () => _openAccount()
                : () => _openMain(),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
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

  void _openAccount() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => UserAccountScreen()));
  }

  void _openMain() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
  }
}
