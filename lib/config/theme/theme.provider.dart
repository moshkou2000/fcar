import 'package:flutter/material.dart';
import 'color.module.dart';

final themeData = ThemeData(
  // This is the theme of your application.
  //
  // TRY THIS: Try running your application with "flutter run". You'll see
  // the application has a blue toolbar. Then, without quitting the app,
  // try changing the seedColor in the colorScheme below to Colors.green
  // and then invoke "hot reload" (save your changes or press the "hot
  // reload" button in a Flutter-supported IDE, or press "r" if you used
  // the command line to start the app).
  //
  // Notice that the counter didn't reset back to zero; the application
  // state is not lost during the reload. To reset the state, use hot
  // restart instead.
  //
  // This works for code too, not just values: Most code changes can be
  // tested with just a hot reload.
  colorScheme: ColorScheme.fromSeed(seedColor: ThemeColor.primary),
  appBarTheme: const AppBarTheme(
    color: ThemeColor.primary,
    elevation: 0,
    centerTitle: true,
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
);

final darkThemeData = ThemeData(brightness: Brightness.dark);
