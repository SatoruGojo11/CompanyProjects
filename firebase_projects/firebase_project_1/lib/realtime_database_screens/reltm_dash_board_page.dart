import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project_1/models/realtime_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/models/textformfield.dart';
import 'package:firebase_project_1/realtime_database_screens/reltm_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardPageRealTm extends StatefulWidget {
  const DashboardPageRealTm({super.key});

  @override
  State<DashboardPageRealTm> createState() => _DashboardPageRealTmState();
}

class _DashboardPageRealTmState extends State<DashboardPageRealTm> {
  final collectionReference = FirebaseFirestore.instance.collection('Demo');

  final _validationkey = GlobalKey<FormState>();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentAgeController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  String useremail = '';
  String? key = FirebaseDatabase.instance.ref('RealtmDemo').key;

  final reference = FirebaseDatabase.instance.ref("RealtmDemo");

  String currentEmail = '';

  @override
  Widget build(BuildContext context) {
    reference.keepSynced(true);
    return Scaffold(
      appBar: AppBar(
        title: text('Dash Board Page'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageRealTm(),
                ),
                (route) => true,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: reference,
                shrinkWrap: true,
                itemBuilder: (context, snapshot, animation, index) {
                  log(key.toString());
                  currentEmail = (snapshot.value as Map)['StudentEmail']
                      .toString()
                      .replaceAll(".", ",");
                  return ListTile(
                    onLongPress: () {
                      RealtimeDatabase.deleteStudentData(
                          studentEmail: (snapshot.value as Map)['StudentEmail']
                              .toString());
                      Fluttertoast.showToast(
                        msg: 'Data Deleted',
                        backgroundColor: Colors.red,
                      );
                    },
                    title: text(
                        'Student Name :- ${(snapshot.value as Map)['StudentName']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                            'Student Email :- ${(snapshot.value as Map)['StudentEmail']}'),
                        text(
                            'Student Age :- ${(snapshot.value as Map)['StudentAge']}'),
                      ],
                    ),
                    leading: text('${index + 1}'),
                    trailing: IconButton(
                      onPressed: () {
                        showModelBottomSheet(context);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showModelBottomSheet(context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white38,
      context: context,
      elevation: 0,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            builder: (BuildContext context, ScrollController controller) {
              return Container(
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        text(
                          'Edit Data',
                          fontsize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _validationkey,
                          child: Column(
                            children: [
                              textformfield(
                                studentNameController,
                                labeltxt: 'StudentName',
                                hinttxt: 'Enter your name',
                                inputFormate: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z1-90]'))
                                ],
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter your name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              textformfield(
                                studentEmailController,
                                labeltxt: 'Email-id',
                                hinttxt: 'Enter your email-id',
                                keyboardtype: TextInputType.emailAddress,
                                inputFormate: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z1-90@.]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter your Email-id";
                                  } else if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return "Please Enter valid Email-id";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              textformfield(
                                studentAgeController,
                                labeltxt: 'Age',
                                hinttxt: 'Enter your Age',
                                keyboardtype: TextInputType.number,
                                inputFormate: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[1-90]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter your Age";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[500],
                              elevation: 10,
                              shadowColor: Colors.green,
                              fixedSize: const Size(100, 50)),
                          onPressed: () {
                            if (_validationkey.currentState!.validate()) {
                              log('Update Data');
                              RealtimeDatabase.updateStudentData(
                                stdName: studentNameController.text.toString(),
                                stdEmail:
                                    studentEmailController.text.toLowerCase(),
                                stdAge: int.parse(studentAgeController.text),
                                studentEmail: currentEmail,
                              );
                              setState(() {});
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  fontSize: 15,
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  gravity: ToastGravity.BOTTOM,
                                  msg:
                                      'Please,Fill up the above conditions...');
                            }
                          },
                          child: text(
                            'Submit',
                            clr: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontsize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}


/* 

StreamBuilder(
          stream: RealtimeDatabase.readStudentData(),
          builder: (BuildContext context,
              snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(msg: 'Something went wrong');
            } else if (snapshot.hasData || snapshot.data != null) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.active) {
                return } else {
                return Text(snapshot.connectionState.toString());
              }
            }
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red,
                ),
              ),
            );
          },
        ),

*/ 