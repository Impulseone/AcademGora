import 'package:flutter/material.dart';

import '../main_screen.dart';

class CallUsScreen extends StatefulWidget {
  @override
  _CallUsScreenState createState() => _CallUsScreenState();
}

class _CallUsScreenState extends State<CallUsScreen> {
  double _screenWidth;
  double _screenHeight;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: _screenHeight,
      width: _screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/info_screens/call_us/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _callToAdministrationTitle(),
          _callNumberButton(),
          _whatsAppButton(),
          _mailButton(),
          _logo(),
          _openMainScreenButton()
        ],
      ),
    ));
  }

  Widget _callToAdministrationTitle() {
    return Container(
      margin: EdgeInsets.only(top: _screenHeight * 0.1),
      child: Text("СВЯЗАТЬСЯ С АДМИНИСТРАЦИЕЙ"),
    );
  }

  Widget _callNumberButton() {
    return Container(
      height: _screenHeight * 0.07,
      width: _screenWidth * 0.8,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: _screenWidth * 0.1),
      margin: EdgeInsets.only(top: _screenHeight * 0.07),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage("assets/info_screens/call_us/1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        "89025101513",
        style: TextStyle(
            fontSize: _screenHeight * 0.04,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _whatsAppButton() {
    return Container(
      height: _screenHeight * 0.07,
      width: _screenWidth * 0.8,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: _screenWidth * 0.15),
      margin: EdgeInsets.only(top: _screenHeight * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage("assets/info_screens/call_us/2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        "НАПИСАТЬ",
        style: TextStyle(
            fontSize: _screenHeight * 0.04,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _mailButton() {
    return Container(
      height: _screenHeight * 0.07,
      width: _screenWidth * 0.8,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: _screenWidth * 0.05),
      margin: EdgeInsets.only(top: _screenHeight * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage("assets/info_screens/call_us/3.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        "Progress077@yandex.ru",
        style: TextStyle(
            fontSize: _screenHeight * 0.025,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _logo() {
    return Container(
      margin: EdgeInsets.only(top: _screenHeight * 0.06),
      height: _screenHeight * 0.25,
      width: _screenWidth * 0.35,
      child: Image.asset("assets/info_screens/call_us/4.png"),
    );
  }

  Widget _openMainScreenButton() {
    return Container(
      width: _screenWidth * 0.63,
      height: _screenHeight * 0.08,
      margin: EdgeInsets.only(top: 30),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: () => _openMainScreen(),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НА ГЛАВНУЮ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }

  void _openMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
  }
}
