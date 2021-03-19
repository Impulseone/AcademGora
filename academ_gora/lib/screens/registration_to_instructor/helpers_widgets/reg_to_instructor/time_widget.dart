import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  final String _firstCurrentlySelected;
  final String _secondCurrentlySelected;

  TimeWidget(this._firstCurrentlySelected, this._secondCurrentlySelected);

  @override
  _TimeWidgetState createState() =>
      _TimeWidgetState(_firstCurrentlySelected, _secondCurrentlySelected);
}

class _TimeWidgetState extends State<TimeWidget> {
  String _firstCurrentlySelected;
  String _secondCurrentlySelected;

  double _screenHeight;
  double _screenWidth;

  _TimeWidgetState(this._firstCurrentlySelected, this._secondCurrentlySelected);

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return _timeWidget();
  }

  Widget _timeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeNameWidget(),
        _timeField(20, 10, 1),
        Text("-"),
        _timeField(10, 0, 2)
      ],
    );
  }

  Widget _timeNameWidget() {
    return Row(
      children: [
        Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Image.asset("assets/registration_to_instructor/4_e4.png")),
        Container(
            margin: EdgeInsets.only(right: 8),
            child: Text(
              "ВРЕМЯ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _timeField(double leftMargin, double rightMargin, int position) {
    return Container(
        width: _screenWidth*0.25,
        height: 30,
        padding: EdgeInsets.only(left: 3),
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: DropdownButtonHideUnderline(
          child: new DropdownButton<String>(
            value: position == 1
                ? _firstCurrentlySelected
                : _secondCurrentlySelected,
            items: <String>['любое', '10:00', '10:30', '11:00', '11:30']
                .map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                if (position == 1)
                  _firstCurrentlySelected = value;
                else
                  _secondCurrentlySelected = value;
              });
            },
          ),
        ));
  }
}
