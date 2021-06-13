import 'package:academ_gora/controller/auth_controller.dart';
import 'package:academ_gora/controller/firebase_requests_controller.dart';
import 'package:academ_gora/model/Instructors_keeper.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

double screenHeight;
double screenWidth;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthController authBloc = AuthController();
  FirebaseRequestsController _firebaseController = FirebaseRequestsController();
  InstructorsKeeper _instructorsKeeper = InstructorsKeeper();
  bool _isUserAuthorized;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
          _isUserAuthorized = true;
        });
      }
      else {
        setState(() {
          _isUserAuthorized = false;
        });
      }
      _firebaseController.addListener(
          "Инструкторы", _saveInstructorsIntoKeeper);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'АкадемГора',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(builder: (context) {
          screenHeight = MediaQuery.of(context).size.height;
          screenWidth = MediaQuery.of(context).size.width;
          if (_isUserAuthorized != null)
            return _isUserAuthorized ? MainScreen() : AuthScreen();
          else
            return SplashScreen();
        }));
  }

  void _saveInstructorsIntoKeeper(Event event) async {
    await _firebaseController.get("Инструкторы").then((value) {
      _instructorsKeeper.updateInstructors(value);
      setState(() {});
    });
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/account/0_bg.png"),
        fit: BoxFit.cover,
      ),
    )));
  }
}
