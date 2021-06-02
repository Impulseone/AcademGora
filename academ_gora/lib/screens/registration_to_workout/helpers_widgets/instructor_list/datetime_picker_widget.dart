import 'package:academ_gora/controller/firebase_controller.dart';
import 'package:academ_gora/model/reg_to_instructor_data.dart';
import 'package:academ_gora/model/workout.dart';
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

  var _selectedDate;
  WorkoutSingleton _workoutSingleton = WorkoutSingleton();

  double _screenWidth;
  double _screenHeight;

  FirebaseController _firebaseController = FirebaseController();

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
  void initState() {
    super.initState();
    _setSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return _dateTimePickerWidget();
  }

  void _setSelectedDate() {
    if (_workoutSingleton.date != null && _workoutSingleton.date.isNotEmpty) {
      String date = _workoutSingleton.date;
      String formattedDate =
          "${date.substring(4, 8)}-${date.substring(2, 4)}-${date.substring(0, 2)}";
      DateTime dateTime = DateTime.parse(formattedDate);
      _selectedDate = dateTime;
    } else {
      _selectedDate = DateTime.now();
    }
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
              _pickTimeButtonWidget("9:00"),
              _pickTimeButtonWidget("10:00"),
              _pickTimeButtonWidget("11:00"),
              _pickTimeButtonWidget("12:00"),
            ],
          ),
          Row(
            children: [
              _pickTimeButtonWidget("13:00"),
              _pickTimeButtonWidget("14:00"),
              _pickTimeButtonWidget("15:00"),
              _pickTimeButtonWidget("16:00"),
            ],
          ),
          Row(
            children: [
              _pickTimeButtonWidget("17:00"),
              _pickTimeButtonWidget("18:00"),
              _pickTimeButtonWidget("19:00"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pickTimeButtonWidget(String time) {
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
            time,
            style: TextStyle(color: _getTimeTextColor(time)),
          ),
        ));
  }

  void _selectTime(String time) {
    RegToInstructorData regToInstructorData = RegToInstructorData(
        widget.instructorWidgetState.instructor.name,
        widget.instructorWidgetState.instructor.phone,
        _selectedDate,
        time);

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

  Color _getTimeButtonColor(String time) {
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

  Color _getTimeTextColor(String time) {
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
