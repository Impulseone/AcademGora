import 'package:academ_gora/screens/main_screen.dart';
import 'package:flutter/material.dart';

class InputPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("АкадемГора")),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Введите код"),
            ),
            ElevatedButton(
                child: Text("Вход"), onPressed: (){_openMainScreen(context);})
          ],
        ),
      ),
    );
  }

  void _openMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => MainScreen()),(Route<dynamic> route) => false);
  }
}
