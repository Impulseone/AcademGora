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
  List<Pair> textEditingControllers = [];
  int selectedPeopleCount = 0;
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
              child: SingleChildScrollView(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    _infoWidget(),
                    Container(
                        margin: EdgeInsets.only(top: 12, left: 5),
                        child:
                            SelectPeopleCountWidget(selectedPeopleCount, this)),
                    horizontalDivider(10, 10, 10, 10),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: SelectDurationWidget(selectedDuration, this)),
                    horizontalDivider(10, 10, 10, 10),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: SelectLevelOfSkatingWidget(
                            selectedLevelOfSkating, this)),
                    horizontalDivider(10, 10, 10, 10),
                    Container(
                        height: 140,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                            itemCount: selectedPeopleCount,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(left: 25),
                                child: HumanInfoWidget(
                                    index + 1, textEditingControllers, this),
                              );
                            })),
                    _commentFieldWidget(),
                    _continueButton()
                  ],
                ),
              )))),
    );
  }

  Widget _infoWidget() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: 300,
        height: 155,
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

  Widget _commentFieldWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Container(
              height: 20,
              width: 20,
              child: Image.asset("assets/registration_parameters/e12.png")),
          Container(
            width: 300,
            height: 20,
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                  hintText: "Добавить комментарий",
                  hintStyle: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _continueButton() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.chevron_left,
                color: Colors.blue,
                size: 40,
              ),
            ),
            Container(
              width: 170,
              height: 38,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    )),
              ),
            )
          ],
        ));
  }

  Color _continueButtonBackgroundColor() {
    if (selectedPeopleCount != null &&
        selectedLevelOfSkating != null &&
        selectedDuration != null &&
        _checkTextControllers())
      return Colors.blue;
    else
      return Colors.white;
  }

  Color _continueButtonTextColor() {
    if (selectedPeopleCount != null &&
        selectedLevelOfSkating != null &&
        selectedDuration != null &&
        _checkTextControllers())
      return Colors.white;
    else
      return Colors.grey;
  }

  bool _checkTextControllers() {
    if (textEditingControllers.isNotEmpty) {
      List<bool> conditions = [];
      for (var textControllersPair in textEditingControllers) {
        conditions.add(textControllersPair.left.text.isNotEmpty &&
            textControllersPair.right.text.isNotEmpty);
      }
      if (conditions.contains(false))
        return false;
      else
        return true;
    } else
      return false;
  }
}

class Pair {
  Pair(this.left, this.right);

  final TextEditingController left;
  final TextEditingController right;
}
