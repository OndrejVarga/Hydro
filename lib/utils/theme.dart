import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTheme {
  ThemeData theme;

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: HexColor('#222831'),
      primaryColor: HexColor('#2B323D'),
      accentColor: HexColor('#03DAC5'),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w800,
            fontSize: 30),
        headline2: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
      //Oválne buttony
      buttonTheme: ButtonTheme.of(context).copyWith(
        textTheme: ButtonTextTheme.primary,
        buttonColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
