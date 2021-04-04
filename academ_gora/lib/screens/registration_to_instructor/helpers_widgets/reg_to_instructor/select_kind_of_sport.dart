import 'package:flutter/material.dart';

import '../../registration_first_screen.dart';

class SelectKindOfSportWidget extends StatefulWidget {
  final int kindOfSportSelected;
  final RegistrationFirstScreenState registrationToInstructorScreenState;

  const SelectKindOfSportWidget(
      this.registrationToInstructorScreenState, this.kindOfSportSelected,
      {Key key})
      : super(key: key);

  @override
  _SelectKindOfSportWidgetState createState() =>
      _SelectKindOfSportWidgetState(kindOfSportSelected);
}

class _SelectKindOfSportWidgetState extends State<SelectKindOfSportWidget> {
  int _kindOfSportSelected;

  double _screenHeight;
  double _screenWidth;

  _SelectKindOfSportWidgetState(this._kindOfSportSelected);

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _topImages(),
        _kindOfSportButtons(),
      ],
    );
  }

  Widget _topImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _kindOfSportImage("assets/registration_to_instructor/2_ski.png"),
        _kindOfSportImage("assets/registration_to_instructor/2_snowboard.png",
            marginLeft: _screenWidth * 0.05)
      ],
    );
  }

  Widget _kindOfSportImage(String imagePath, {double marginLeft = 0}) {
    return Container(
      margin: EdgeInsets.only(top: _screenHeight * 0.07, left: marginLeft),
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        height: _screenHeight * 0.26,
        width: _screenHeight * 0.26,
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
          height: _screenHeight * 0.06,
          width: _screenWidth * 0.4,
          padding: EdgeInsets.only(right: 7),
          alignment: Alignment.centerRight,
          child: Text(
            which == 0 ? "ГОРНЫЕ ЛЫЖИ" : "СНОУБОРД",
            style: TextStyle(
                fontSize: 11,
                color: which == _kindOfSportSelected
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }

  void _selectKindOfSport(int which) {
    _kindOfSportSelected = which;
    widget.registrationToInstructorScreenState.setState(() {
      widget.registrationToInstructorScreenState.selectedKindOfSport =
          _kindOfSportSelected;
    });
    setState(() {});
  }

  String _createBackgroundOfKindOfSportButton(int which) {
    return which == _kindOfSportSelected
        ? "assets/registration_to_instructor/3_e2.png"
        : "assets/registration_to_instructor/3_e1.png";
  }
}
