import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {

  final List<Widget> buttons = [];

  @override
  Widget build(BuildContext context) {
    fillButtons();
    return Scaffold(
      appBar: AppBar(
        title: Text("АкадемГора"),
      ),
      body: ListView.builder(itemCount: buttons.length, itemBuilder: (ctx,index){
        return buttons[index];
      })
    );
  }

  void fillButtons(){
    buttons.add(Text("83952657066"));
    buttons.add(Text("https://www.instagram.com/akademgora/"));
    buttons.add(Text("https://vk.com/akademgora"));
    buttons.add(_openScreenWidget("Новости"));
    buttons.add(_openScreenWidget("Информация"));
    buttons.add(_openScreenWidget("Прайс и подарочные сертификаты"));
    buttons.add(_openScreenWidget("Режим и условия работы. Схема проезда"));
    buttons.add(_openScreenWidget("Зона отдыха и детского досуга"));
    buttons.add(_openScreenWidget("Связаться с администрацией"));
    buttons.add(_openScreenWidget("Запись к инструктору"));
  }

  Widget _openScreenWidget(String text){
   return Container(height: 100, child: Card(child: Text(text)));
  }
}
