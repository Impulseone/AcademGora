import 'package:academ_gora/screens/registration/registration_parameters_screen.dart';
import 'package:academ_gora/screens/registration/registration_to_instructor_screen.dart';
import 'package:flutter/material.dart';

class SelectPeopleCountWidget extends StatefulWidget {
  final int selectedCount;
  final RegistrationParametersScreenState registrationParametersScreenState;

  const SelectPeopleCountWidget(
      this.selectedCount, this.registrationParametersScreenState,
      {Key key})
      : super(key: key);

  @override
  _SelectPeopleCountWidgetState createState() =>
      _SelectPeopleCountWidgetState(selectedCount);
}

class _SelectPeopleCountWidgetState extends State<SelectPeopleCountWidget> {
  int _selectedCount;

  _SelectPeopleCountWidgetState(this._selectedCount);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _peoplesCountWidget(),
        _countButtons(),
      ],
    );
  }

  Widget _peoplesCountWidget() {
    return Row(
      children: [Text("Количество человек")],
    );
  }

  Widget _countButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _countButton(0),
        _countButton(1, leftMargin: 10),
        _countButton(2, leftMargin: 10),
        _countButton(3, leftMargin: 10)
      ],
    );
  }

  Widget _countButton(int which, {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: GestureDetector(
        onTap: () => _selectCount(which),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_createBackgroundOfKindOfSportButton(which)),
                fit: BoxFit.fill),
          ),
          height: 40,
          width: 40,
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Text(
            (which + 1).toString(),
            style: TextStyle(
                fontSize: 11,
                color: which == _selectedCount ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  void _selectCount(int which) {
    _selectedCount = which;
    widget.registrationParametersScreenState.setState(() {
      widget.registrationParametersScreenState.selectedCount = _selectedCount;
    });
    setState(() {});
  }

  String _createBackgroundOfKindOfSportButton(int which) {
    return which == _selectedCount
        ? "assets/registration_parameters/e_4.png"
        : "assets/registration_parameters/e_1.png";
  }
}
