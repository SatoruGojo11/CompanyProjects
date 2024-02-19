import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_1/realtimdatabase_future_builder/test_1.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // In this Project I manually Add Firebase with my Flutter App
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD0Pje2uEUpYMTPy1gLNMdf0Qv54HrYAn4",
      appId: "1:450937056048:android:651bf228b74fe3dec5f6f5",
      messagingSenderId: "450937056048",
      projectId: "jaydip-firebase-project-1",
    ),
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Test1Page(),
  ));
}
