import 'package:academ_gora/screens/call_administration_screen.dart';
import 'package:academ_gora/screens/info_screen.dart';
import 'package:academ_gora/screens/price_screen.dart';
import 'package:academ_gora/screens/registration_to_instructor_screen.dart';
import 'package:academ_gora/screens/rest_zone_screen.dart';
import 'package:academ_gora/screens/schedule_screen.dart';
import 'package:flutter/material.dart';

import 'news_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> buttons = [];

  @override
  Widget build(BuildContext context) {
    fillButtons(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("АкадемГора"),
        ),
        body: ListView.builder(
            itemCount: buttons.length,
            itemBuilder: (ctx, index) {
              return buttons[index];
            }));
  }

  void fillButtons(BuildContext context) {
    buttons.add(Text("83952657066"));
    buttons.add(Text("https://www.instagram.com/akademgora/"));
    buttons.add(Text("https://vk.com/akademgora"));
    buttons.add(_openScreenWidget("Новости", context));
    buttons.add(_openScreenWidget("Информация", context));
    buttons.add(_openScreenWidget("Прайс и подарочные сертификаты", context));
    buttons.add(
        _openScreenWidget("Режим и условия работы. Схема проезда", context));
    buttons.add(_openScreenWidget("Зона отдыха и детского досуга", context));
    buttons.add(_openScreenWidget("Связаться с администрацией", context));
    buttons.add(_openScreenWidget("Запись к инструктору", context));
  }

  Widget _openScreenWidget(String text, BuildContext context) {
    return Container(
        height: 100,
        child: GestureDetector(
            child: Card(child: Text(text)),
            onTap: () {
              _openScreen(text, context);
            }));
  }

  void _openScreen(String screenName, BuildContext context) {
    switch (screenName) {
      case "Новости":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => NewsScreen()));
        break;
      case "Информация":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => InformationScreen()));
        break;
      case "Прайс и подарочные сертификаты":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => PriceScreen()));
        break;
      case "Режим и условия работы. Схема проезда":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => ScheduleScreen()));
        break;
      case "Зона отдыха и детского досуга":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => RestZoneScreen()));
        break;
      case "Связаться с администрацией":
        Navigator.of(context).push(
            MaterialPageRoute(builder: (c) => CallAdministrationScreen()));
        break;
      case "Запись к инструктору":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => RegistrationToInstructorScreen()));
        break;
    }
  }
}
