import 'package:academ_gora/screens/registration_to_workout/helpers_widgets/horizontal_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class SetWorkoutTimeScreen extends StatefulWidget {
  @override
  _SetWorkoutTimeScreenState createState() => _SetWorkoutTimeScreenState();
}

class _SetWorkoutTimeScreenState extends State<SetWorkoutTimeScreen> {
  double _screenHeight;
  double _screenWidth;

  DateTime _selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          _instructorName(),
          horizontalDivider(_screenWidth * 0.1, _screenWidth * 0.1, 15, 15),
          _calendar(),
          _indicatorsRow(),
          horizontalDivider(_screenWidth * 0.1, _screenWidth * 0.1, 15, 15),
          _dateTimePickerWidget()
        ],
      ),
    ));
  }

  Widget _instructorName() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.1),
        child: Text(
          "Ярославский Александр",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ));
  }

  Widget _calendar() {
    return CalendarCarousel<Event>(
      selectedDayButtonColor: Colors.blue,
      headerTextStyle:
          TextStyle(fontSize: _screenHeight * 0.023, color: Colors.blue),
      weekdayTextStyle: TextStyle(color: Colors.black),
      locale: "ru",
      width: 300,
      height: 320,
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(color: Colors.black),
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => _selectedDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(color: Colors.black),
      selectedDateTime: _selectedDate,
      targetDateTime: _selectedDate,
      selectedDayTextStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _indicatorsRow() {
    return Container(
      margin: EdgeInsets.only(left: _screenWidth * 0.1),
      child: Row(
        children: [
          _indicator("выходной", "assets/instructor_set_time/e4.png"),
          _indicator("запись открыта", "assets/instructor_set_time/e5.png"),
          _indicator("записи нет", "assets/instructor_set_time/e6.png"),
        ],
      ),
    );
  }

  Widget _indicator(String text, String iconPath) {
    return Container(
      margin: EdgeInsets.only(left: _screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 8,
            width: 8,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )
        ],
      ),
    );
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
    return "${_selectedDate.day}";
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
    // RegToInstructorData regToInstructorData = RegToInstructorData(
    //     widget.instructorWidgetState.instructor.name,
    //     widget.instructorWidgetState.instructor.phone,
    //     _selectedDate,
    //     time);
    //
    // if (widget.instructorWidgetState.regToInstructorData == null)
    //   _updateRegToInstructorData(regToInstructorData);
    // else if (widget.instructorWidgetState.regToInstructorData.instructorName ==
    //     regToInstructorData.instructorName) {
    //   _updateRegToInstructorData(regToInstructorData);
    // } else
    //   _updateRegToInstructorData(regToInstructorData);
  }
  Color _getTimeButtonColor(String time) {
    // if (widget.instructorWidgetState.regToInstructorData != null &&
    //     _regToInstructorDataCurrent != null &&
    //     widget.instructorWidgetState.regToInstructorData.instructorName ==
    //         _regToInstructorDataCurrent.instructorName &&
    //     _regToInstructorDataCurrent.date == _selectedDate &&
    //     _regToInstructorDataCurrent.time == time) {
    //   return Colors.blue;
    // } else
      return Colors.white;
  }

  Color _getTimeTextColor(String time) {
    // if (widget.instructorWidgetState.regToInstructorData != null &&
    //     _regToInstructorDataCurrent != null &&
    //     widget.instructorWidgetState.regToInstructorData.instructorName ==
    //         _regToInstructorDataCurrent.instructorName &&
    //     _regToInstructorDataCurrent.date == _selectedDate &&
    //     _regToInstructorDataCurrent.time == time)
    //   return Colors.white;
    // else
      return Colors.black;
  }
}
