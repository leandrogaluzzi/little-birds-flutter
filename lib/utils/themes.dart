import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';

class Themes {
  static ThemeData app() {
    final ThemeData light = ThemeData.light();
    return light.copyWith(
      //appBarTheme: _appBar(),
      //tabBarTheme: _tabBar(),
      primaryIconTheme: _icon(),
      primaryColor: kColorYellowLittleBirds,
      primaryTextTheme: _text(),
    );
  }

  static TextTheme _text() {
    return TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        //fontSize: 26.0,
      ),
    );
  }

  /*static AppBarTheme _appBar() {
    return AppBarTheme(
      iconTheme: _icon(),
    );
  }

  static TabBarTheme _tabBar() {
    return TabBarTheme();
  }*/

  static IconThemeData _icon() {
    return IconThemeData(
      color: Colors.black,
    );
  }
}
