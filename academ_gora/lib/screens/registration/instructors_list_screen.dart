import 'package:flutter/material.dart';

class InstructorsListScreen extends StatefulWidget {
  @override
  _InstructorsListScreenState createState() => _InstructorsListScreenState();
}

class _InstructorsListScreenState extends State<InstructorsListScreen> {

  final items = List<String>.generate(10, (i) => "Item $i");

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
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
