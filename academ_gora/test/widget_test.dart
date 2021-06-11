// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:academ_gora/controller/firebase_requests_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:academ_gora/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var instructors = {};
    Firebase.initializeApp().then((_) {
      FirebaseRequestsController().get("Инструкторы").then((value) {
        instructors = value;
        print(instructors);
        expect(true, instructors.length>0);
      });
    });
  });
}
