import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/model/workout.dart';
import 'package:academ_gora/screens/account/helpers_widgets/workout_info.dart';
import 'package:academ_gora/screens/account/update_workout_screen.dart';
import 'package:academ_gora/screens/account/user_account_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WorkoutWidget extends StatefulWidget {
  final Workout workout;
  final UserAccountScreenState userAccountScreenState;

  const WorkoutWidget(
      {Key key, @required this.workout, @required this.userAccountScreenState})
      : super(key: key);

  @override
  _WorkoutWidgetState createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  double height;
  double width;

  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/account/e2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        _titleRow(),
        _countOfPeople(),
        _redactButtons(),
        _infoTextColumn(),
        _instructorInfoWidget(),
        _callToInstructorButtons()
      ]),
    );
  }

  Widget _titleRow() {
    return Container(
        color: Colors.blue,
        height: 40,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  widget.workout.date,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
            Container(
                margin: EdgeInsets.only(left: width / 7),
                child: Text(widget.workout.from,
                    style: TextStyle(color: Colors.white, fontSize: 22)))
          ],
        ));
  }

  Widget _countOfPeople() {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Количество человек",
                  style: TextStyle(fontSize: 18),
                )),
            Container(
              margin: EdgeInsets.only(left: width / 6),
              child: Text(widget.workout.peopleCount.toString(),
                  style: TextStyle(fontSize: 18)),
            ),
          ],
        ));
  }

  Widget _redactButtons() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            _button("РЕДАКТИРОВАТЬ", 10, _openUpdateWorkoutScreen),
            _button("ОТМЕНИТЬ", width / 8, _showCancelWorkoutDialog),
          ],
        ));
  }

  void _openUpdateWorkoutScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => UpdateWorkoutScreen(widget.workout)));
  }

  Widget _button(String text, double leftMargin, Function function) {
    return GestureDetector(
      onTap: () {
        function.call();
      },
      child: Container(
        alignment: Alignment.center,
        height: 30,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: leftMargin),
        decoration: BoxDecoration(color: Colors.blue),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _showCancelWorkoutDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Отменить занятие?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              child: Text(
                'Да',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                _cancelWorkout();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Нет', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _cancelWorkout() async {
    await UserRole.getUserRole().then((userRole) {
      if (userRole == UserRole.user) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        dbRef
            .child("$userRole/$userId/Занятия/${widget.workout.id}")
            .remove()
            .then((value) {
          widget.userAccountScreenState.setState(() {});
        });
      }
    });
  }

  Widget _infoTextColumn() {
    return Container(
        margin: EdgeInsets.only(top: 8, left: 10),
        child: _infoText(WorkoutInfo.getWorkoutInfo()));
  }

  Widget _infoText(String text) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(fontSize: 11),
        ));
  }

  Widget _instructorInfoWidget() {
    return Container(
        width: width * 0.9,
        margin: EdgeInsets.only(left: 10, top: 5),
        child: Row(
          children: [
            Text(
              "Инструктор:\n(${widget.workout.sportType})",
              style: TextStyle(fontSize: 14),
            ),
            Container(
                width: width * 0.4,
                margin: EdgeInsets.only(left: 45),
                child: Text(
                  widget.workout.instructorName,
                  style: TextStyle(fontSize: 14),
                )),
          ],
        ));
  }

  Widget _callToInstructorButtons() {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, bottom: 5),
      child: Row(children: [_phoneNumberButton(), _whatsAppButton()]),
    );
  }

  Widget _phoneNumberButton() {
    return Container(
        alignment: Alignment.center,
        height: 30,
        width: width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: AssetImage("assets/account/phone.png"),
          ),
        ),
        child: Text(
          widget.workout.instructorPhoneNumber,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ));
  }

  Widget _whatsAppButton() {
    return Container(
        alignment: Alignment.center,
        height: 30,
        width: width * 0.35,
        margin: EdgeInsets.only(left: width * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: AssetImage("assets/account/wa.png"),
          ),
        ),
        child: Text(
          "Написать",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ));
  }
}
