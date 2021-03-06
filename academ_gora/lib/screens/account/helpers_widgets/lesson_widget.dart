import 'package:flutter/material.dart';

class LessonWidget extends StatefulWidget {
  @override
  _LessonWidgetState createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 340,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/account/e2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [_titleRow(), _countOfPeople(), _redactButtons()]),
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
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                )),
            Container(
                margin: EdgeInsets.only(left: 50),
                child: Text("11:30-12:30",
                    style: TextStyle(color: Colors.white, fontSize: 24.0)))
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
              margin: EdgeInsets.only(left: 100),
              child: Text("2", style: TextStyle(fontSize: 18)),
            ),
          ],
        ));
  }

  Widget _redactButtons() {
    return Container(margin: EdgeInsets.only(top: 10), child: Row(
      children: [
        _button("РЕДАКТИРОВАТЬ", 10),
        _button("ОТМЕНИТЬ", 80),
      ],
    ));
  }

  Widget _button(String text, double leftMargin,) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 35,
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
}
