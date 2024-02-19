import 'package:flutter/material.dart';
import 'package:flutter_demo_task/screens/registration_page.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegistrationPage(
        recentuserdata: [],
      ),
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
