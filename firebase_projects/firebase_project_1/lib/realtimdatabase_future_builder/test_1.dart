import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/models/textformfield.dart';
import 'package:firebase_project_1/realtimdatabase_future_builder/test_1_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Test1Page extends StatefulWidget {
  const Test1Page({super.key});

  @override
  State<Test1Page> createState() => _Test1PageState();
}

class _Test1PageState extends State<Test1Page> {
  final _validationkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  var instance = FirebaseDatabase.instance;
  var reference = FirebaseDatabase.instance.ref('Demo');
  // jd1356@gmail,com/StudentAge
  @override
  void initState() {
    super.initState();

    reference.onValue.listen((event) {
      log(event.snapshot.children.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: text('Test 1-Sign In Page'),
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
                    usernameController,
                    labeltxt: 'Username',
                    hinttxt: 'Enter your name',
                    keyboardtype: TextInputType.emailAddress,
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
                    emailController,
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
                    pwdController,
                    labeltxt: 'Password',
                    hinttxt: 'Enter your Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter your Password";
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
                    log('try Part');
                    Map<String, dynamic> data = {
                      'userName': usernameController.text.toString(),
                      'userEmail': emailController.text.toLowerCase(),
                      'userPassword': pwdController.text.toString(),
                      // 'userUid': userUid,
                    };

                    log('data added');
                    reference.child('Users').set(data);
                    // log(reference
                    //     .get()
                    //     .then(
                    //       (value) => log(value.toString()),
                    //     )
                    //     .toString());
                    // await instance.ref('Demo/User1').set(data);

                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Test1HomePage(),
                        ),
                      );
                    }
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
