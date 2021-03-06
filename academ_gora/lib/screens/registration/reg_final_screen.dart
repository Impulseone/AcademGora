import 'package:flutter/material.dart';

class RegistrationFinalScreen extends StatefulWidget {
  @override
  _RegistrationFinalScreenState createState() =>
      _RegistrationFinalScreenState();
}

class _RegistrationFinalScreenState extends State<RegistrationFinalScreen> {
  @override
  Widget build(BuildContext context) {
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
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  _textWidget("Запись оформлена\n\n"),
                  _textWidget(
                      "Ждем вас на занятии\n22.02.2021 в 15:30\nв СК \"Академический\"\n\n"),
                  _textWidget("Информация о занятии\nдоступна в личном\nкабинете"),
                  _buttonWidget("В личный кабинет", 220),
                  _buttonWidget("На главную", 20),
                ],
              ),
            )));
  }
  Widget _textWidget(String text){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buttonWidget(String text, double marginTop) {
    return Container(
      width: 280.0,
      height: 55,
      margin: EdgeInsets.only(top: marginTop),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: null,
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
}
