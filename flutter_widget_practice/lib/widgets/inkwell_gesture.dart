import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InkWellGesturePage extends StatelessWidget {
  const InkWellGesturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            text(
              'Widget Practice',
              fontsize: 30,
              clr: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 30),
            InkWell(
              hoverColor: Colors.green,
              highlightColor: Colors.red,
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Fluttertoast.showToast(msg: 'Inkwell Clicked...');
              },
              child: Center(
                child: text(
                  'Inkwell',
                  fontWeight: FontWeight.bold,
                  fontsize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 50,
              width: 300,
              color: Colors.teal,
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: 'Gesture Detector Clicked...',
                    toastLength: Toast.LENGTH_SHORT,
                  );
                },
                child: Center(
                  child: text(
                    'Gesture Detector',
                    fontWeight: FontWeight.bold,
                    fontsize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
