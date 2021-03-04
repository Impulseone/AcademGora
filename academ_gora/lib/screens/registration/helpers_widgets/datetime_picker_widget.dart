import 'package:academ_gora/screens/registration/helpers_widgets/instructor_widget.dart';
import 'package:flutter/material.dart';

class DateTimePickerWidget extends StatefulWidget {
  const DateTimePickerWidget({Key key}) : super(key: key);

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  Map<DateTime, int> selectedDates = {};

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
      children: [_dateSliderWidget(), _timeWidget()],
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

  Widget _timeWidget() {
    return Container(
      margin: EdgeInsets.only(left: 30, top: 10),
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

  Widget _pickTimeButtonWidget(int pos) {
    return GestureDetector(
        onTap: () => _selectTime(pos),
        child: Container(
          height: 25,
          width: 45,
          alignment: Alignment.center,
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: _getTimeButtonColor(pos),
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Text(
            "10:00",
            style: TextStyle(color: _getTimeTextColor(pos)),
          ),
        ));
  }

  void _selectTime(int pos) {
    setState(() {
      if (selectedDates.containsKey(_selectedDate)) {
        if (selectedDates[_selectedDate] == pos) {
          selectedDates.remove(_selectedDate);
        } else {
          selectedDates.remove(_selectedDate);
          selectedDates.putIfAbsent(_selectedDate, () => pos);
        }
      } else
        selectedDates.putIfAbsent(_selectedDate, () => pos);
    });
  }

  Color _getTimeButtonColor(int pos) {
    if (selectedDates.containsKey(_selectedDate) &&
        selectedDates[_selectedDate] == pos)
      return Colors.blue;
    else
      return Colors.white;
  }

  Color _getTimeTextColor(int pos) {
    if (selectedDates.containsKey(_selectedDate) &&
        selectedDates[_selectedDate] == pos)
      return Colors.white;
    else
      return Colors.black;
  }
}
