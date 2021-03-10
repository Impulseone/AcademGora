import 'package:academ_gora/screens/account/helpers_widgets/lesson_info.dart';
import 'package:flutter/material.dart';

class LessonWidget extends StatefulWidget {
  @override
  _LessonWidgetState createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/account/e2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        _titleRow(),
        _countOfPeople(),
        _redactButtons(),
        _infoTextColumn(),
        _instructorInfoWidget(),
        _callToInstructorButtons()
      ]),
    );
  }

  Widget _titleRow() {
    return Container(
        color: Colors.blue,
        height: 40,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "11.02.21",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
            Container(
                margin: EdgeInsets.only(left: width / 7),
                child: Text("11:30-12:30",
                    style: TextStyle(color: Colors.white, fontSize: 22)))
          ],
        ));
  }

  Widget _countOfPeople() {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Количество человек",
                  style: TextStyle(fontSize: 18),
                )),
            Container(
              margin: EdgeInsets.only(left: width / 6),
              child: Text("2", style: TextStyle(fontSize: 18)),
            ),
          ],
        ));
  }

  Widget _redactButtons() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            _button("РЕДАКТИРОВАТЬ", 10),
            _button("ОТМЕНИТЬ", width / 8),
          ],
        ));
  }

  Widget _button(
    String text,
    double leftMargin,
  ) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 30,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: leftMargin),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/account/e4.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _infoTextColumn() {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 10),
        child: Column(
          children: [
            _infoText(LessonInfo.firstCondition()),
            _infoText(LessonInfo.secondCondition()),
            _infoText(LessonInfo.thirdCondition()),
            _infoText(LessonInfo.fourthCondition()),
            _infoText(LessonInfo.fifthCondition()),
            _infoText(LessonInfo.sixthCondition()),
            _infoText(LessonInfo.seventhCondition()),
          ],
        ));
  }

  Widget _infoText(String text) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(fontSize: 11),
        ));
  }

  Widget _instructorInfoWidget() {
    return Container(
        width: width * 0.9,
        margin: EdgeInsets.only(left: 10, top: 5),
        child: Row(
          children: [
            Text(
              "Инструктор:",
              style: TextStyle(fontSize: 14),
            ),
            Container(
              width: width*0.4,
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  "Ярославский Александр",
                  style: TextStyle(fontSize: 14),
                )),
          ],
        ));
  }

  Widget _callToInstructorButtons() {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, bottom: 5),
      child: Row(children: [_phoneNumberButton(), _whatsAppButton()]),
    );
  }

  Widget _phoneNumberButton() {
    return Container(
        alignment: Alignment.center,
        height: 30,
        width: width*0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: AssetImage("assets/account/phone.png"),
          ),
        ),
        child: Text(
          "+79999999999",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ));
  }

  Widget _whatsAppButton() {
    return Container(
        alignment: Alignment.center,
        height: 30,
        width: width*0.35,
        margin: EdgeInsets.only(left: width*0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: AssetImage("assets/account/wa.png"),
          ),
        ),
        child: Text(
          "Написать",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ));
  }
}
