import 'package:academ_gora/screens/instructor_profile/instructor_info.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class InstructorProfileScreen extends StatelessWidget {
  final String _instructorName;

  const InstructorProfileScreen(this._instructorName,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/instructor_profile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _instructorPhoto(),
          _instructorNameWidget(),
          _instructorInfoWidget(),
          _instagramIcon(),
          _instagramNickname(),
          _telegramIcon(),
          _telegramNumber(),
          _backButtons(context)
        ],
      ),
    ));
  }

  Widget _instructorPhoto() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.07),
      width: screenWidth * 0.65,
      height: screenHeight * 0.25,
      child: Image.asset("assets/instructor_profile/1.png"),
    );
  }

  Widget _instructorNameWidget() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          _instructorName.split("\n").length > 1
              ? _instructorName.split("\n")[0] +
                  " " +
                  _instructorName.split("\n")[1]
              : _instructorName,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }

  Widget _instructorInfoWidget() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(
          InstructorInfo.getInstructorInfo(),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Widget _instagramIcon() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 20,
      height: 20,
      child: Image.asset("assets/instructor_profile/2.png"),
    );
  }

  Widget _instagramNickname() {
    return Text(
      "Alexsnowboard38",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _telegramIcon() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 20,
      height: 20,
      child: Image.asset("assets/instructor_profile/3.png"),
    );
  }

  Widget _telegramNumber() {
    return Text(
      "+79503884278",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _backButtons(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_backButton(context), _backToMainScreenButton(context)],
        ));
  }

  Widget _backButton(BuildContext context) {
    return ExpandTapWidget(
      tapPadding: EdgeInsets.all(50),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 20,
          height: 20,
          child: Image.asset("assets/instructor_profile/4.png"),
        ));
  }

  Widget _backToMainScreenButton(BuildContext context) {
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.05,
      margin: EdgeInsets.only(left: 20),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => MainScreen()),
                      (route) => false)
                },
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НА ГЛАВНУЮ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
