import 'package:academ_gora/model/user_role.dart';
import 'package:academ_gora/model/workout.dart';
import 'package:academ_gora/times_map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'helpers_widgets/horizontal_divider.dart';
import 'helpers_widgets/reg_parameters/human_info_widget.dart';
import 'helpers_widgets/reg_parameters/info_text.dart';
import 'helpers_widgets/reg_parameters/select_duration_widget.dart';
import 'helpers_widgets/reg_parameters/select_level_of_skating_widget.dart';
import 'helpers_widgets/reg_parameters/select_people_count_widget.dart';
import 'reg_final_screen.dart';

class RegistrationParametersScreen extends StatefulWidget {
  @override
  RegistrationParametersScreenState createState() =>
      RegistrationParametersScreenState();
}

class RegistrationParametersScreenState
    extends State<RegistrationParametersScreen> {
  final dbRef = FirebaseDatabase.instance.reference();

  WorkoutSingleton workoutSingleton = WorkoutSingleton();

  List<Pair> textEditingControllers = [];
  List<Visitor> visitors = [];
  int peopleCount = 0;
  int duration;
  int levelOfSkating;
  double _screenHeight;
  double _screenWidth;

  TextEditingController _commentController = TextEditingController();
  TimesController _timesController = TimesController();

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/registration_parameters/0_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              width: _screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _infoWidget(),
                    Container(
                        margin: EdgeInsets.only(top: 12, left: 5),
                        child: SelectPeopleCountWidget(peopleCount, this)),
                    horizontalDivider(
                        10, 10, _screenHeight * 0.015, _screenHeight * 0.015),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: SelectDurationWidget(duration, this)),
                    horizontalDivider(
                        10, 10, _screenHeight * 0.015, _screenHeight * 0.015),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child:
                            SelectLevelOfSkatingWidget(levelOfSkating, this)),
                    horizontalDivider(
                        10, 10, _screenHeight * 0.015, _screenHeight * 0.015),
                    Container(
                        height: _screenHeight * 0.19,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(3),
                            itemCount: peopleCount,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(left: 25),
                                child: HumanInfoWidget(
                                    index + 1, textEditingControllers, this),
                              );
                            })),
                    _commentFieldWidget(),
                    _continueButton()
                  ],
                ),
              ))),
    );
  }

  Widget _infoWidget() {
    return Container(
        margin: EdgeInsets.only(top: _screenHeight * 0.05),
        width: _screenWidth * 0.9,
        height: _screenHeight * 0.25,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage("assets/registration_parameters/e_1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: _screenWidth * 0.16),
                    child:
                        Image.asset("assets/registration_parameters/e_2.png")),
                Container(
                    child: Text(
                  InfoText.getLevelText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: _screenHeight * 0.018),
                ))
              ],
            ),
            Text(
              InfoText.getText(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _screenHeight * 0.018),
            ),
            Text(
              InfoText.getAge(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: _screenHeight * 0.018),
            ),
          ],
        ));
  }

  Widget _commentFieldWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Container(
              height: 20,
              width: 20,
              child: Image.asset("assets/registration_parameters/e12.png")),
          Container(
            width: _screenWidth * 0.85,
            height: _screenHeight * 0.05,
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              controller: _commentController,
              maxLines: 10,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                  hintText: "Добавить комментарий",
                  hintStyle: TextStyle(fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _continueButton() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _onBackPressed,
              child: Container(
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
            Container(
              width: 170,
              height: _screenHeight * 0.06,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: _continueButtonBackgroundColor(),
                child: InkWell(
                    onTap: peopleCount != null &&
                            levelOfSkating != null &&
                            duration != null &&
                            _checkTextControllers()
                        ? _sendData
                        : null,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ПРОДОЛЖИТЬ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _continueButtonTextColor(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    )),
              ),
            )
          ],
        ));
  }

  void _sendData(){
    workoutSingleton.peopleCount = peopleCount;
    workoutSingleton.levelOfSkating = levelOfSkating;
    _sendWorkoutDataToUser().then((_) {
      _sendWorkoutDataToInstructor().then((_) {
        _openRegFinalScreen();
      });
    });
  }

  void _openRegFinalScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => RegistrationFinalScreen()),
        (route) => false);
  }

  Future<void> _sendWorkoutDataToUser() async {
    await UserRole.getUserRole().then((userRole) => {
          FirebaseDatabase.instance
              .reference()
              .child(
                  "$userRole/${FirebaseAuth.instance.currentUser.uid}/Занятия/${workoutSingleton.id}")
              .set({
            "id": workoutSingleton.id,
            "Телефон инструктора": workoutSingleton.instructorPhoneNumber,
            "Вид спорта": workoutSingleton.sportType,
            "Время": _getWorkoutTime(),
            "Дата": workoutSingleton.date,
            "Инструктор": workoutSingleton.instructorName,
            "Количество человек": workoutSingleton.peopleCount,
            "Посетители": _humansMap(),
            "Уровень катания": levelOfSkating,
            "Комментарий": _commentController.text
          })
        });
  }

  Future<void> _sendWorkoutDataToInstructor() async {
    FirebaseDatabase.instance
        .reference()
        .child(
            "Инструкторы/${workoutSingleton.instructorId}/Занятия/Занятие ${workoutSingleton.id}")
        .set({
      "Вид спорта": workoutSingleton.sportType,
      "Время": _getWorkoutTime(),
      "Дата": workoutSingleton.date,
      "Количество человек": workoutSingleton.peopleCount,
      "Посетители": _humansMap(),
      "Уровень катания": levelOfSkating,
      "Комментарий": _commentController.text,
      "Продолжительность": workoutSingleton.workoutDuration,
      "Телефон": FirebaseAuth.instance.currentUser.phoneNumber
    });
    FirebaseDatabase.instance
        .reference()
        .child(
            "Инструкторы/${workoutSingleton.instructorId}/График работы/${workoutSingleton.date}")
        .update(_closeTimesMap());
  }

  Map<String,dynamic>_closeTimesMap(){
    Map<String,dynamic> map = {};
    int duration = workoutSingleton.workoutDuration;
    if (duration==1){
      map.putIfAbsent("${workoutSingleton.from}", () => "недоступно");
      map.putIfAbsent("${_timesController.getTimeByValue(_timesController.times[workoutSingleton.from]-1)}", () => "недоступно");
      map.putIfAbsent("${_timesController.getTimeByValue(_timesController.times[workoutSingleton.from]+1)}", () => "недоступно");
    }
    if (duration==2){
      map.putIfAbsent("${workoutSingleton.from}", () => "недоступно");
      map.putIfAbsent("${_timesController.getTimeByValue(_timesController.times[workoutSingleton.from]-1)}", () => "недоступно");
      map.putIfAbsent("${_timesController.getTimeByValue(_timesController.times[workoutSingleton.from]+1)}", () => "недоступно");
      map.putIfAbsent("${_timesController.getTimeByValue(_timesController.times[workoutSingleton.from]+2)}", () => "недоступно");
      map.putIfAbsent("${_timesController.getTimeByValue(_timesController.times[workoutSingleton.from]+3)}", () => "недоступно");
    }
     return map;
  }

  String _getWorkoutTime() {
    String from = workoutSingleton.from;
    int duration = workoutSingleton.workoutDuration;
    String to = _timesController.getTimeByValue(_timesController.times[from]+duration*2);
    return "$from-$to";
  }

  Map<String, dynamic> _humansMap() {
    _checkTextControllers(addHumans: _addVisitors);
    Map<String, dynamic> map = {};
    for (var i = 0; i < visitors.length; ++i) {
      var human = visitors[i];
      map.putIfAbsent(
          "Посетитель ${i + 1}",
          () => {
                "Имя": human.name,
                "Возраст": human.age,
              });
    }
    return map;
  }

  Color _continueButtonBackgroundColor() {
    if (peopleCount != null &&
        levelOfSkating != null &&
        duration != null &&
        _checkTextControllers())
      return Colors.blue;
    else
      return Colors.white;
  }

  Color _continueButtonTextColor() {
    if (peopleCount != null &&
        levelOfSkating != null &&
        duration != null &&
        _checkTextControllers())
      return Colors.white;
    else
      return Colors.grey;
  }

  bool _checkTextControllers({Function addHumans}) {
    if (textEditingControllers.isNotEmpty) {
      List<bool> conditions = [];
      for (var i = 0; i < peopleCount; ++i) {
        bool condition = textEditingControllers[i].left.text.isNotEmpty &&
            textEditingControllers[i].right.text.isNotEmpty &&
            isNumericUsing_tryParse(textEditingControllers[i].right.text);
        conditions.add(condition);
        if (addHumans != null && condition) {
          addHumans.call(textEditingControllers[i].left.text,
              int.parse(textEditingControllers[i].right.text));
        }
      }
      if (conditions.contains(false))
        return false;
      else
        return true;
    } else
      return false;
  }

  void _addVisitors(String name, int age) {
    Visitor visitor = Visitor(name, age);
    if (!visitors.contains(visitor)) visitors.add(visitor);
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }
}

bool isNumericUsing_tryParse(String string) {
  if (string == null || string.isEmpty) {
    return false;
  }
  final number = num.tryParse(string);

  if (number == null) {
    return false;
  }
  return true;
}

//TODO: refactor move in other file
class Pair {
  Pair(this.left, this.right);

  final TextEditingController left;
  final TextEditingController right;
}
