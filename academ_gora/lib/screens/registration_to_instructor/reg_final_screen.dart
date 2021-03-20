import 'package:academ_gora/screens/account/user_account_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:flutter/material.dart';

class RegistrationFinalScreen extends StatefulWidget {
  @override
  _RegistrationFinalScreenState createState() =>
      _RegistrationFinalScreenState();
}

class _RegistrationFinalScreenState extends State<RegistrationFinalScreen> {
  double _screenHeight;
  double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/reg_final/0_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: _screenHeight * 0.1),
              child: Column(
                children: [
                  _textWidget("Запись оформлена\n"),
                  _textWidget(
                      "Ждем вас на занятии\n22.02.2021 в 15:30\nв СК \"Академический\"\n"),
                  _textWidget(
                      "Информация о занятии\nдоступна в личном\nкабинете"),
                  _buttonWidget("В личный кабинет", _screenHeight * 0.3),
                  _buttonWidget("На главную", 20),
                ],
              ),
            )));
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
      height: _screenHeight * 0.09,
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
