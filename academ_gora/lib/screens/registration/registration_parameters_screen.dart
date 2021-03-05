import 'dart:convert';

import 'package:academ_gora/screens/registration/helpers_widgets/info_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationParametersScreen extends StatefulWidget {
  @override
  _RegistrationParametersScreenState createState() =>
      _RegistrationParametersScreenState();
}

class _RegistrationParametersScreenState
    extends State<RegistrationParametersScreen> {
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
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [_infoWidget()],
              ))),
    );
  }

  Widget _infoWidget() {
    return Container(
        margin: EdgeInsets.only(top: 50),
        width: 310,
        height: 200,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage("assets/registration_parameters/e_1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 15),
                    child:
                        Image.asset("assets/registration_parameters/e_2.png")),
                Text(
                  InfoText.getLevelText(),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Text(
              InfoText.getText(),
              textAlign: TextAlign.center,
            ),
            Text(
              InfoText.getAge(),
              textAlign: TextAlign.left,
            ),
          ],
        ));
  }
}
