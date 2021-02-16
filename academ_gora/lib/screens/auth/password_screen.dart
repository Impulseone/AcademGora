import 'package:academ_gora/screens/auth/helpers/password_widget.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:flutter/material.dart';

class InputPasswordScreen extends StatelessWidget {

  final String number;

  InputPasswordScreen(this.number);

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
                    PasswordWidget(() {
                      _openMainScreen(context);
                    }, () {
                      _onBackPressed(context);
                    }, number),
                    Container(
                      height: 150,
                    )
                  ],
                ),
              ),
            )));
  }

  void _openMainScreen(BuildContext context) {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (c) => MainScreen()),
    //     (Route<dynamic> route) => false);
    Navigator.of(context).push(MaterialPageRoute(builder: (c) => MainScreen()));
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }
}
