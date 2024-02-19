import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo_task_2/models/text.dart';
import 'package:flutter_demo_task_2/models/textformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController listController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
  ];
  List<String> colorName = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
  ];

  List<int> indexList = [];
  List<int> displayList = [];
  List<Map<String, dynamic>> searchList = [];

  bool isData = false, showData = false, numbered = false, searchedData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: text(
          'Home Page',
          fontsize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textformfield(
                      listController,
                      RegExp('[1-90]'),
                      hintText: 'Enter Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, Enter value';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (listController.text.isNotEmpty) {
                              displayList.clear();
                              setState(() {
                                isData = true;
                                showData = false;
                                searchedData = false;
                              });
                              indexList = List.generate(
                                  int.parse(listController.text),
                                  (index) => index + 1);
                              // indexList.where(
                              //     (element) => [indexList[element] % colorName.length]);
                              for (int i = 0; i < indexList.length; i++) {
                                int a = indexList[i] % colorName.length;
                                if (a == 0) {
                                  a = 5;
                                }
                                displayList.add(a);
                              }
                              log(displayList.toString());
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Please, Enter Value',
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          child: text('Submit'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            listController.clear();
                            searchController.clear();
                            displayList.clear();
                            setState(() {
                              isData = false;
                            });
                          },
                          child: text('Clear'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textformfield(
                            searchController,
                            RegExp('[a-zA-z1-90]'),
                            hintText: 'Search your item',
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (displayList.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'Please, make a Color list First...',
                                backgroundColor: Colors.red,
                              );
                            } else if (displayList.isNotEmpty) {
                              setState(() {
                                isData = true;
                                showData = true;
                                searchedData = true;
                              });

                              // // Search List Contains Color Name
                              // if (colorName
                              //     .contains(searchController.text.toString())) {
                              //   searchList.clear();
                              //   setState(() {
                              //     numbered = false;
                              //   });
                              //   log('Colors name part');
                              //   for (int i = 0; i < indexList.length; i++) {
                              //     int a = indexList[i] % colorName.length;
                              //     if (a == 0) {
                              //       a = 5;
                              //     }
                              //     if (colorName[a - 1] ==
                              //         searchController.text.toString()) {
                              //       log(a.toString());
                              //       searchList.addAll([
                              //         {
                              //           'index': i + 1,
                              //           'colorName': colorName[a - 1],
                              //           'color': colorList[a - 1],
                              //         }
                              //       ]);
                              //     }
                              //   }
                              //   log(searchList.toString());
                              // }
                              // // Search List Contains Index
                              // else 
                              if (int.tryParse(searchController.text) !=
                                  null) {
                                log('Number part');
                                searchList.clear();
                                setState(() {
                                  numbered = true;
                                });
                                log(searchList.toString());
                                if (displayList.length >=
                                    int.parse(searchController.text)) {
                                  searchList.addAll([
                                    {
                                      'index': searchController.text,
                                      'colorName': colorName[displayList[
                                          int.parse(searchController.text) -
                                              2]],
                                      'color': colorList[indexList[
                                          int.parse(searchController.text) -
                                              2]],
                                    }
                                  ]);
                                  log(searchList.toString());
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Entered Index is Wrong',
                                    backgroundColor: Colors.red,
                                  );
                                }
                              } else {
                                log('else part');
                                Fluttertoast.showToast(
                                  msg: 'Please, Enter Correct Data... ',
                                  backgroundColor: Colors.red,
                                );
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 10,
              color: Colors.black,
            ),
            Flexible(
              flex: 1,
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: isData
                      ? showData
                          ? searchedData
                              ? numbered
                                  ? numberedData()
                                  : namedData()
                              : mainData()
                          : mainData()
                      : Center(
                          child: text('No Data'),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView mainData() {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: displayList.length,
      separatorBuilder: (context, index) => const Divider(
        height: 5,
        color: Colors.white,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          leading: text('${index + 1}'),
          title: text(colorName[displayList[index] - 1]),
          tileColor: colorList[displayList[index] - 1],
        );
      },
    );
  }

  ListView numberedData() {
    log('numbered Data method');
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: searchList.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
        height: 10,
      ),
      itemBuilder: (context, index) => ListTile(
        title: text(searchList[index]['colorName']),
        leading: text(searchList[index]['index']),
        tileColor: searchList[index]['color'],
      ),
    );
  }

  ListView namedData() {
    log('named Data method');
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: searchList.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
        height: 10,
      ),
      itemBuilder: (context, index) => ListTile(
        title: text(searchList[index]['colorName']),
        leading: text(searchList[index]['index'].toString()),
        tileColor: searchList[index]['color'],
      ),
    );
  }
}
