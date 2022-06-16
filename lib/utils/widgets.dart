import 'package:flutter/cupertino.dart';

Widget text(
  String text, {
  Color? color,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.bold,
  TextAlign textAlign = TextAlign.left,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
