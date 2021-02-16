import 'package:academ_gora/screens/auth/helpers/login_form_widget.dart';
import 'package:academ_gora/screens/auth/password_screen.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

class AuthScreen extends StatelessWidget {
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
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        child: Text("СК \"АКАДЕМИЧЕСКИЙ\"",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    LoginFormWidget(() {
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
    //TODO: Firebase auth
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => InputPasswordScreen()));
  }
}
