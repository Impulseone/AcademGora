import 'package:academ_gora/screens/auth/helpers/login_form_widget.dart';
import 'package:academ_gora/screens/auth/password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _controller = TextEditingController();
  String verificationID;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    LoginFormWidget(_controller, () {
                      _getCode(context);
                    }),
                    Container(
                      height: 150,
                    )
                  ],
                ),
              ),
            )));
  }

  void _getCode(BuildContext context) {
    print(_controller.text.toString());
    _verifyPhone(_controller.text.toString());
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => InputPasswordScreen(_controller.text)));
  }

  Future<void> _verifyPhone(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        timeout: const Duration(seconds: 15),
        verificationFailed: _verificationFailed,
        codeSent: _smsSent,
        codeAutoRetrievalTimeout: _autoRetrievalTimeout);
  }

  void _verificationCompleted(AuthCredential authResult) async {
    UserCredential firebaseResult =
        await FirebaseAuth.instance.signInWithCredential(authResult);
    if (firebaseResult.additionalUserInfo.isNewUser) {
      print("---------------------------");
      print(firebaseResult.additionalUserInfo.isNewUser);
      print("true");
      print("---------------------------");
      // RegisterUser();
    } else {
      // AuthService().signIn(authResult);
      print("---------------------------");
      print(firebaseResult.additionalUserInfo.isNewUser);
      print("---------------------------");
    }
  }

  void _verificationFailed(FirebaseAuthException authException) {
    print(authException);
    if (authException.code == 'network-request-failed') {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Color.fromRGBO(244, 67, 54, 1),
          content: Text('Предоставленный номер телефона недействителен'),
        ),
      );
    } else if (authException.code == 'too-many-requests') {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Color.fromRGBO(244, 67, 54, 1),
          content: Text(
              'Мы заблокировали все запросы с этого устройства из-за необычной активности. Попробуйте позже.'),
        ),
      );
    }
  }

  void _smsSent(String verId, [int forceResend]) {
    this.verificationID = verId;
  }

  void _autoRetrievalTimeout(String verId) {
    this.verificationID = verId;
  }
}
