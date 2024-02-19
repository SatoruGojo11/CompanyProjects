import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_1/models/realtime_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/models/textformfield.dart';
import 'package:firebase_project_1/realtime_database_screens/reltm_dash_board_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPageRealTm extends StatefulWidget {
  const SignInPageRealTm({super.key});

  @override
  State<SignInPageRealTm> createState() => _SignInPageRealTmState();
}

class _SignInPageRealTmState extends State<SignInPageRealTm> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _validationkey = GlobalKey<FormState>();

  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentAgeController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();

  // late String smsCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: text('Sign In Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Form(
              key: _validationkey,
              child: Column(
                children: [
                  textformfield(
                    studentNameController,
                    labeltxt: 'StudentName',
                    hinttxt: 'Enter your name',
                    inputFormate: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z1-90]'))
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
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
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
                      FilteringTextInputFormatter.allow(RegExp(r'[1-90]'))
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
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                log('Sign up button Clicked');
                if (_validationkey.currentState!.validate()) {
                  try {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    final credential =
                        await auth.createUserWithEmailAndPassword(
                      email: studentEmailController.text.toString(),
                      password: studentNameController.text.toString(),
                    );

                    RealtimeDatabase.addStudentData(
                        stdName: studentNameController.text.toString(),
                        stdEmail: studentEmailController.text.toLowerCase(),
                        stdAge: int.parse(studentAgeController.text));
                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPageRealTm(),
                          ));
                      // Navigator.pop(context);
                    }
                    log('try Part');
                    log(credential.user!.email.toString());
                    studentEmailController.clear();
                    studentAgeController.clear();
                    studentNameController.clear();
                  } on FirebaseAuthException catch (e) {
                    log('Catch On Part');
                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(
                        msg: 'User Not Found',
                        backgroundColor: Colors.red,
                      );
                    } else if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(
                        msg: 'Wrong Password',
                        backgroundColor: Colors.red,
                      );
                    } else {
                      log(e.toString());
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                } else {
                  Fluttertoast.showToast(
                      fontSize: 15,
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                      msg: 'Please, fulfill the above conditions...');
                }
              },
              child: text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
