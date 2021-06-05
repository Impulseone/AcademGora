import 'package:academ_gora/controller/auth_controller.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'АкадемГора',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _initApp(),
          builder: (context, snap) {
            screenHeight = MediaQuery.of(context).size.height;
            screenWidth = MediaQuery.of(context).size.width;
            if (snap.hasData)
              return snap.data == true ? MainScreen() : AuthScreen();
            else {
              return SplashScreen();
            }
          },
        ));
  }

  Future<bool> _initApp() async {
    bool isUserAuthorized = false;
    await Firebase.initializeApp().then((_) {
      if (FirebaseAuth.instance.currentUser != null) isUserAuthorized = true;
    });
    return isUserAuthorized;
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
