import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class SecondScreenofHero extends StatelessWidget {
  const SecondScreenofHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Second Screen of Hero Widget'),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: double.maxFinite,
          color: Colors.blue,
          child: Hero(tag: 'naruto', child: Image.asset('assets/naruto.jpg')),
        ),
      ),
    );
  }
}
