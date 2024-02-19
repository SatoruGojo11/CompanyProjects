import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class DraggablescrollablesheetWidget extends StatefulWidget {
  const DraggablescrollablesheetWidget({super.key});

  @override
  State<DraggablescrollablesheetWidget> createState() =>
      _DraggablescrollablesheetWidgetState();
}

class _DraggablescrollablesheetWidgetState
    extends State<DraggablescrollablesheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.amber,
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      expand: false,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                            child: GridView.builder(
                              controller: scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: 50,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.green,
                                  child: Center(
                                    child: text('Item $index'),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: text('Draggable Scrollable Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}

/*  ElevatedButton(
        onPressed: () {
          SizedBox.expand(
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  child: GridView.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.green,
                        child: text('Item $index'),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        child: text('Draggable Scrollable Sheet'),
      )
*/