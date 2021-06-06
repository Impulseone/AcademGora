import 'package:flutter/material.dart';

Decoration screenDecoration(String path){
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(path),
      fit: BoxFit.cover,
    ),
  );
}