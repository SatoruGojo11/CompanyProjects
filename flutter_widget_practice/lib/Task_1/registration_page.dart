import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_widget_practice/Task_1/user_details.dart';
import 'package:flutter_widget_practice/models/listtile.dart';
import 'package:flutter_widget_practice/models/text.dart';
import 'package:flutter_widget_practice/models/textformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _validationkey = GlobalKey<FormState>();

enum Gender { male, female, others }

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Gender? _gender;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  bool obscurity = true,
      reading = false,
      cricket = false,
      photography = false,
      cooking = false,
      phonetextfield = false,
      emailtextfield = false,
      pwdtextfield = false;

  late String gender;

  List<Map<String, dynamic>> userdetails = [];
  List<String> hobbies = [];

  dynamic suffixicn() {
    return IconButton(
      onPressed: () {
        setState(() {
          obscurity = !obscurity;
        });
      },
      icon: Icon(
        obscurity ? Icons.visibility_off : Icons.visibility,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Sign up Page',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Welcome to the Register Page...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _validationkey,
                    child: Column(
                      children: [
                        textformfield(
                          usernamecontroller,
                          "Enter your name",
                          "Username",
                          RegExp('[a-zA-z1-90]'),
                          prefixicn: const Icon(Icons.account_circle),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        textformfield(
                          emailcontroller,
                          "Enter your Email-id",
                          "Email-id",
                          RegExp('[a-zA-z@.1-90]'),
                          prefixicn: const Icon(Icons.email),
                          keyboardtype: TextInputType.emailAddress,
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
                          phonecontroller,
                          "Enter your Phone_no",
                          "Phone No.",
                          RegExp('[1-90]'),
                          prefixicn: const Icon(Icons.phone),
                          maxLength: 10,
                          keyboardtype: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your Phone-no.";
                            } else if (value.length < 10) {
                              return "Please Enter valid Phone-no.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        textformfield(
                          passwordcontroller,
                          'Enter your Password',
                          'Password',
                          RegExp('[a-zA-Z@&^*1-9]'),
                          prefixicn: const Icon(Icons.password),
                          obscurity: obscurity,
                          suffixicn: suffixicn(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your Password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        FlutterPwValidator(
                          controller: passwordcontroller,
                          defaultColor: Colors.purple,
                          width: 300,
                          height: 130,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          lowercaseCharCount: 1,
                          numericCharCount: 1,
                          specialCharCount: 1,
                          onSuccess: () {
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select your gender',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                          value: Gender.male,
                          groupValue: _gender,
                          activeColor: Colors.blue[900],
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                              gender = "Male";
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = Gender.male;
                            gender = "Male";
                          });
                        },
                        child: const Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                          value: Gender.female,
                          groupValue: _gender,
                          activeColor: Colors.blue[900],
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                              gender = "Female";
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = Gender.female;
                            gender = "Female";
                          });
                        },
                        child: const Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 1.2,
                        child: Radio(
                          value: Gender.others,
                          groupValue: _gender,
                          activeColor: Colors.blue[900],
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                              gender = "Others";
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gender = Gender.others;
                            gender = "Others";
                          });
                        },
                        child: const Text(
                          'Others',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hobbies',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  lstile(
                    onTap: () {
                      setState(() {
                        cricket = !cricket;
                        hobbies.add('Cricket');
                      });
                    },
                    title: text(
                      'Cricket',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    leading: Checkbox(
                      value: cricket,
                      onChanged: (value) {
                        setState(() {
                          cricket = !cricket;
                          hobbies.add('Cricket');
                        });
                      },
                    ),
                  ),
                  lstile(
                    onTap: () {
                      setState(() {
                        photography = !photography;
                        hobbies.add('Photography');
                      });
                    },
                    title: text(
                      'Photography',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    leading: Checkbox(
                      value: photography,
                      onChanged: (value) {
                        setState(() {
                          photography = !photography;
                          hobbies.add('Photography');
                        });
                      },
                    ),
                  ),
                  lstile(
                    onTap: () {
                      setState(() {
                        reading = !reading;
                        hobbies.add('Reading');
                      });
                    },
                    title: text(
                      'Reading',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    leading: Checkbox(
                      value: reading,
                      onChanged: (value) {
                        setState(() {
                          reading = !reading;
                          hobbies.add('Reading');
                        });
                      },
                    ),
                  ),
                  lstile(
                    onTap: () {
                      setState(() {
                        cooking = !cooking;
                        hobbies.add('Cooking');
                      });
                    },
                    title: text(
                      'Cooking',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    leading: Checkbox(
                      value: cooking,
                      onChanged: (value) {
                        setState(() {
                          cooking = !cooking;
                          hobbies.add('Cooking');
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[600],
                        elevation: 10,
                        shadowColor: Colors.orange,
                        fixedSize: const Size(200, 50)),
                    onPressed: () {
                      if (_validationkey.currentState!.validate()) {
                        // 1st Method
                        // userdetails.addAll(
                        //   {
                        //     'Username': usernamecontroller.text,
                        //     'Email-id': emailcontroller.text,
                        //     'Phone-No.': phonecontroller.text,
                        //     'Password': passwordcontroller.text,
                        //   },
                        // );
                        final currentuserentries = <String, dynamic>{
                          'Username': usernamecontroller.text,
                          'Email-id': emailcontroller.text,
                          'Phone-No': phonecontroller.text,
                          'Password': passwordcontroller.text,
                          'Gender': gender,
                          'Hobbies': hobbies,
                        };
                        userdetails.add(currentuserentries);
                        log(userdetails.elementAt(0).keys.toString());
                        log(userdetails.elementAt(0).values.toString());
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetailsPage(userdetails: userdetails),
                          ),
                        );
                        usernamecontroller.clear();
                        passwordcontroller.clear();
                        emailcontroller.clear();
                        phonecontroller.clear();
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
                    child: text(
                      'Submit',
                      clr: Colors.purple[900],
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
