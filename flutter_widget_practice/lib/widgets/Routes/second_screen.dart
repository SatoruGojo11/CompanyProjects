import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/first');
            Navigator.pop(context);
          },
          child: text('Back'),
        ),
      ),
    );
  }
}
