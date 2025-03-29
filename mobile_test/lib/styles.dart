import 'package:flutter/material.dart';

abstract class Styles {
  // main color scheme for ThemeData 
  static const schemeMain = ColorScheme(
    brightness: Brightness.light, 
    primary: Color.fromRGBO(0, 0, 0, 1), 
    onPrimary: Color.fromRGBO(255, 201, 4, 1),
    secondary:  Color.fromRGBO(255, 201, 4, 1),
    onSecondary: Color.fromRGBO(0, 0, 0, 1), 
    tertiary: Color(0xFFB1B1B1),
    onTertiary: Color.fromRGBO(0, 0, 0, 1),
    error: Color.fromARGB(255, 255, 0, 0),
    onError: Color.fromARGB(255, 255, 98, 98),
    surface: Color.fromRGBO(236, 236, 236, 1),
    onSurface: Color.fromRGBO(255, 201, 4, 1),
  );

  // specifically the color we give for correct answer feedback
  static const correctColor = Colors.green;

  // text style for login/signup buttons 
  static final buttonTextStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.bold,
    color: schemeMain.onSecondary,
  );

  // small text style for login/signup pages
  static final smallTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Mulish',
    fontWeight: FontWeight.normal,
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
  static final fieldTextStyle = TextStyle(
    fontSize: 30,
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

  //general lightweight text
  static const generalTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Mulish',
    color: Colors.black,
  );

  //text for hyperlinks
  static const linkTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Mulish',
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
  );

  // shape for login/signup buttons
  static final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10)
  );

  // button style for login (yellow)
  static final yellowButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: schemeMain.secondary,
      shape: buttonShape,
      textStyle: buttonTextStyle
  );

  static final grayButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: schemeMain.tertiary,
      shape: buttonShape,
      textStyle: buttonTextStyle
  );
}
