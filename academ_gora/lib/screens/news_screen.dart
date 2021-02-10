import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("АкадемГора")),
      body: Center(
        child: Text("Новости")
      ),
    );
  }
}
