import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;

class DateWidget extends StatefulWidget {

 final DateTime _selectedDate;

 DateWidget(this._selectedDate);

  @override
  _DateWidgetState createState() => _DateWidgetState(_selectedDate);
}

class _DateWidgetState extends State<DateWidget> {

  DateTime _selectedDate;


  _DateWidgetState(this._selectedDate);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_dateNameWidget(), _dateFieldWidget()],
    );
  }

  Widget _dateNameWidget() {
    return Row(
      children: [
        Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 10),
            child: Image.asset("assets/registration_to_instructor/4_e3.png")),
        Text(
          "ДАТА",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _dateFieldWidget() {
    return Container(
      width: 160,
      height: 30,
      margin: EdgeInsets.only(left: 90),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_dateTextWidget(), _clearDateWidget()]),
    );
  }

  Widget _dateTextWidget() {
    return GestureDetector(
      child: Center(
          child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 30,
              width: 130,
              child: Text(
                _selectedDate == null
                    ? ""
                    : DateFormat("dd.MM.yyyy").format(_selectedDate),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ))),
      onTap: _showDateDialog,
    );
  }

  Widget _clearDateWidget() {
    return GestureDetector(
      child: Container(
          height: 13,
          width: 13,
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Image.asset("assets/registration_to_instructor/5_e8.png")),
      onTap: _clearDateFieldButton,
    );
  }

  void _clearDateFieldButton() {
    setState(() {
      _selectedDate = null;
    });
  }

  Future<void> _showDateDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (c, setState) => AlertDialog(
                actions: [
                  TextButton(child: Text('OK'), onPressed: _closeDialog),
                ],
                content: CalendarCarousel<Event>(
                  locale: "ru",
                  width: 300,
                  height: 270,
                  todayBorderColor: Colors.transparent,
                  todayButtonColor: Colors.transparent,
                  todayTextStyle: TextStyle(color: Colors.blueAccent),
                  onDayPressed: (DateTime date, List<Event> events) {
                    setState(() => _selectedDate = date);
                    events.forEach((event) => print(event.title));
                  },
                  selectedDateTime: _selectedDate,
                  targetDateTime: _selectedDate,
                  selectedDayTextStyle: TextStyle(color: Colors.white),
                )));
      },
    );
  }

  void _closeDialog() {
    Navigator.of(context).pop();
    setState(() {});
  }
}
