import 'package:flutter/material.dart';
// import 'package:flutter_widget_practice/models/listtile.dart';
import 'package:flutter_widget_practice/models/text.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List<String> names = ['one', 'three', 'four', 'two'];

    return Scaffold(
      body: SafeArea(
        child: ListView.custom(
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => text(
              'Hello ${index + 1}',
            ),
            childCount: 1000,
          ),
        ),
      ),
    );
  }
}

/*

// Simple ListView..
ListView(
          children: [
            lstile(
              title: text('A'),
              tileColor: Colors.blue,
            ),
            lstile(
              title: text('B'),
              tileColor: Colors.blue,
            ),
            lstile(
              title: text('C'),
              tileColor: Colors.blue,
            ),
            lstile(
              title: text('D'),
              tileColor: Colors.blue,
            ),
            lstile(
              title: text('E'),
              tileColor: Colors.blue,
            ),
          ],
        ),

// ListView.builder...

        ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return lstile(
              tileColor: Colors.green,
              title: text(names[index]),
            );
          },
          scrollDirection: Axis.vertical,
        ),

// ListView.separated...

        ListView.separated(
            itemBuilder: (context, index) {
              return lstile(
                title: text(names[index]),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: names.length),
*/