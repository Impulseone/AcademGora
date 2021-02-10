import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("АкадемГора")),
      body: Center(
          child: Text("Режим и условия работы. Схема проезда")
      ),
    );
  }
}