import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class Test2Widget extends StatefulWidget {
  const Test2Widget({super.key});

  @override
  State<Test2Widget> createState() => _Test2WidgetState();
}

class _Test2WidgetState extends State<Test2Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: text('Hello these is Test 2 Page'),
      ),
    );
  }
}
