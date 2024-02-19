import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_1/realtimdatabase_future_builder/test_1.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // In this Project I manually Add Firebase with my Flutter App
  // The Code that contains key of firebase is removed 

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Test1Page(),
  ));
}
