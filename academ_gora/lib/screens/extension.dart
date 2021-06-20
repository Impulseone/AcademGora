import 'package:flutter/material.dart';

Decoration screenDecoration(String path){
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(path),
      fit: BoxFit.cover,
    ),
  );
}

List months = [
  'Января',
  'Февраля',
  'Марта',
  'Апреля',
  'Мая',
  'Июня',
  'Июля',
  'Августа',
  'Сентября',
  'Октября',
  'Ноября',
  'Декабря'
];

List weekdays = [
  'ПН',
  'ВТ',
  'СР',
  'ЧТ',
  'ПТ',
  'СБ',
  'ВС',
];