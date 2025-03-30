import 'package:flutter/material.dart';

abstract class Styles {
  // main color scheme for ThemeData
  static const schemeMain = ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(0, 0, 0, 1),
      onPrimary: Color.fromRGBO(0, 0, 0, 1),
      secondary: Color.fromRGBO(255, 201, 4, 1),
      onSecondary: Color(0xFFB1B1B1),
      error: Color.fromARGB(255, 255, 0, 0),
      onError: Color.fromARGB(255, 255, 98, 98),
      surface: Color.fromRGBO(236, 236, 236, 1),
      onSurface: Color.fromRGBO(255, 201, 4, 1)
  );

  static const correctColor = Colors.green;

  // text style for login/signup buttons
  static const buttonTextStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // small text style for login/signup pages
  static final smallTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  // small text style for login/signup pages
  static final smallBoldTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // small text for hyperlinks for login/signup pages
  static const linkSmallTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Mulish',
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
  );

  // text style for text field hints
  static const fieldTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  // large text style for time in dashboard
  static const timeTextStyle = TextStyle(
    fontSize: 40,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // large text style for time labels in dashboard
  static const timeLabelTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // large text style for general headers
  static const headerTextStyle = TextStyle(
    fontSize: 50,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const generalTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Mulish',
    color: Colors.black,
  );

  static const linkTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Mulish',
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
  );

  // shape for login/signup buttons
  static final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),

  );

  // button style for login (yellow)
  static final yellowButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: schemeMain.secondary,
      shape: buttonShape,
      textStyle: buttonTextStyle
  );

  static final grayButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: schemeMain.onSecondary,
      shape: buttonShape,
      textStyle: buttonTextStyle
  );
}
