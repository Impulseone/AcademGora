import 'package:academ_gora/screens/registration/registration_parameters_screen.dart';
import 'package:academ_gora/screens/registration/registration_to_instructor_screen.dart';
import 'package:flutter/material.dart';

class SelectLevelOfSkatingWidget extends StatefulWidget {
  final int selectedLevelOfSkating;
  final RegistrationParametersScreenState registrationParametersScreenState;

  const SelectLevelOfSkatingWidget(
      this.selectedLevelOfSkating, this.registrationParametersScreenState,
      {Key key})
      : super(key: key);

  @override
  _SelectLevelOfSkatingWidgetState createState() =>
      _SelectLevelOfSkatingWidgetState(selectedLevelOfSkating);
}

class _SelectLevelOfSkatingWidgetState
    extends State<SelectLevelOfSkatingWidget> {
  int _selectedLevelOfScating;

  _SelectLevelOfSkatingWidgetState(this._selectedLevelOfScating);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_title(), _levelButtons(), _levelButton(2, 310, "Умею с любой горы, улучшение техники")],
    );
  }

  Widget _title() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 27),
        child: Text(
          "Выбор уровня катания:",
          style: TextStyle(fontSize: 12, color: Colors.blue),
        ));
  }

  Widget _levelButtons() {
    return Container(
        margin: EdgeInsets.only(left: 24, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _levelButton(0, 120,"C нуля"),
            _levelButton(1, 170, "Немного умею", leftMargin: 20),
          ],
        ));
  }

  Widget _levelButton(int which, double width, String text, {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: GestureDetector(
        onTap: () => _selectCount(which),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image:
                    AssetImage(_createBackgroundOfLevelOfSkatingButton(which)),
                fit: BoxFit.fill),
          ),
          height: 33,
          width: width,
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                color: which == _selectedLevelOfScating
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }

  void _selectCount(int which) {
    _selectedLevelOfScating = which;
    widget.registrationParametersScreenState.setState(() {
      widget.registrationParametersScreenState.selectedLevelOfSkating =
          _selectedLevelOfScating;
    });
    setState(() {});
  }

  String _createBackgroundOfLevelOfSkatingButton(int which) {
    return which == _selectedLevelOfScating
        ? "assets/auth/e2.png"
        : "assets/registration_parameters/e_1.png";
  }
}
