import 'package:academ_gora/screens/auth/password_screen.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("АкадемГора")),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Введите номер телефона"),
            ),
            ElevatedButton(
                child: Text("Получить код"),
                onPressed: () {
                  _getCode(context);
                })
          ],
        ),
      ),
    );
  }

  void _getCode(BuildContext context) {
    //TODO: Firebase auth
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => InputPasswordScreen()));
  }
}
