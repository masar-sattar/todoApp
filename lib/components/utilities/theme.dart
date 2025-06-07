import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "DMSans",
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      color: const Color.fromARGB(255, 171, 58, 241),
      borderRadius: BorderRadius.circular(50),
    ),
    labelPadding: EdgeInsets.zero,
    overlayColor: WidgetStateColor.transparent,
  ),
);
