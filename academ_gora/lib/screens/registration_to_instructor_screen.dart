import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;

class RegistrationToInstructorScreen extends StatefulWidget {
  @override
  _RegistrationToInstructorScreenState createState() =>
      _RegistrationToInstructorScreenState();
}

class _RegistrationToInstructorScreenState
    extends State<RegistrationToInstructorScreen> {
  int _kindOfSportSelected = -1;
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/registration_to_instructor/1_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _topImages(),
          _kindOfSportButtons(),
          _horizontalDivider(),
          _dateWidget(),
          _horizontalDivider(),
          _timeWidget(),
          _warningText(),
          _continueButton(),
          _selectCoachButton()
        ],
      ),
    ));
  }


  Widget _topImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _kindOfSportImage("assets/registration_to_instructor/2_ski.png"),
        _kindOfSportImage("assets/registration_to_instructor/2_snowboard.png",
            marginLeft: 18)
      ],
    );
  }

  Widget _kindOfSportImage(String imagePath, {double marginLeft = 0}) {
    return Container(
      margin: EdgeInsets.only(top: 60, left: marginLeft),
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        height: 160,
        width: 160,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _kindOfSportButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_kindOfSportButton(0), _kindOfSportButton(1, leftMargin: 40)],
    );
  }

  Widget _kindOfSportButton(int which, {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: GestureDetector(
        onTap: () => _selectKindOfSport(which),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_createBackgroundOfKindOfSportButton(which)),
                fit: BoxFit.fill),
          ),
          height: 40,
          width: 140,
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Text(
            which == 0 ? "ГОРНЫЕ ЛЫЖИ" : "СНОУБОРД",
            style: TextStyle(
                fontSize: 11,
                color: which == _kindOfSportSelected
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }

  void _selectKindOfSport(int which) {
    setState(() {
      _kindOfSportSelected = which;
    });
  }

  String _createBackgroundOfKindOfSportButton(int which) {
    return which == _kindOfSportSelected
        ? "assets/registration_to_instructor/3_e2.png"
        : "assets/registration_to_instructor/3_e1.png";
  }



  Widget _horizontalDivider() {
    return Container(
      color: Colors.grey,
      height: 1,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
    );
  }



  Widget _dateWidget() {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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



  Widget _timeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeNameWidget(),
        _timeField(50, 10),
        Text("-"),
        _timeField(10, 0)
      ],
    );
  }

  Widget _timeNameWidget() {
    return Row(
      children: [
        Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 10),
            child: Image.asset("assets/registration_to_instructor/4_e4.png")),
        Container(
            margin: EdgeInsets.only(right: 8),
            child: Text(
              "ВРЕМЯ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget _timeField(double leftMargin, double rightMargin) {
   return Container(
      width: 80,
      height: 30,
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }



  Widget _warningText() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          "Укажите конкретное время или желаемый интервал для начала занятия",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.lightBlue),
        ));
  }



  Widget _continueButton() {
    return Container(
      width: 300.0,
      height: 60,
      margin: EdgeInsets.only(top: 25),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
        child: InkWell(
            onTap: null,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ПРОДОЛЖИТЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )),
      ),
    );
  }



  Widget _selectCoachButton() {
    return Container(
      width: 300.0,
      height: 60,
      margin: EdgeInsets.only(top: 15),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(35)),
        color: Colors.lightBlue,
        child: InkWell(
            onTap: null,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _selectCoachText("выбрать определенного"),
                    _selectCoachText("инструктора")
                  ]),
            )),
      ),
    );
  }

  Widget _selectCoachText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
