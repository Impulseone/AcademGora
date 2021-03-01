import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:academ_gora/screens/registration/registration_to_instructor_screen.dart';
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
        home: RegistrationToInstructorScreen());
  }
}
