import 'package:academ_gora/bloc/auth_bloc.dart';
import 'package:academ_gora/screens/auth/helpers/sms_code_widget.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:flutter/material.dart';

class InputSmsCodeScreen extends StatelessWidget {
  final String number;
  final AuthBloc authBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  InputSmsCodeScreen(this.number, this.authBloc);

  @override
  Widget build(BuildContext context) {
    _listenErrors();
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
                    SMSCodeWidget(() {
                      _openMainScreen(context);
                    }, () {
                      _onBackPressed(context);
                    }, number, authBloc, _scaffoldKey),
                    Container(
                      height: 150,
                    )
                  ],
                ),
              ),
            )));
  }

  void _openMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _listenErrors() {
    authBloc.errorController.stream.listen((event) {
      if (event != null)
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.fixed,
            content: Text(event),
          ),
        );
    });
  }
}
