import 'package:academ_gora/screens/registration_to_instructor/reg_final_screen.dart';
import 'package:flutter/material.dart';

import 'helpers_widgets/horizontal_divider.dart';
import 'helpers_widgets/reg_parameters/human_info_widget.dart';
import 'helpers_widgets/reg_parameters/info_text.dart';
import 'helpers_widgets/reg_parameters/select_duration_widget.dart';
import 'helpers_widgets/reg_parameters/select_level_of_skating_widget.dart';
import 'helpers_widgets/reg_parameters/select_people_count_widget.dart';

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
  double _screenHeight;
  double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/registration_parameters/0_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              width: _screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _infoWidget(),
                    Container(
                        margin: EdgeInsets.only(top: 12, left: 5),
                        child:
                            SelectPeopleCountWidget(selectedPeopleCount, this)),
                    horizontalDivider(
                        10, 10, _screenHeight * 0.015, _screenHeight * 0.015),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: SelectDurationWidget(selectedDuration, this)),
                    horizontalDivider(
                        10, 10, _screenHeight * 0.015, _screenHeight * 0.015),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: SelectLevelOfSkatingWidget(
                            selectedLevelOfSkating, this)),
                    horizontalDivider(
                        10, 10, _screenHeight * 0.015, _screenHeight * 0.015),
                    Container(
                        height: _screenHeight * 0.19,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(3),
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
              ))),
    );
  }

  Widget _infoWidget() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.05),
        width: _screenWidth * 0.9,
        height: _screenHeight * 0.25,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage("assets/registration_parameters/e_1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: _screenWidth * 0.16),
                    child:
                        Image.asset("assets/registration_parameters/e_2.png")),
                Container(
                    child: Text(
                  InfoText.getLevelText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: _screenHeight * 0.018),
                ))
              ],
            ),
            Text(
              InfoText.getText(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _screenHeight * 0.018),
            ),
            Text(
              InfoText.getAge(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: _screenHeight * 0.018),
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
            width: _screenWidth * 0.85,
            height: _screenHeight * 0.05,
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              maxLines: 10,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
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
            GestureDetector(
              onTap: _onBackPressed,
              child: Container(
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
            Container(
              width: 170,
              height: _screenHeight * 0.06,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: _continueButtonBackgroundColor(),
                child: InkWell(
                    onTap: selectedPeopleCount != null &&
                            selectedLevelOfSkating != null &&
                            selectedDuration != null &&
                            _checkTextControllers()
                        ? _openRegFinalScreen
                        : null,
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

  void _openRegFinalScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => RegistrationFinalScreen()));
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
      for (var i = 0; i < selectedPeopleCount; ++i) {
        conditions.add(textEditingControllers[i].left.text.isNotEmpty &&
            textEditingControllers[i].right.text.isNotEmpty &&
            isNumericUsing_tryParse(textEditingControllers[i].right.text));
      }
      if (conditions.contains(false))
        return false;
      else
        return true;
    } else
      return false;
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }
}

bool isNumericUsing_tryParse(String string) {
  // Null or empty string is not a number
  if (string == null || string.isEmpty) {
    return false;
  }
  final number = num.tryParse(string);

  if (number == null) {
    return false;
  }
  return true;
}

class Pair {
  Pair(this.left, this.right);

  final TextEditingController left;
  final TextEditingController right;
}
