import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/widgets/gridview.dart';
import 'package:flutter_widget_practice/widgets/inkwell_gesture.dart';
import 'package:flutter_widget_practice/models/listtile.dart';
import 'package:flutter_widget_practice/models/text.dart';
import 'package:flutter_widget_practice/Task_1/registration_page.dart';
import 'package:flutter_widget_practice/widgets/listview.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            text(
              'Home Page',
              fontsize: 25,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationPage(),
                  )),
              icon: const Icon(
                Icons.logout_outlined,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: lstile(
                tileColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InkWellGesturePage()),
                  );
                },
                title: text(
                  'Inkwell Vs Gesture Detector',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: lstile(
                tileColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListViewPage(),
                    ),
                  );
                },
                title: text(
                  'List View',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: lstile(
                tileColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GridViewPage()),
                  );
                },
                title: text(
                  'GridView',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
