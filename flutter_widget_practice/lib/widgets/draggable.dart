import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget({super.key});

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  int b = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Draggable(
                data: 10,
                
                feedback: Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                  child: const Icon(Icons.directions_run),
                ),
                childWhenDragging: Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: Center(child: text("Initial State")),
                ),
              ),
              const SizedBox(width: 10),
              DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.green,
                    child: Center(child: text("Updated Value is $b")),
                  );
                },
                onAccept: (int data) {
                  setState(() {
                    b += data;
                    Fluttertoast.showToast(msg: 'Accepted');
                    log('ACCEPT');
                  });
                },
                onLeave: (data) {
                  Fluttertoast.showToast(msg: 'Leaved');
                  log('LEAVE');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
