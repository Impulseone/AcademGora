import 'package:academ_gora/bloc/auth_bloc.dart';
import 'package:academ_gora/screens/account/instructor_account/set_workout_time_screen.dart';
import 'package:academ_gora/screens/all_instructors/all_instructors_screen.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/info_screens/about_us_screen.dart';
import 'package:academ_gora/screens/instructor_profile/instructor_profile_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthBloc authBloc = AuthBloc();

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'АкадемГора',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: SplashScreen(authBloc)
        home: SetWorkoutTimeScreen()
    );
  }
}

class SplashScreen extends StatelessWidget {
  final AuthBloc authBloc;

  SplashScreen(this.authBloc);

  @override
  Widget build(BuildContext context) {
    _listenLoginInfo(context);
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/account/0_bg.png"),
        fit: BoxFit.cover,
      ),
    )));
  }

  void _listenLoginInfo(BuildContext context) {
    authBloc.isUserLoggedIn.listen((event) {
      if (event) _openMainScreen(context);
      else _openAuthScreen(context);
    });
  }

  void _openMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => MainScreen()), (route) => false);
  }

  void _openAuthScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
  }
}
