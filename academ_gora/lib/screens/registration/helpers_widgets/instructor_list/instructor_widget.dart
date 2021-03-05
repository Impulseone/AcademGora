import 'package:academ_gora/model/reg_to_instructor_data.dart';
import 'package:academ_gora/screens/registration/helpers_widgets/instructor_list/datetime_picker_widget.dart';
import 'package:academ_gora/screens/registration/instructors_list_screen.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class InstructorWidget extends StatefulWidget {
  final String instructorName;
  final InstructorsListScreenState instructorsListScreenState;

  InstructorWidget(this.instructorName, this.instructorsListScreenState);

  @override
  InstructorWidgetState createState() => InstructorWidgetState();
}

class InstructorWidgetState extends State<InstructorWidget> {
  RegToInstructorData regToInstructorData;
  String instructorName;

  @override
  void initState() {
    super.initState();
    instructorName = widget.instructorName;
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: _header(widget.instructorName),
      expanded: _body(),
      tapHeaderToExpand: false,
      hasIcon: true,
    );
  }

  Widget _header(String text) {
    return Container(
        height: 65,
        child: Row(
          children: [
            Container(
                height: 48,
                width: 48,
                child: Image.asset("assets/instructors_list/e_3.png")),
            Container(
                width: 220,
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ));
  }

  Widget _body() {
    return Row(
      children: [_openProfileButton(), DateTimePickerWidget(this)],
    );
  }

  Widget _openProfileButton() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          image: DecorationImage(
            image: AssetImage("assets/instructors_list/e_9.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: 43,
        width: 67,
        padding: EdgeInsets.all(1),
        child: Text(
          "открыть\nпрофиль",
          style: TextStyle(color: Color(0xff007CC0),fontSize: 14),
        ),
      ),
    );
  }

  @override
  void setState(fn) {
    super.setState(fn);
    widget.instructorsListScreenState.setState(() {
      widget.instructorsListScreenState.regToInstructorData = regToInstructorData;
    });
  }
}
