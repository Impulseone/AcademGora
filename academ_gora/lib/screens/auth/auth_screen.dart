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
              return _loginForm();
            },
          ),
        ));
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

  Future<FirebaseAuth.User> _checkLoginState() async {
    await Firebase.initializeApp();
    return FirebaseAuth.FirebaseAuth.instance.currentUser;
  }

  void _processLogin() async {
    var user = FirebaseAuth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      FirebaseAuthUi.instance()
          .launchAuth([AuthProvider.phone()]).then((fbUser) {
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
    } else {
      await FirebaseAuthUi.instance().logout();
      setState(() {});
    }
  }
}
