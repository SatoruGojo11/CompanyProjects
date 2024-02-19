import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/models/textformfield.dart';
import 'package:firebase_project_1/realtime_database_screens/reltm_dash_board_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageRealtm extends StatefulWidget {
  const LoginPageRealtm({super.key});

  @override
  State<LoginPageRealtm> createState() => _LoginPageRealtmState();
}

class _LoginPageRealtmState extends State<LoginPageRealtm> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();

  Map studentValue = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            textformfield(
              studentNameController,
              labeltxt: 'StudentName',
              hinttxt: 'Enter StudentName',
            ),
            const SizedBox(height: 15),
            textformfield(
              emailController,
              labeltxt: 'Email-id',
              hinttxt: 'Enter your Email-id',
              keyboardtype: TextInputType.emailAddress,
              inputFormate: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z1-90@.]'))
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                try {
                  log('try Part');
                  await FirebaseDatabase.instance
                      .ref("RealtmDemo")
                      .child(emailController.text.replaceAll(".", ","))
                      .once()
                      .then((value) {
                    studentValue = value.snapshot.value as Map;
                    log(studentValue.toString());
                  });
                  if (studentValue.containsValue(emailController.text)) {
                    log('Found same id');
                    Fluttertoast.showToast(
                        msg: 'Logged-In Successful',
                        backgroundColor: Colors.green);
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPageRealTm(),
                          ));
                    }
                  } else {
                    log('Found different id');
                    Fluttertoast.showToast(
                        msg: 'Not Registered.', backgroundColor: Colors.red);
                  }
                  // emailController.clear();
                  // studentNameController.clear();
                } on FirebaseAuthException catch (e) {
                  log('Catch On Part');
                  if (e.code == 'weak-password') {
                    Fluttertoast.showToast(msg: 'Weak Password');
                  } else if (e.code == 'email-already-in-use') {
                    Fluttertoast.showToast(
                        msg: 'This email is already in use...');
                  } else {
                    log(e.toString());
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
              child: text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
