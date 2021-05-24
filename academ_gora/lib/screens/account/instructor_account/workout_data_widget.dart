import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WorkoutDataWidget extends StatefulWidget {
  const WorkoutDataWidget({Key key}) : super(key: key);

  @override
  _WorkoutDataWidgetState createState() => _WorkoutDataWidgetState();
}

class _WorkoutDataWidgetState extends State<WorkoutDataWidget> {
  bool isExpanded = false;
  Icon _expandedIcon = Icon(Icons.keyboard_arrow_down);
  double _screenHeight;
  double _screenWidth;
  ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _setExpandedIconListener();
    return _workoutWidget();
  }

  Widget _workoutWidget() {
    return Container(
        child: ExpandablePanel(
      header: _header(),
      expanded: _body(),
      tapHeaderToExpand: true,
      hasIcon: false,
      controller: _expandableController,
    ));
  }

  Widget _header() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 6),
        height: 30,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "20.20.20",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "11:30-12:30",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: EdgeInsets.only(left: _screenWidth * 0.05),
                child: _expandedIcon)
          ],
        ));
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
        width: _screenWidth * 0.6,
        decoration: BoxDecoration(color: Colors.white70),
        child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Анастасия, Мария"),
                Text("+79999999999"),
                Text("Количество человек: 2"),
                Text("Возраст: 25, 22"),
                Text("Продолжительность: 1 час"),
                Text("Уровень катания: умею"),
              ],
            )));
  }

  void _setExpandedIconListener() {
    _expandableController.addListener(() {
      if (_expandableController.value) {
        setState(() {
          _expandedIcon = Icon(Icons.keyboard_arrow_up);
        });
      } else {
        setState(() {
          _expandedIcon = Icon(Icons.keyboard_arrow_down);
        });
      }
    });
  }
}
