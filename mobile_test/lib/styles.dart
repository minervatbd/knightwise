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

  // text style for login/signup buttons 
  static const buttonTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
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
      backgroundColor: schemeMain.onSecondary,
      shape: buttonShape,
      textStyle: buttonTextStyle
  );
}
