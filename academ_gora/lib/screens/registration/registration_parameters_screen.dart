import 'dart:convert';

import 'package:academ_gora/screens/registration/helpers_widgets/horizontal_divider.dart';
import 'package:academ_gora/screens/registration/helpers_widgets/reg_parameters/human_info_widget.dart';
import 'package:academ_gora/screens/registration/helpers_widgets/reg_parameters/info_text.dart';
import 'package:academ_gora/screens/registration/helpers_widgets/reg_parameters/select_duration_widget.dart';
import 'package:academ_gora/screens/registration/helpers_widgets/reg_parameters/select_level_of_skating_widget.dart';
import 'package:academ_gora/screens/registration/helpers_widgets/reg_parameters/select_people_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationParametersScreen extends StatefulWidget {
  @override
  RegistrationParametersScreenState createState() =>
      RegistrationParametersScreenState();
}

class RegistrationParametersScreenState
    extends State<RegistrationParametersScreen> {
  int selectedCount;
  int selectedDuration;
  int selectedLevelOfSkating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/registration_parameters/0_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _infoWidget(),
                  Container(
                      margin: EdgeInsets.only(top: 12, left: 5),
                      child: SelectPeopleCountWidget(selectedCount, this)),
                  horizontalDivider(10,10,10,10),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: SelectDurationWidget(selectedDuration, this)),
                  horizontalDivider(10,10,10,10),
                  Container(
                      margin: EdgeInsets.only (left: 5),
                      child:
                          SelectLevelOfSkatingWidget(selectedDuration, this)),
                  horizontalDivider(10,10,10,10),
                  Container(
                      margin: EdgeInsets.only (left: 25),
                      child: HumanInfoWidget(),
                  ),Container(
                      margin: EdgeInsets.only (left: 25),
                      child: HumanInfoWidget(),
                  ),Container(
                      margin: EdgeInsets.only (left: 25),
                      child: HumanInfoWidget(),
                  ), Container(
                    margin: EdgeInsets.only(left: 25),
                    child: HumanInfoWidget(),
                  ),
                  _continueButton()
                ],
              ))),
    );
  }

  Widget _infoWidget() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: 300,
        height: 180,
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
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            Text(
              InfoText.getText(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              InfoText.getAge(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ));
  }

  Widget _continueButton() {
    return Container(
      width: 200.0,
      height: 45,
      margin: EdgeInsets.only(top: 18),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: _continueButtonBackgroundColor(),
        child: InkWell(
            onTap: null,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ПРОДОЛЖИТЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _continueButtonTextColor(),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Color _continueButtonBackgroundColor() {
    return Colors.blue;
    // if (selectedKindOfSport != -1 && selectedDate != null) {
    //   return Colors.blue;
    // } else
    //   return Colors.white;
  }

  Color _continueButtonTextColor() {
    return Colors.white;
    // if (selectedKindOfSport != -1 && selectedDate != null) {
    //   return Colors.white;
    // } else
    //   return Colors.grey;
  }
}
