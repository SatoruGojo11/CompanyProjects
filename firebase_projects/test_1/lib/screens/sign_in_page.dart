import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_1/models/text.dart';
import 'package:test_1/models/textformfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController smsController = TextEditingController();

  late String smsCode;
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
            textformfield(emailController,
                labeltxt: 'Email-id',
                keyboardtype: TextInputType.emailAddress,
                inputFormate: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z1-90@.]'))
                ]),
            const SizedBox(height: 15),
            textformfield(
              pwdController,
              labeltxt: 'Password',
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await auth.signInWithEmailAndPassword(
                    email: emailController.text.toString(),
                    password: pwdController.text.toString(),
                  );
                  log('try Part');
                  log(credential.user!.email.toString());
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
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
              child: text('Sign In'),
            ),
            textformfield(
              phoneController,
              labeltxt: 'Phone-No',
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                try {
                  // ignore: unused_local_variable
                  final credentialPhone = await auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted:
                          (PhoneAuthCredential phoneAuthCredential) async {
                        Fluttertoast.showToast(
                          msg: 'Verification Completed',
                          backgroundColor: Colors.greenAccent,
                        );
                        await auth.signInWithCredential(phoneAuthCredential);
                      },
                      verificationFailed: (FirebaseAuthException error) {
                        if (error.code == 'invalid-phone-number') {
                          log('The provided phone number is not valid.');
                          Fluttertoast.showToast(
                            msg: 'Invalid Phone Number',
                            backgroundColor: Colors.red,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: error.toString(),
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      codeSent:
                          (String verificationId, int? forceResendingToken) {
                        Fluttertoast.showToast(
                          msg: 'Code Sent',
                          backgroundColor: Colors.amber,
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            alignment: Alignment.center,
                            backgroundColor: Colors.white,
                            title: text(
                              'Enter SMS Code below',
                              clr: Colors.red,
                              fontsize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            content: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: textformfield(
                                smsController,
                                labeltxt: 'SMS Code',
                                hinttxt: 'Enter your code here',
                                inputFormate: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[1-90]'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  smsCode = smsController.text;
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: smsCode);

                                  await auth.signInWithCredential(credential);
                                  Fluttertoast.showToast(
                                      msg: 'Verification Successful');
                                },
                                child: text(
                                  'Submit',
                                  clr: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontsize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (verificationId) {
                        Fluttertoast.showToast(
                          msg: 'Code Auto Retrieval Timeout',
                          backgroundColor: Colors.red,
                        );
                      });
                } on FirebaseAuthException catch (e) {
                  log(e.toString());
                }
              },
              child: text(
                'Sign-In with Phone Number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
