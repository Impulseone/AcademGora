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
          image: AssetImage("assets/instructor_profile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _logoutButton(),
          _myRegistrationsTitle(),
          _changeRegistrationTimeButton(),
          _redactProfileButton(),
          _backToMainButton()
        ],
      ),
    ));
  }

  Widget _myRegistrationsTitle() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          "Мои записи",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget _changeRegistrationTimeButton() {
    return Container(
      width: _screenWidth * 0.75,
      height: _screenHeight * 0.09,
      margin: EdgeInsets.only(top: 18),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openRedactProfileScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ОТКРЫТЬ/ИЗМЕНИТЬ\n ДОСТУПНОЕ ВРЕМЯ ЗАПИСИ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _redactProfileButton() {
    return Container(
      width: _screenWidth * 0.7,
      height: _screenHeight * 0.07,
      margin: EdgeInsets.only(top: 18),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openRedactProfileScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "РЕДАКТИРОВАТЬ ПРОФИЛЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _backToMainButton() {
    return Container(
      width: _screenWidth * 0.5,
      height: _screenHeight * 0.07,
      margin: EdgeInsets.only(top: 18),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openMainScreen,
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
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _logoutButton() {
    return GestureDetector(
        onTap: _openAuthScreen,
        child: Container(
            margin: EdgeInsets.only(top: 40, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "ВЫЙТИ",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 20,
                    width: 20,
                    child: Icon(Icons.logout))
              ],
            )));
  }

  void _openAuthScreen() async {
    await FirebaseAuthUi.instance().logout().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
    });
  }

  void _openRedactProfileScreen() {

  }

  void _openMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false);
  }
}
