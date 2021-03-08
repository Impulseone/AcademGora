import 'package:academ_gora/screens/account/helpers_widgets/lesson_widget.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class UserAccountScreen extends StatefulWidget {
  @override
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  int itemCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/account/0_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _topAccountInfo(),
          _lessonsTitle(),
          Container(
            height: 420,
            margin: EdgeInsets.only(right: 20),
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LessonWidget(),
                          index != itemCount - 1
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.keyboard_arrow_down),
                                )
                              : Container()
                        ],
                      ));
                }),
          )
        ],
      ),
    ));
  }

  Widget _topAccountInfo() {
    return Container(
        margin: EdgeInsets.only(top: 50, right: 10),
        child: Column(
          children: [_accountTextWidget(), _phoneTextWidget(), _exitButton()],
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
          "+7 999 333 38 42",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  Widget _exitButton() {
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

  void _openAuthScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
  }

  Widget _lessonsTitle() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 20, bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          "мои занятия",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ));
  }
}
