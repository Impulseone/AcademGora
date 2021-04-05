import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/screens/account/helpers_widgets/lesson_widget.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserAccountScreen extends StatefulWidget {
  @override
  _UserAccountScreenState createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  int itemCount = 0;

  double _screenHeight;
  double _screenWidth;

  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _getAllWorkouts();
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
          _lessonsList(),
          _backToMainScreenButton()
        ],
      ),
    ));
  }

  Widget _topAccountInfo() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.07, right: 10),
        child: Column(
          children: [
            _accountTextWidget(),
            _phoneTextWidget(),
            _exitAndMainButtons()
          ],
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

  Widget _exitAndMainButtons() {
    return _logoutButton();
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _backToMainScreenButton() {
    return GestureDetector(
        onTap: _openMainScreen,
        child: Container(
          alignment: Alignment.center,
          width: _screenWidth * 0.5,
          height: _screenHeight * 0.07,
          margin: EdgeInsets.only(top: _screenHeight * 0.01),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(26))),
          child: Text(
            "НА ГЛАВНУЮ",
            style: TextStyle(
                color: Colors.white,
                fontSize: _screenHeight * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  void _openAuthScreen() {
    _signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
  }

  void _openMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
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

  Widget _lessonsList() {
    return Container(
      height: _screenHeight * 0.6,
      child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return Container(
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
    );
  }

  void _getAllWorkouts() async {
    await UserRole.getUserRole().then((value) => {
          dbRef
              .child("$value/${FirebaseAuth.instance.currentUser.uid}/Занятия")
              .once()
              .then((value) {
            if (value.value != null) {
              int workoutCount =
                  (value.value as Map<dynamic, dynamic>).keys.length;
              if (itemCount != workoutCount)
                setState(() {
                  itemCount = workoutCount;
                });
            }
          })
        });
  }
}
