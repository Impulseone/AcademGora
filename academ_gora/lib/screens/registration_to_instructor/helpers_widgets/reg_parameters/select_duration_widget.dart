import 'package:flutter/material.dart';

import '../../registration_parameters_screen.dart';

class SelectDurationWidget extends StatefulWidget {
  final int selectedDuration;
  final RegistrationParametersScreenState registrationParametersScreenState;

  const SelectDurationWidget(
      this.selectedDuration, this.registrationParametersScreenState,
      {Key key})
      : super(key: key);

  @override
  _SelectDurationWidgetState createState() =>
      _SelectDurationWidgetState(selectedDuration);
}

class _SelectDurationWidgetState extends State<SelectDurationWidget> {
  int _selectedDuration;

  double _screenHeight;
  double _screenWidth;

  _SelectDurationWidgetState(this._selectedDuration);

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        _peoplesCountWidget(),
        _countButtons(),
      ],
    );
  }

  Widget _peoplesCountWidget() {
    return Container(
        margin: EdgeInsets.only(left: _screenWidth*0.03),
        child: Text(
          "Длительность\nзанятия",
          style: TextStyle(fontSize: 12, color: Colors.blue),
        ));
  }

  Widget _countButtons() {
    return Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _countButton(0),
            _countButton(1, leftMargin: 10),
          ],
        ));
  }

  Widget _countButton(int which, {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: GestureDetector(
        onTap: () => _selectCount(which),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: AssetImage(_createBackgroundOfCountButton(which)),
                fit: BoxFit.fill),
          ),
          height: 30,
          width: _screenWidth*0.3,
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Text(
            which == 0 ? "1 час" : "2 часа",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: which == _selectedDuration ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  void _selectCount(int which) {
    _selectedDuration = which;
    widget.registrationParametersScreenState.setState(() {
      widget.registrationParametersScreenState.selectedDuration = _selectedDuration;
    });
    setState(() {});
  }

  String _createBackgroundOfCountButton(int which) {
    return which == _selectedDuration
        ? "assets/registration_to_instructor/3_e2.png"
        : "assets/registration_to_instructor/3_e1.png";
  }
}
