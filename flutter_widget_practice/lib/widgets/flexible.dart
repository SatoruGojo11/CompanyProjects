import 'package:flutter/material.dart';

class FlexibleWidget extends StatelessWidget {
  const FlexibleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              color: Colors.red,
              // height: 100,
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Container(
              color: Colors.green,
              // height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
