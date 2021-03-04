import 'package:academ_gora/screens/registration/helpers_widgets/datetime_picker_widget.dart';
import 'package:academ_gora/screens/registration/instructors_list_screen.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class InstructorWidget extends StatefulWidget {
  final String instructorName;

  InstructorWidget(this.instructorName);

  @override
  InstructorWidgetState createState() => InstructorWidgetState();
}

class InstructorWidgetState extends State<InstructorWidget> {
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
      children: [
        _openProfileButton(),
        DateTimePickerWidget()
      ],
    );
  }

  Widget _openProfileButton() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10),
        height: 45,
        width: 65,
        color: Colors.grey,
        child: Text(
          "Открыть\nпрофиль",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
