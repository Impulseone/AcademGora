import 'package:academ_gora/screens/registration_to_instructor/helpers_widgets/horizontal_divider.dart';
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

  DateTime _selectedDate;

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
          horizontalDivider(_screenWidth * 0.1, _screenWidth * 0.1, 15, 15),
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
          TextStyle(fontSize: _screenHeight * 0.023, color: Colors.blueAccent),
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
}
