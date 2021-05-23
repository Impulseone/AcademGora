import 'package:academ_gora/screens/account/instructor_account/set_workout_time_screen.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class InstructorAccountScreen extends StatefulWidget {
  const InstructorAccountScreen({Key key}) : super(key: key);

  @override
  _InstructorAccountScreenState createState() =>
      _InstructorAccountScreenState();
}

class _InstructorAccountScreenState extends State<InstructorAccountScreen> {
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
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/instructor_profile/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _logoutButton(),
          _myRegistrationsTitle(),
          _changeRegistrationTimeButton(),
          _calendar(),
          _dateSliderWidget(),
          _workoutsListWidget(),
          _redactProfileButton(),
          _backToMainButton()
        ],
      ),
    ));
  }

  Widget _myRegistrationsTitle() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          "Мои записи",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }

  Widget _changeRegistrationTimeButton() {
    return Container(
      width: _screenWidth * 0.7,
      height: _screenHeight * 0.07,
      margin: EdgeInsets.only(top: 12),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openSetWorkoutTimeScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ОТКРЫТЬ/ИЗМЕНИТЬ\n ДОСТУПНОЕ ВРЕМЯ ЗАПИСИ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _dateSliderWidget() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _decreaseDate,
          child: Container(
            height: _screenWidth * 0.07,
            width: _screenWidth * 0.07,
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
            height: _screenWidth * 0.07,
            width: _screenWidth * 0.07,
            child: Image.asset("assets/instructors_list/e_7.png"),
          ),
        ),
      ],
    ));
  }

  Widget _workoutsListWidget() {
    return Container(
        height: _screenHeight * 0.25,
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return _workoutWidget();
          },
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

  Widget _redactProfileButton() {
    return Container(
      width: _screenWidth * 0.65,
      height: _screenHeight * 0.065,
      margin: EdgeInsets.only(top: 18),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openRedactProfileScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "РЕДАКТИРОВАТЬ ПРОФИЛЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _backToMainButton() {
    return Container(
      width: _screenWidth * 0.5,
      height: _screenHeight * 0.06,
      margin: EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.blue,
        child: InkWell(
            onTap: _openMainScreen,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "НА ГЛАВНУЮ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget _logoutButton() {
    return GestureDetector(
        onTap: _openAuthScreen,
        child: Container(
            margin: EdgeInsets.only(top: 40, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "ВЫЙТИ",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    height: 20,
                    width: 20,
                    child: Icon(Icons.logout))
              ],
            )));
  }

  Widget _calendar() {
    return CalendarCarousel<Event>(
      selectedDayButtonColor: Colors.blue,
      headerMargin: EdgeInsets.all(0),
      headerTextStyle:
          TextStyle(fontSize: _screenHeight * 0.023, color: Colors.blue),
      weekdayTextStyle: TextStyle(color: Colors.black, fontSize: 12),
      locale: "ru",
      width: _screenWidth * 0.6,
      height: _screenHeight * 0.3,
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(color: Colors.black, fontSize: 12),
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => _selectedDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(color: Colors.black, fontSize: 12),
      daysTextStyle: TextStyle(color: Colors.black, fontSize: 12),
      prevDaysTextStyle: TextStyle(color: Colors.black, fontSize: 12),
      nextDaysTextStyle: TextStyle(color: Colors.black, fontSize: 12),
      selectedDateTime: _selectedDate,
      targetDateTime: _selectedDate,
      selectedDayTextStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _workoutWidget() {
    return ExpandablePanel(
      header: _header(),
      expanded: _body(),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }

  Widget _header() {
    return Text("20.20.20 11:30-12:30");
  }

  Widget _body() {
    return Text("Анастасия, Мария");
  }

  void _openAuthScreen() async {
    await FirebaseAuthUi.instance().logout().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
    });
  }

  void _openRedactProfileScreen() {}

  void _openSetWorkoutTimeScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SetWorkoutTimeScreen()));
  }

  void _openMainScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false);
  }
}
