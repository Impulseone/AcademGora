import 'package:flutter/material.dart';

class InstructorsListScreen extends StatefulWidget {
  @override
  _InstructorsListScreenState createState() => _InstructorsListScreenState();
}

class _InstructorsListScreenState extends State<InstructorsListScreen> {
  final items = List<String>.generate(10, (i) => "Item $i");

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
          child: Column(children: [
            Container(
              height: 390,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _instructorWidget('${items[index]}');
                },
              ),
            ),
            _buttons()
          ])),
    );
  }

  Widget _instructorWidget(String text) {
    return Container(
      height: 60,
        child: Card(
      child: Text(text),
    ));
  }

  Widget _buttons() {
    return Container(margin: EdgeInsets.only(top: 100), child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_backButton(), _continueButton()],
    ));
  }

  Widget _backButton() {
    return Container(
      child: Icon(
        Icons.chevron_left,
        color: Colors.blue,
        size: 50,
      ),
    );
  }

  Widget _continueButton() {
    return Container(
      width: 250.0,
      height: 55,
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
    // if (kindOfSportSelected != -1 && selectedDate != null) {
    //   return Colors.blue;
    // } else
    return Colors.white;
  }

  Color _continueButtonTextColor() {
    // if (kindOfSportSelected != -1 && selectedDate != null) {
    //   return Colors.white;
    // } else
    return Colors.grey;
  }
}
