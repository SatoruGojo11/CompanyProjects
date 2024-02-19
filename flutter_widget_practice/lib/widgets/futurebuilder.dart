import 'package:flutter/material.dart';

class FuturebuilderWidget extends StatefulWidget {
  const FuturebuilderWidget({super.key});

  @override
  State<FuturebuilderWidget> createState() => _FuturebuilderWidgetState();
}

class _FuturebuilderWidgetState extends State<FuturebuilderWidget> {
  Future<DateTime> futurefunc() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                futurefunc();
              });
            },
            child: const Text('Click'),
          ),
          FutureBuilder(
            future: futurefunc(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return const Text('Something went Wrong');
                }
              } else {
                return Text(snapshot.connectionState.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
