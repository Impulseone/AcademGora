import 'package:flutter/material.dart';

class RegistrationParametersScreen extends StatefulWidget {
  @override
  _RegistrationParametersScreenState createState() =>
      _RegistrationParametersScreenState();
}

class _RegistrationParametersScreenState extends State<RegistrationParametersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/registration_to_instructor/1_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              _infoWidget()
            ],
          )),
    );
  }
  Widget _infoWidget(){
    return Container(child: Text(""),);
  }
}
