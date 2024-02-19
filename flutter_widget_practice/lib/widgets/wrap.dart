import 'package:flutter/material.dart';

class WrapWidget extends StatelessWidget {
  const WrapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/* Difference between Wrap & Row/Column
=> Wrap widget aligns the widgets in a horizontal and vertical manner. Generally, 
  we use Rows and Columns to do that but if we have some widgets which are not able to fit in the Row/Column 
  then it will give us Overflow Message (for ex: Right Overflowed by 570 pixels).
  but if we use Wrap widget then It will not give us error of overflowed but it will cut or remove the extra childrens.
*/
      body: Wrap(
        spacing: 10,
        runSpacing: 40.0,
        direction: Axis.vertical,
        children: [
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
          Container(
            color: Colors.green,
            height: 100,
            width: 200,
          ),
        ],
      ),
    );
  }
}
