import 'package:academ_gora/bloc/auth_bloc.dart';
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
        home: StreamBuilder<bool>(
            stream: authBloc.isUserLoggedIn,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data) {
                return MainScreen();
              }
              return AuthScreen();
            }));
  }
}
