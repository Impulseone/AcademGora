import 'package:academ_gora/screens/all_instructors/all_instructors_screen.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/info_screens/about_us_screen.dart';
import 'package:academ_gora/screens/instructor_profile/instructor_profile_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen());
  }
}
