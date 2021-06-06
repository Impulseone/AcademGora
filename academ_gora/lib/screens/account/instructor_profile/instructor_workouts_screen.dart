import 'package:academ_gora/controller/firebase_controller.dart';
import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/model/workout.dart';
import 'package:academ_gora/screens/account/instructor_profile/instructor_profile_screen.dart';
import 'package:academ_gora/screens/account/instructor_profile/set_workout_time_screen.dart';
import 'package:academ_gora/screens/account/instructor_profile/workout_data_widget.dart';
import 'package:academ_gora/screens/auth/auth_screen.dart';
import 'package:academ_gora/screens/extension.dart';
import 'package:academ_gora/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import 'package:intl/intl.dart';

import '../../../main.dart';

class InstructorWorkoutsScreen extends StatefulWidget {
  const InstructorWorkoutsScreen({Key key}) : super(key: key);

  @override
  _InstructorWorkoutsScreenState createState() =>
      _InstructorWorkoutsScreenState();
}

class _InstructorWorkoutsScreenState extends State<InstructorWorkoutsScreen> {
  DateTime _selectedDate = DateTime.now();

  List _months = [
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

  List _weekdays = [
    'ПН',
    'ВТ',
    'СР',
    'ЧТ',
    'ПТ',
    'СБ',
    'ВС',
  ];

  List<Workout> _workouts = [];

  FirebaseController _firebaseController = FirebaseController();

  @override
  void initState() {
    super.initState();
    _getAllWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: screenDecoration("assets/instructor_profile/bg.png"),
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
      width: screenWidth * 0.7,
      height: screenHeight * 0.065,
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
                          fontSize: 13,
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
            height: screenWidth * 0.07,
            width: screenWidth * 0.07,
            child: Image.asset("assets/instructors_list/e_6.png"),
          ),
        ),
        Container(
            width: screenWidth * 0.38,
            alignment: Alignment.center,
            child: Text(_getSelectedDate())),
        GestureDetector(
          onTap: _increaseDate,
          child: Container(
            height: screenWidth * 0.07,
            width: screenWidth * 0.07,
            child: Image.asset("assets/instructors_list/e_7.png"),
          ),
        ),
      ],
    ));
  }

  String _getSelectedDate() {
    String month = _months[_selectedDate.month - 1];
    String weekday = _weekdays[_selectedDate.weekday - 1];
    return "${_selectedDate.day} $month ($weekday)";
  }

  void _increaseDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
    _getAllWorkouts();
  }

  void _decreaseDate() {
    if (_selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day)
      return;
    else {
      setState(() {
        _selectedDate = _selectedDate.subtract(Duration(days: 1));
      });
      _getAllWorkouts();
    }
  }

  Widget _redactProfileButton() {
    return Container(
      width: screenWidth * 0.65,
      height: screenHeight * 0.058,
      margin: EdgeInsets.only(top: 5),
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
      width: screenWidth * 0.5,
      height: screenHeight * 0.056,
      margin: EdgeInsets.only(top: 7),
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
          TextStyle(fontSize: screenHeight * 0.023, color: Colors.blue),
      weekdayTextStyle: TextStyle(color: Colors.black, fontSize: 14),
      locale: "ru",
      width: screenWidth * 0.55,
      height: screenHeight * 0.38,
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(color: Colors.black, fontSize: 14),
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => _selectedDate = date);
        _getAllWorkouts();
      },
      weekendTextStyle: TextStyle(color: Colors.black, fontSize: 14),
      daysTextStyle: TextStyle(color: Colors.black, fontSize: 14),
      selectedDateTime: _selectedDate,
      targetDateTime: _selectedDate,
      selectedDayTextStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _workoutsListWidget() {
    return Container(
        height: screenHeight * 0.22,
        width: screenWidth * 0.6,
        child: ListView.builder(
          itemCount: _workouts.length,
          itemBuilder: (context, index) {
            return WorkoutDataWidget(_workouts[index]);
          },
        ));
  }

  void _getAllWorkouts() async {
    UserRole.getUserRole().then((userRole) async {
      if (userRole == UserRole.instructor) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        Map<dynamic, dynamic> workoutsMap =
            await _firebaseController.get("$userRole/$userId/Занятия");
        List<Workout> workoutsList = [];
        workoutsMap.keys.forEach((element) {
          Workout workout = Workout.fromJson(workoutsMap[element]);
          workoutsList.add(workout);
        });
        setState(() {
          _workouts = _sortWorkoutsBySelectedDate(workoutsList);
        });
      }
    });
  }

  List<Workout> _sortWorkoutsBySelectedDate(List<Workout> list) {
    List<Workout> sortedWorkouts = [];
    list.forEach((workout) {
      String workoutDateString = workout.date;
      String now = DateFormat('ddMMyyyy').format(_selectedDate);
      if (now == workoutDateString) sortedWorkouts.add(workout);
    });
    return sortedWorkouts;
  }

  void _openAuthScreen() async {
    await FirebaseAuthUi.instance().logout().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => AuthScreen()), (route) => false);
    });
  }

  void _openRedactProfileScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => InstructorProfileScreen()));
  }

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
