import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class CupertinoWidgets extends StatefulWidget {
  const CupertinoWidgets({super.key});

  @override
  State<CupertinoWidgets> createState() => _CupertinoWidgetsState();
}

class _CupertinoWidgetsState extends State<CupertinoWidgets> {
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  int? hour = 1, minutes;
  double slider = 0.0;
  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CupertinoActivityIndicator(
                  color: Colors.black,
                  radius: 20.0,
                ),
                const SizedBox(height: 10),
                const CupertinoActivityIndicator.partiallyRevealed(
                  progress: 0.77,
                  color: Colors.black,
                  radius: 20.0,
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.amber[400],
                  child: text('Alert Box', clr: Colors.black, fontsize: 20),
                  onPressed: () {
                    showCupertinoDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: text('Delete', clr: Colors.red),
                        content: text('Are you sure??'),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            isDestructiveAction: true,

                            /// This parameter indicates the action would perform
                            /// a destructive action such as deletion, and turns
                            /// the action's text color to red.
                            child: const Text('Yes'),
                          ),
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            child: text('No'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.amber[400],
                  child: text('Bottom Sheet', clr: Colors.black, fontsize: 20),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: text(
                          'Choose Options',
                          clr: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        message: text(
                          'Your Options are ',
                          fontsize: 20,
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: const Text('Male'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: const Text('Female'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: const Text('Others'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('Button'),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: CupertinoContextMenu(
                    actions: [
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        isDefaultAction: true,
                        trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
                        child: text('Copy'),
                      ),
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        trailingIcon: CupertinoIcons.share,
                        child: text('Share'),
                      ),
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        trailingIcon: CupertinoIcons.heart,
                        child: text('Favorites'),
                      ),
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        trailingIcon: CupertinoIcons.delete,
                        child: text('Delete'),
                      ),
                    ],
                    child: Image.asset(
                      'assets/naruto.jpg',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            showDayOfWeek: true,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              setState(() {
                                date = value;
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  color: Colors.blue,
                  child: text(
                    'Date :- ${date.day}/${date.month}/${date.year}',
                    fontsize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (value) {
                              setState(() {
                                time = value;
                                if (value.hour <= 12) {
                                  hour = value.hour;
                                } else {
                                  hour = 12 - (value.hour);
                                }
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  color: Colors.blue,
                  child: text(
                    'Time :- $hour:${time.minute}',
                    fontsize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: CupertinoSearchTextField(
                    backgroundColor: Colors.tealAccent,
                    placeholder: 'Search',
                    autocorrect: false,
                  ),
                ),
                const SizedBox(height: 10),
                text((slider * 100).toInt().toString()),
                const SizedBox(height: 10),
                CupertinoSlider(
                  activeColor: Colors.red,
                  thumbColor: Colors.red,
                  value: slider,
                  onChanged: (value) {
                    setState(() {
                      slider = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                CupertinoSwitch(
                  activeColor: Colors.red,
                  value: _switch,
                  onChanged: (value) {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: CupertinoTextField(
                    maxLines: 1,
                    placeholder: "Enter your name",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* 

CupertinoScrollbar(
          controller: ctrl,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CupertinoActivityIndicator(
                  color: Colors.black,
                  radius: 20.0,
                ),
                const SizedBox(height: 10),
                const CupertinoActivityIndicator.partiallyRevealed(
                  progress: 0.77,
                  color: Colors.black,
                  radius: 20.0,
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.amber[400],
                  child: text('Alert Box', clr: Colors.black, fontsize: 20),
                  onPressed: () {
                    showCupertinoDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: text('Delete', clr: Colors.red),
                        content: text('Are you sure??'),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            isDestructiveAction: true,

                            /// This parameter indicates the action would perform
                            /// a destructive action such as deletion, and turns
                            /// the action's text color to red.
                            child: const Text('Yes'),
                          ),
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            child: text('No'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.amber[400],
                  child: text('Bottom Sheet', clr: Colors.black, fontsize: 20),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: text(
                          'Choose Options',
                          clr: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        message: text(
                          'Your Options are ',
                          fontsize: 20,
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: const Text('Male'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: const Text('Female'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: const Text('Others'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('Button'),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: CupertinoContextMenu(
                    actions: [
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        isDefaultAction: true,
                        trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
                        child: text('Copy'),
                      ),
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        trailingIcon: CupertinoIcons.share,
                        child: text('Share'),
                      ),
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        trailingIcon: CupertinoIcons.heart,
                        child: text('Favorites'),
                      ),
                      CupertinoContextMenuAction(
                        onPressed: () => Navigator.pop(context),
                        trailingIcon: CupertinoIcons.delete,
                        child: text('Delete'),
                      ),
                    ],
                    child: Image.asset(
                      'assets/naruto.jpg',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            showDayOfWeek: true,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              setState(() {
                                date = value;
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  color: Colors.blue,
                  child: text(
                    'Date :- ${date.day}/${date.month}/${date.year}',
                    fontsize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (value) {
                              setState(() {
                                time = value;
                                if (value.hour <= 12) {
                                  hour = value.hour;
                                } else {
                                  hour = 12 - (value.hour);
                                }
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  color: Colors.blue,
                  child: text(
                    'Time :-  $hour:${time.minute}',
                    fontsize: 20,
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                ),
                Container(
                  height: 100,
                  color: Colors.brown,
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                ),
                Container(
                  height: 100,
                  color: Colors.blueAccent,
                ),
                Container(
                  height: 100,
                  color: Colors.black,
                ),
                Container(
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  height: 100,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ),
*/
