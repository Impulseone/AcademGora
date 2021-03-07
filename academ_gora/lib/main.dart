import 'package:academ_gora/screens/account/user_account_screen.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/registration/instructors_list_screen.dart';
import 'package:academ_gora/screens/registration/reg_final_screen.dart';
import 'package:academ_gora/screens/registration/registration_parameters_screen.dart';
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
        home: AuthScreen());
  }
}
