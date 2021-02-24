import 'package:flutter/material.dart';

class RegistrationToInstructorScreen extends StatefulWidget {
  @override
  _RegistrationToInstructorScreenState createState() =>
      _RegistrationToInstructorScreenState();
}

class _RegistrationToInstructorScreenState
    extends State<RegistrationToInstructorScreen> {
  int _kindOfSportSelected = -1;

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
          _topImages(),
          _kindOfSportButtons(),
          _horizontalDivider(),
          _dateWidget(),
          _horizontalDivider(),
          _timeWidget(),
          _warningText(),
          _continueButton(),
          _selectCoachButton()
        ],
      ),
    ));
  }

  Widget _topImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _kindOfSportImage("assets/registration_to_instructor/2_ski.png"),
        _kindOfSportImage("assets/registration_to_instructor/2_snowboard.png",
            marginLeft: 18)
      ],
    );
  }

  Widget _kindOfSportImage(String imagePath, {double marginLeft = 0}) {
    return Container(
      margin: EdgeInsets.only(top: 60, left: marginLeft),
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        height: 160,
        width: 160,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _kindOfSportButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_kindOfSportButton(0), _kindOfSportButton(1, leftMargin: 40)],
    );
  }

  Widget _kindOfSportButton(int which, {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: GestureDetector(
        onTap: () => _selectKindOfSport(which),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_createBackgroundOfKindOfSportButton(which)),
                fit: BoxFit.fill),
          ),
          height: 40,
          width: 140,
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Text(
            which == 0 ? "ГОРНЫЕ ЛЫЖИ" : "СНОУБОРД",
            style: TextStyle(
                fontSize: 11,
                color: _createTextColorOfKindOfSportButton(which)),
          ),
        ),
      ),
    );
  }

  void _selectKindOfSport(int which) {
    setState(() {
      _kindOfSportSelected = which;
    });
  }

  String _createBackgroundOfKindOfSportButton(int which) {
    return which == _kindOfSportSelected
        ? "assets/registration_to_instructor/3_e2.png"
        : "assets/registration_to_instructor/3_e1.png";
  }

  Color _createTextColorOfKindOfSportButton(int which) {
    return which == _kindOfSportSelected ? Colors.white : Colors.blueAccent;
  }

  Widget _horizontalDivider() {
    return Container(
      color: Colors.grey,
      height: 1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
    );
  }

  Widget _dateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 10),
                child:
                    Image.asset("assets/registration_to_instructor/4_e3.png")),
            Text(
              "ДАТА",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Container(
          width: 160,
          height: 30,
          margin: EdgeInsets.only(left: 90),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
        )
      ],
    );
  }

  Widget _timeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 10),
                child:
                    Image.asset("assets/registration_to_instructor/4_e4.png")),
            Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  "ВРЕМЯ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
        Container(
          width: 80,
          height: 30,
          margin: EdgeInsets.only(left: 50, right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        Text("-"),
        Container(
          width: 80,
          height: 30,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ],
    );
  }

  Widget _warningText() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          "Укажите конкретное время или желаемый интервал для начала занятия",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.lightBlue),
        ));
  }

  Widget _continueButton() {
    return Container(
      width: 300.0,
      height: 60,
      margin: EdgeInsets.only(top: 25),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
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
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _selectCoachButton() {
    return Container(
      width: 300.0,
      height: 60,
      margin: EdgeInsets.only(top: 15),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
        child: InkWell(
            onTap: null,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "выбрать определенного",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "инструктора",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }
}
