import 'package:academ_gora/bloc/auth_bloc.dart';
import 'package:academ_gora/screens/auth/helpers/login_form_widget.dart';
import 'package:academ_gora/screens/auth/input_sms_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AuthBloc _authBloc = AuthBloc();

  final TextEditingController _controller = TextEditingController();
  String verificationID;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/auth/1_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        child: Text("СК \"АКАДЕМИЧЕСКИЙ\"",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    LoginFormWidget(_controller, () {
                      _getCode(context);
                    }),
                    Container(
                      height: 150,
                    )
                  ],
                ),
              ),
            )));
  }

  void _getCode(BuildContext context) {
    if (_controller.text.length < 12) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.fixed,
            content: Text('Введенный номер телефона недействителен'),
          ),
        );
    } else {
      _authBloc.verifyPhone(_controller.text.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) =>
              InputSmsCodeScreen(_controller.text.toString(), _authBloc)));
    }
  }
}
