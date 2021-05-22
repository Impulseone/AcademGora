import 'package:academ_gora/controller/auth_controller.dart';
import 'package:academ_gora/screens/auth/helpers/login_form_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:flutter/services.dart';

import '../main_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String error;
  AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/auth/1_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder(
        future: _checkLoginState(),
        builder: (context, snapshot) {
          return _loginForm();
        },
      ),
    ));
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Text("СК \"АКАДЕМИЧЕСКИЙ\"",
                style: TextStyle(
                  fontSize: 20,
                ))),
        _getCodeButton(),
        Container(
          height: 150,
        )
      ],
    );
  }

  Widget _getCodeButton() {
    return GestureDetector(
        onTap: _processLogin,
        child: Container(
          margin: EdgeInsets.only(top: 12),
          width: 200,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Center(
              child: Text(
            "Вход",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
        ));
  }

  Future<FirebaseAuth.User> _checkLoginState() async {
    await Firebase.initializeApp();
    return FirebaseAuth.FirebaseAuth.instance.currentUser;
  }

  void _processLogin() async {
    FirebaseAuthUi.instance().launchAuth([AuthProvider.phone()]).then((fbUser) {
      _authController.saveUserRole(fbUser.phoneNumber);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
    }).catchError((e) {
      if (error is PlatformException) {
        setState(() {
          if (e.code == FirebaseAuthUi.kUserCancelledError) {
            error = "User cancelled login";
          } else {
            error = e.message ?? 'Unk error';
          }
        });
      }
    });
  }
}
