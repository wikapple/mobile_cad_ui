import 'package:flutter/material.dart';

const Color backgroundColor = Color.fromRGBO(5, 10, 15, 1);
const Color surfaceColor = Color.fromRGBO(10, 17, 24, 1);
const Color primaryColor = Colors.lightBlue;
final Color altColor = Colors.orange[700]!;
final Color defaultTextColor = Colors.grey[300]!;

defaultTextStyle(
    {required Color color,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.normal,
    String fontFamily = "Roboto"}) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily);
}
