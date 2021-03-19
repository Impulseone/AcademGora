import 'package:academ_gora/model/reg_to_instructor_data.dart';
import 'package:flutter/material.dart';

import 'instructor_widget.dart';

class DateTimePickerWidget extends StatefulWidget {
  final InstructorWidgetState instructorWidgetState;

  const DateTimePickerWidget(this.instructorWidgetState, {Key key})
      : super(key: key);

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  RegToInstructorData _regToInstructorDataCurrent;

  var _selectedDate = new DateTime.now();

  double _screenWidth;
  double _screenHeight;

  List months = [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря'
  ];

  List weekdays = [
    'ПН',
    'ВТ',
    'СР',
    'ЧТ',
    'ПТ',
    'СБ',
    'ВС',
  ];

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return _dateTimePickerWidget();
  }

  Widget _dateTimePickerWidget() {
    return Container(
        child: Column(
      children: [_dateSliderWidget(), _timeWidget()],
    ));
  }

  Widget _dateSliderWidget() {
    return Container(
        margin: EdgeInsets.only(left: _screenWidth * 0.08),
        child: Row(
          children: [
            GestureDetector(
              onTap: _decreaseDate,
              child: Container(
                height: _screenWidth * 0.09,
                width: _screenWidth * 0.09,
                child: Image.asset("assets/instructors_list/e_6.png"),
              ),
            ),
            Container(
                width: _screenWidth * 0.38,
                alignment: Alignment.center,
                child: Text(_getSelectedDate())),
            GestureDetector(
              onTap: _increaseDate,
              child: Container(
                height: _screenWidth * 0.09,
                width: _screenWidth * 0.09,
                child: Image.asset("assets/instructors_list/e_7.png"),
              ),
            ),
          ],
        ));
  }

  String _getSelectedDate() {
    String month = months[_selectedDate.month - 1];
    String weekday = weekdays[_selectedDate.weekday - 1];
    return "${_selectedDate.day} $month ($weekday)";
  }

  void _increaseDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
  }

  void _decreaseDate() {
    if (_selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day)
      return;
    else
      setState(() {
        _selectedDate = _selectedDate.subtract(Duration(days: 1));
      });
  }

  Widget _timeWidget() {
    return Container(
      margin: EdgeInsets.only(left: _screenWidth * 0.1, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pickTimeButtonWidget(0),
              _pickTimeButtonWidget(1),
              _pickTimeButtonWidget(2),
              _pickTimeButtonWidget(3),
            ],
          ),
          Row(
            children: [
              _pickTimeButtonWidget(4),
              _pickTimeButtonWidget(5),
              _pickTimeButtonWidget(6),
              _pickTimeButtonWidget(7),
            ],
          ),
          Row(
            children: [
              _pickTimeButtonWidget(8),
              _pickTimeButtonWidget(9),
              _pickTimeButtonWidget(10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pickTimeButtonWidget(int time) {
    return GestureDetector(
        onTap: () => _selectTime(time),
        child: Container(
          height: _screenHeight * 0.05,
          width: _screenWidth * 0.13,
          alignment: Alignment.center,
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: _getTimeButtonColor(time),
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Text(
            "10:00",
            style: TextStyle(color: _getTimeTextColor(time)),
          ),
        ));
  }

  void _selectTime(int time) {
    RegToInstructorData regToInstructorData = RegToInstructorData(
        widget.instructorWidgetState.instructorName, _selectedDate, time);

    if (widget.instructorWidgetState.regToInstructorData == null)
      _updateRegToInstructorData(regToInstructorData);
    else if (widget.instructorWidgetState.regToInstructorData.instructorName ==
        regToInstructorData.instructorName) {
      _updateRegToInstructorData(regToInstructorData);
    } else
      _updateRegToInstructorData(regToInstructorData);
  }

  void _updateRegToInstructorData(RegToInstructorData regToInstructorData) {
    setState(() {
      if (_regToInstructorDataCurrent == regToInstructorData)
        _regToInstructorDataCurrent = null;
      else
        _regToInstructorDataCurrent = regToInstructorData;
    });
    widget.instructorWidgetState.setState(() {
      widget.instructorWidgetState.regToInstructorData =
          _regToInstructorDataCurrent;
    });
  }

  Color _getTimeButtonColor(int time) {
    if (widget.instructorWidgetState.regToInstructorData != null &&
        _regToInstructorDataCurrent != null &&
        widget.instructorWidgetState.regToInstructorData.instructorName ==
            _regToInstructorDataCurrent.instructorName &&
        _regToInstructorDataCurrent.date == _selectedDate &&
        _regToInstructorDataCurrent.time == time) {
      return Colors.blue;
    } else
      return Colors.white;
  }

  Color _getTimeTextColor(int time) {
    if (widget.instructorWidgetState.regToInstructorData != null &&
        _regToInstructorDataCurrent != null &&
        widget.instructorWidgetState.regToInstructorData.instructorName ==
            _regToInstructorDataCurrent.instructorName &&
        _regToInstructorDataCurrent.date == _selectedDate &&
        _regToInstructorDataCurrent.time == time)
      return Colors.white;
    else
      return Colors.black;
  }
}
