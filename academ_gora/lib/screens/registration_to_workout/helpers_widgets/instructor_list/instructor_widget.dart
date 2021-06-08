import 'package:academ_gora/model/instructor.dart';
import 'package:academ_gora/model/reg_to_instructor_data.dart';
import 'package:academ_gora/screens/instructor_profile/instructor_profile_screen.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../instructors_list_screen.dart';
import 'datetime_picker_widget.dart';

class InstructorWidget extends StatefulWidget {
  final Instructor instructor;
  final InstructorsListScreenState instructorsListScreenState;

  InstructorWidget(this.instructor, this.instructorsListScreenState);

  @override
  InstructorWidgetState createState() => InstructorWidgetState(instructor);
}

class InstructorWidgetState extends State<InstructorWidget> {
  RegToInstructorData regToInstructorData;
  Instructor instructor;

  InstructorWidgetState(this.instructor);

  @override
  Widget build(BuildContext context) {
    regToInstructorData = widget.instructorsListScreenState.regToInstructorData;
    return ExpandablePanel(
      header: _header(),
      expanded: _body(),
      tapHeaderToExpand: false,
      hasIcon: true,
    );
  }

  Widget _header() {
    return Container(
        height: 65,
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => InstructorProfileScreen(instructor)));
                },
                child: Container(
                    height: screenHeight * 0.08,
                    width: screenHeight * 0.08,
                    child: Image.asset("assets/instructors_list/e_3.png"))),
            Container(
                width: screenWidth * 0.58,
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  instructor.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ));
  }

  Widget _body() {
    return Row(
      children: [_openProfileButton(), DateTimePickerWidget(this, instructor: instructor,)],
    );
  }

  Widget _openProfileButton() {
    return GestureDetector(
      onTap: _openProfile,
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
          style: TextStyle(color: Color(0xff007CC0), fontSize: 14),
        ),
      ),
    );
  }

  void _openProfile() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => InstructorProfileScreen(instructor)));
  }

  @override
  void setState(fn) {
    super.setState(fn);
    widget.instructorsListScreenState.setState(() {
      widget.instructorsListScreenState.regToInstructorData =
          regToInstructorData;
    });
  }
}
