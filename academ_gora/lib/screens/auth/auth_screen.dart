import 'package:academ_gora/bloc/auth_bloc.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AuthBloc _authBloc = AuthBloc();

  final TextEditingController _controller = TextEditingController();
  String verificationID;

  String error;

  @override
  void initState() {
    super.initState();
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
          child: FutureBuilder(
            future: _checkLoginState(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return _loginForm();
              else {
                var user = snapshot.data as FirebaseAuth.User;
                return snapshot.hasData
                    ? Text("Logged in succesfully")
                    : _loginForm();
              }
            },
          ),
        ));
  }

  Widget _successfulLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => MainScreen()));
    return CircularProgressIndicator();
  }

  Widget _loginForm() {
    return Center(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              child: Text("СК \"АКАДЕМИЧЕСКИЙ\"",
                  style: TextStyle(
                    fontSize: 20,
                  ))),
          LoginFormWidget(_controller, () {
            _processLogin();
          }),
          Container(
            height: 150,
          )
        ],
      )),
    );
  }

  void _getCode(BuildContext context) {
    // if (_controller.text.length == 0) {
    //   _scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.fixed,
    //       content: Text('Введите номер телефона'),
    //     ),
    //   );
    // } else if (_controller.text.length < 12) {
    //   _scaffoldKey.currentState.showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.fixed,
    //       content: Text('Введенный номер телефона недействителен'),
    //     ),
    //   );
    // } else {
    //   _authBloc.verifyPhone(_controller.text.toString());
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (c) =>
    //           InputSmsCodeScreen(_controller.text.toString(), _authBloc)));
    // }
  }

  Future<FirebaseAuth.User> _checkLoginState() async {
    await Firebase.initializeApp();
    return FirebaseAuth.FirebaseAuth.instance.currentUser;
  }

  void _processLogin() async {
    var user = FirebaseAuth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      FirebaseAuthUi.instance()
          .launchAuth([AuthProvider.phone()]).then((fbUser) {
        setState(() {
          error = "";
        });
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
    } else {
      await FirebaseAuthUi.instance().logout();
      setState(() {});
    }
  }
}
