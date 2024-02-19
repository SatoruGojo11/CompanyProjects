// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/test_2.dart';
import 'package:flutter_widget_practice/widgets/Hero/first_screen.dart';
import 'package:flutter_widget_practice/widgets/Routes/first_screen.dart';
import 'package:flutter_widget_practice/widgets/Routes/second_screen.dart';
import 'package:flutter_widget_practice/widgets/draggable_scrollable_sheet.dart';
import 'package:flutter_widget_practice/widgets/flexible.dart';
import 'package:flutter_widget_practice/widgets/interactive_viewer.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Test2Widget(),
      // initialRoute: '/',
      routes: {
        '/first': (context) =>
            const FirstScreen(), // We can't use '/' & initialRoute Property, when we use home property of MaterialApp Widget.
        '/second': (context) => const SecondScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 8,
        ),
        scaffoldBackgroundColor: Colors.yellow[100],
      ),
    ),
  );
}
