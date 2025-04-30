import 'package:flutter/material.dart';

const Color ourMainColor = Color(0xFF008F99);


const Color ourBackgroundColor =Color(0xfff2f2f2);


final List<Color> gradientColors = [firstGradientColor, secondGradientColor];
Color firstGradientColor = Colors.blue.shade200;
Color secondGradientColor = Colors.blue.shade400;

Color mainColor = Colors.blue.shade300;
Color secondColor = Colors.blue.shade700;
OutlineInputBorder customBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.black),
  borderRadius: BorderRadius.circular(10), // Change to your desired color
);
