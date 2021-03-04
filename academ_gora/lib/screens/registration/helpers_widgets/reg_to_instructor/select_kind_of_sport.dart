import 'package:academ_gora/screens/registration/registration_to_instructor_screen.dart';
import 'package:flutter/material.dart';

class SelectKindOfSportWidget extends StatefulWidget {
  final int kindOfSportSelected;
  final RegistrationToInstructorScreenState registrationToInstructorScreenState;

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

  _SelectKindOfSportWidgetState(this._kindOfSportSelected);

  @override
  Widget build(BuildContext context) {
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
