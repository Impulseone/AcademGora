import 'package:academ_gora/controller/firebase_controller.dart';
import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/screens/registration_to_workout/helpers_widgets/horizontal_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';

enum TimeStatus { OPENED, CLOSED, NOT_AVAILABLE }

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

  List<String> _openedTimesPerDay = [];
  List<String> _closedTimesPerDay = [];
  List<String> _notAvailableTimesPerDay = [];

  EventList<Event> _markedDateMap = new EventList<Event>(events: Map());

  TimeStatus _selectedTimeStatus;

  FirebaseController _firebaseController = FirebaseController();

  @override
  void initState() {
    super.initState();
    _getOpenedTimesPerDay();
    _getOpenedTimesPerMonth();
  }

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
          horizontalDivider(_screenWidth * 0.1, _screenWidth * 0.1, 10, 10),
          _calendar(),
          _indicatorsRow(),
          horizontalDivider(_screenWidth * 0.1, _screenWidth * 0.1, 15, 15),
          _dateTimePickerWidget(),
          _changeStatusButtons()
        ],
      ),
    ));
  }

  Widget _instructorName() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.07),
        child: Text(
          "Ярославский Александр",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ));
  }

  Widget _calendar() {
    return CalendarCarousel<Event>(
      locale: "ru",
      width: _screenWidth * 0.69,
      height: _screenHeight * 0.43,
      selectedDayButtonColor: Colors.blue,
      headerMargin: EdgeInsets.all(0),
      headerTextStyle:
          TextStyle(fontSize: _screenHeight * 0.023, color: Colors.blue),
      weekdayTextStyle: TextStyle(color: Colors.black),
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(color: Colors.black),
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() {
          _selectedDate = date;
          _getOpenedTimesPerDay();
          _getOpenedTimesPerMonth();
        });
      },
      markedDatesMap: _markedDateMap,
      weekendTextStyle: TextStyle(color: Colors.black),
      selectedDateTime: _selectedDate,
      targetDateTime: _selectedDate,
      selectedDayTextStyle: TextStyle(color: Colors.white),
      markedDateShowIcon: true,
      markedDateIconBuilder: (e) => e.icon,
    );
  }

  Widget _indicatorsRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _indicator("выходной", "assets/instructor_set_time/e4.png"),
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
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _decreaseDate,
          child: Container(
            height: _screenWidth * 0.06,
            width: _screenWidth * 0.06,
            child: Image.asset("assets/instructors_list/e_6.png"),
          ),
        ),
        Container(
            width: _screenWidth * 0.38,
            alignment: Alignment.center,
            child: Text(
              _getSelectedDate(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        GestureDetector(
          onTap: _increaseDate,
          child: Container(
            height: _screenWidth * 0.06,
            width: _screenWidth * 0.06,
            child: Image.asset("assets/instructors_list/e_7.png"),
          ),
        ),
      ],
    ));
  }

  String _getSelectedDate() {
    return "${_selectedDate.day} ${months[_selectedDate.month - 1]}";
  }

  void _increaseDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
    _getOpenedTimesPerDay();
    _getOpenedTimesPerMonth();
  }

  void _decreaseDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
      _openedTimesPerDay = [];
      _closedTimesPerDay = [];
      _notAvailableTimesPerDay = [];
    });
    _getOpenedTimesPerDay();
    _getOpenedTimesPerMonth();
  }

  Widget _timeWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pickTimeButtonWidget("9:00"),
              _pickTimeButtonWidget("9:30"),
              _pickTimeButtonWidget("10:00"),
              _pickTimeButtonWidget("10:30"),
              _pickTimeButtonWidget("11:00"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pickTimeButtonWidget("11:30"),
              _pickTimeButtonWidget("12:00"),
              _pickTimeButtonWidget("12:30"),
              _pickTimeButtonWidget("13:00"),
              _pickTimeButtonWidget("13:30"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pickTimeButtonWidget("14:00"),
              _pickTimeButtonWidget("14:30"),
              _pickTimeButtonWidget("15:00"),
              _pickTimeButtonWidget("15:30"),
              _pickTimeButtonWidget("16:00"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pickTimeButtonWidget("16:30"),
              _pickTimeButtonWidget("17:00"),
              _pickTimeButtonWidget("17:30"),
              _pickTimeButtonWidget("18:00"),
              _pickTimeButtonWidget("18:30"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pickTimeButtonWidget("19:00"),
              _pickTimeButtonWidget("19:30"),
              _pickTimeButtonWidget("20:00"),
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
          height: _screenHeight * 0.033,
          width: _screenWidth * 0.15,
          alignment: Alignment.center,
          margin: EdgeInsets.all(_screenHeight * 0.004),
          decoration: BoxDecoration(
              color: _getTimeButtonColor(time),
              border: Border.all(color: _getTimeTextColor(time), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Text(
            time,
            style: TextStyle(color: _getTimeTextColor(time), fontSize: 12),
          ),
        ));
  }

  void _selectTime(String time) async {
    if (_selectedTimeStatus != null) {
      _setSelectedView(time);
    }
  }

  void _setSelectedView(String time) {
    DateTime now = DateTime.now();
    if (_selectedDate.year >= now.year &&
        _selectedDate.month >= now.month &&
        _selectedDate.day >= now.day)
      setState(() {
        if (_selectedTimeStatus == TimeStatus.OPENED) {
          _sendOnce(time, "открыто");
        } else if (_selectedTimeStatus == TimeStatus.CLOSED) {
          _sendOnce(time, "недоступно");
        } else if (_selectedTimeStatus == TimeStatus.NOT_AVAILABLE) {
          _sendOnce(time, "не открыто");
        }
      });
  }

  void _sendOnce(String time, String status) {
    UserRole.getUserRole().then((userRole) {
      if (userRole == UserRole.instructor) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        String dateString = DateFormat('ddMMyyyy').format(_selectedDate);
        _firebaseController.update(
            "$userRole/$userId/График работы/$dateString", {time: status});
      }
    });
    _getOpenedTimesPerDay();
  }

  void _getOpenedTimesPerDay() {
    _openedTimesPerDay = [];
    _notAvailableTimesPerDay = [];
    _closedTimesPerDay = [];
    UserRole.getUserRole().then((userRole) async {
      if (userRole == UserRole.instructor) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        String dateString = DateFormat('ddMMyyyy').format(_selectedDate);
        Map<dynamic, dynamic> timesMap = await _firebaseController
            .get("$userRole/$userId/График работы/$dateString");
        if (timesMap != null)
          timesMap.forEach((key, value) {
            if (value == 'открыто' && !_openedTimesPerDay.contains(key)) {
              _openedTimesPerDay.add(key);
            } else if (value == 'не открыто' &&
                !_notAvailableTimesPerDay.contains(key)) {
              _notAvailableTimesPerDay.add(key);
            } else if (value == 'недоступно' &&
                !_closedTimesPerDay.contains(key)) {
              _closedTimesPerDay.add(key);
            }
          });
        setState(() {});
      }
    });
  }

  void _getOpenedTimesPerMonth() {
    UserRole.getUserRole().then((userRole) async {
      if (userRole == UserRole.instructor) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        Map<dynamic, dynamic> timesMap =
            await _firebaseController.get("$userRole/$userId/График работы");
        if (timesMap != null) {
          setState(() {
            _fillMarkedDateMap(
                _getDatesWithOpenedRegistration(timesMap, userRole, userId));
          });
        }
      }
    });
  }

  List<DateTime> _getDatesWithOpenedRegistration(
      Map<dynamic, dynamic> allDates, String userRole, String userId) {
    DateTime now = DateTime.now();
    List<DateTime> markedDates = [];
    allDates.forEach((key, value) {
      String date = key.toString();
      String formattedDate =
          "${date.substring(4, 8)}-${date.substring(2, 4)}-${date.substring(0, 2)}";
      DateTime dateTime = DateTime.parse(formattedDate);
      if (dateTime.year <= now.year &&
          dateTime.month <= now.month &&
          dateTime.day < now.day) {
        _firebaseController.delete("$userRole/$userId/График работы/$date");
      } else
        (value as Map<dynamic, dynamic>).forEach((key, value) {
          if (value == 'открыто' && !markedDates.contains(dateTime)) {
            markedDates.add(dateTime);
          }
        });
    });
    return markedDates;
  }

  void _fillMarkedDateMap(List<DateTime> markedDates) {
    _markedDateMap.clear();
    for (var date in markedDates) {
      _markedDateMap.add(date, _createEvent(date));
    }
  }

  Event _createEvent(DateTime dateTime) {
    return Event(
        date: dateTime, dot: Container(), icon: _markedDateIcon(dateTime));
  }

  Widget _markedDateIcon(DateTime dateTime) {
    return Container(
      child: Center(
        child: Text(
          dateTime.day.toString(),
          style: TextStyle(
              color: _compareDateWithSelected(dateTime)
                  ? Colors.white
                  : Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
    );
  }

  bool _compareDateWithSelected(DateTime dateTime) {
    return dateTime.year == _selectedDate.year &&
        dateTime.month == _selectedDate.month &&
        dateTime.day == _selectedDate.day;
  }

  Color _getTimeButtonColor(String time) {
    return Colors.white;
  }

  Color _getTimeTextColor(String time) {
    if (_openedTimesPerDay.contains(time))
      return Colors.blue;
    else if (_closedTimesPerDay.contains(time))
      return Colors.red;
    else
      return Colors.grey;
  }

  Widget _changeStatusButtons() {
    return Container(
        child: Column(
      children: [
        _changeStatusButton(TimeStatus.OPENED, "открыта предварительная запись",
            "assets/instructor_set_time/e5.png"),
        _changeStatusButton(
            TimeStatus.CLOSED,
            "запись недоступна(занято,перерыв)",
            "assets/instructor_set_time/e4.png"),
        _changeStatusButton(
            TimeStatus.NOT_AVAILABLE,
            "предварительная запись не открыта",
            "assets/instructor_set_time/e15.png"),
      ],
    ));
  }

  Widget _changeStatusButton(
      TimeStatus timeStatus, String text, String iconPath) {
    return Container(
        height: _screenHeight * 0.033,
        margin: EdgeInsets.only(left: _screenWidth * 0.2),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeStatus = timeStatus;
            });
          },
          child: Row(
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _selectedTimeStatus == timeStatus ? 14 : 12),
              )
            ],
          ),
        ));
  }
}
