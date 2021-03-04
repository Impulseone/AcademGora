import 'package:academ_gora/screens/registration/helpers_widgets/instructor_widget.dart';
import 'package:flutter/material.dart';

class DateTimePickerWidget extends StatefulWidget {

  const DateTimePickerWidget({Key key})
      : super(key: key);

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  var _selectedDate = new DateTime.now();

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
    return _dateTimePickerWidget();
  }

  Widget _dateTimePickerWidget() {
    return Container(
        child: Column(
      children: [_dateSliderWidget()],
    ));
  }

  Widget _dateSliderWidget() {
    return Container(
        margin: EdgeInsets.only(left: 60),
        child: Row(
          children: [
            GestureDetector(
              onTap: _decreaseDate,
              child: Container(
                height: 20,
                width: 20,
                child: Image.asset("assets/instructors_list/e_6.png"),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(_getSelectedDate())),
            GestureDetector(
              onTap: _increaseDate,
              child: Container(
                height: 20,
                width: 20,
                child: Image.asset("assets/instructors_list/e_7.png"),
              ),
            ),
          ],
        ));
  }

  String _getSelectedDate() {
    String month = months[_selectedDate.month - 1];
    return "${_selectedDate.day} $month";
  }

  void _increaseDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
  }

  void _decreaseDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    });
  }
}
