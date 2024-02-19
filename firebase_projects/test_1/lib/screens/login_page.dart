import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_1/models/text.dart';
import 'package:test_1/models/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

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
                  final credential = await auth.createUserWithEmailAndPassword(
                    email: emailController.text.toString(),
                    password: pwdController.text.toString(),
                  );
                  log('try Part');
                  log(credential.user!.email.toString());
                  emailController.clear();
                  pwdController.clear();
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
