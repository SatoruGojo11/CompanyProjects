import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DismissibleWidget extends StatefulWidget {
  const DismissibleWidget({super.key});

  @override
  State<DismissibleWidget> createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> {
  List<int> ls = List.generate(50, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: ls.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(ls[index]),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    setState(() {
                      ls.removeAt(index);
                    });
                    Fluttertoast.showToast(msg: 'Archived');
                  } else if (direction == DismissDirection.endToStart) {
                    setState(() {
                      ls.removeAt(index);
                    });
                    Fluttertoast.showToast(msg: 'Deleted');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Colors.orange,
                          Colors.white,
                          Colors.green
                        ],
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: text("Item $index"),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
