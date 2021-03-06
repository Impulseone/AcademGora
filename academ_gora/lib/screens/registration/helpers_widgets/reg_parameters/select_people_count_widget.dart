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
    return Container(
        margin: EdgeInsets.only(left: 27),
        child: Text(
          "Количество человек",
          style: TextStyle(fontSize: 12, color: Colors.blue),
        ));
  }

  Widget _countButtons() {
    return Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _countButton(1),
            _countButton(2, leftMargin: 10),
            _countButton(3, leftMargin: 10),
            _countButton(4, leftMargin: 10)
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
          width: 30,
          alignment: Alignment.center,
          child: Text(
            which.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: which == _selectedCount ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  void _selectCount(int which) {
    _selectedCount = which;
    widget.registrationParametersScreenState.setState(() {
      widget.registrationParametersScreenState.selectedPeopleCount = _selectedCount;
      widget.registrationParametersScreenState.textEditingControllers = [];
      for (var i = 0; i < which; ++i) {
        widget.registrationParametersScreenState.textEditingControllers
            .add(Pair(TextEditingController(), TextEditingController()));
      }
    });
    setState(() {});
  }

  String _createBackgroundOfCountButton(int which) {
    return which == _selectedCount
        ? "assets/registration_parameters/e_4.png"
        : "assets/registration_parameters/e_1.png";
  }
}
