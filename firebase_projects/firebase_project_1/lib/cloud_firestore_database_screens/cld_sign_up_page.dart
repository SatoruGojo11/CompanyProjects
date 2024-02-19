import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_1/cloud_firestore_database_screens/cld_dash_board_page.dart';
import 'package:firebase_project_1/models/firestore_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/models/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _validationkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  String userUid = '';

  @override
  void initState() {
    super.initState();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Demo');

    collectionReference.get().then((QuerySnapshot snapshot) {
      log('init method Sign In Method');
      snapshot.docs.map((e) => log(e.id.toString())).toList().toString();
    });
  }

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
                    usernameController,
                    labeltxt: 'Username',
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
                    final credential =
                        await auth.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: pwdController.text.toString(),
                    );

                    CloudDatabase.addItem(
                      username: usernameController.text.toString(),
                      useremail: emailController.text.toLowerCase(),
                      userPassword: pwdController.text.toString(),
                      userUid: userUid,
                    );
                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPage(),
                          ));
                    }
                    log('try Part');
                    log(credential.user!.email.toString());
                    usernameController.clear();
                    emailController.clear();
                    pwdController.clear();
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
                      Fluttertoast.showToast(
                        msg: 'Email-id is already in use by another Account',
                        backgroundColor: Colors.red,
                      );
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
