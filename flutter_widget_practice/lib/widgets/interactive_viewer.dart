import 'package:flutter/material.dart';

class InteractiveViewerWidget extends StatelessWidget {
  const InteractiveViewerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            maxScale: 10,
            minScale: 1,
            boundaryMargin: const EdgeInsets.all(10),
            // constrained: false,
            // scaleEnabled: false,
            child: Image.network(
                'https://thumbs.dreamstime.com/b/desert-highway-spring-sky-23939617.jpg'),
          ),
        ),
      ),
    );
  }
}
