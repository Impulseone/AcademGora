import 'package:flutter/material.dart';

class RegistrationToInstructorScreen extends StatefulWidget {
  @override
  _RegistrationToInstructorScreenState createState() =>
      _RegistrationToInstructorScreenState();
}

class _RegistrationToInstructorScreenState
    extends State<RegistrationToInstructorScreen> {
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
          _buttonsUnderImages(),
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
        Container(
          margin: EdgeInsets.only(top: 60),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/registration_to_instructor/2_ski.png",
            height: 160,
            width: 160,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 18, top: 60),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/registration_to_instructor/2_snowboard.png",
            height: 160,
            width: 160,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _buttonsUnderImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/registration_to_instructor/3_e1.png"),
                  fit: BoxFit.fill),
            ),
            height: 40,
            width: 140,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 8),
            child: Text(
              "ГОРНЫЕ ЛЫЖИ",
              style: TextStyle(fontSize: 11, color: Colors.blueAccent),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/registration_to_instructor/3_e1.png"),
                    fit: BoxFit.fill),
              ),
              height: 40,
              width: 140,
              padding: EdgeInsets.only(right: 12),
              alignment: Alignment.centerRight,
              child: Text(
                "СНОУБОРД",
                style: TextStyle(fontSize: 11, color: Colors.blueAccent),
              ),
            ),
          ),
        )
      ],
    );
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
