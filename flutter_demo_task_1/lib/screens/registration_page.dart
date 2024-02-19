import 'package:flutter/material.dart';
import 'package:flutter_demo_task/screens/users.dart';
import 'package:flutter_demo_task/models/listtile.dart';
import 'package:flutter_demo_task/models/text.dart';
import 'package:flutter_demo_task/models/textformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.recentuserdata});

  final List<Map<String, dynamic>> recentuserdata;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _validationkey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  bool reading = false, cricket = false, photography = false, cooking = false;

  String _setgender = '';

  List<Map<String, dynamic>> userdetails = [];

  List<String> techlist = [
    'Flutter',
    'React Native',
    'AI-ML',
    '.Net',
  ];
  List<String> hobbies = [];

  String dropdownmenuitem = 'Flutter';

  @override
  void initState() {
    super.initState();

    userdetails.addAll(widget.recentuserdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text(
          'Registration Page',
          clr: Colors.white,
          fontsize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: Container(
          color: Colors.transparent,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Users(
                    userdetails: userdetails,
                  ),
                ),
              );
            },
            child: text(
              'View',
              clr: Colors.black,
              fontWeight: FontWeight.bold,
              fontsize: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    height: 20,
                  ),
                  const Text(
                    'Registration Page',
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
                          validator: (String? value) {
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
                          "Enter your Phone-no",
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
                          value: 'Male',
                          groupValue: _setgender,
                          activeColor: Colors.blue[900],
                          onChanged: (value) {
                            setState(() {
                              _setgender = 'Male';
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _setgender = 'Male';
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
                          value: 'Female',
                          groupValue: _setgender,
                          activeColor: Colors.blue[900],
                          onChanged: (value) {
                            setState(() {
                              _setgender = 'Female';
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _setgender = "Female";
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
                          value: 'Others',
                          groupValue: _setgender,
                          activeColor: Colors.blue[900],
                          onChanged: (value) {
                            setState(() {
                              _setgender = "Others";
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _setgender = "Others";
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
                      });
                      if (cricket == true) {
                        hobbies.add('Cricket');
                      } else if (cricket == false) {
                        hobbies.remove('Cricket');
                      }
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
                        });
                        if (cricket == true) {
                          hobbies.add('Cricket');
                        } else if (cricket == false) {
                          hobbies.remove('Cricket');
                        }
                      },
                    ),
                  ),
                  lstile(
                    onTap: () {
                      setState(() {
                        photography = !photography;
                      });
                      if (photography == true) {
                        hobbies.add('Photography');
                      } else if (photography == false) {
                        hobbies.remove('Photography');
                      }
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
                        });
                        if (photography == true) {
                          hobbies.add('Photography');
                        } else if (photography == false) {
                          hobbies.remove('Photography');
                        }
                      },
                    ),
                  ),
                  lstile(
                    onTap: () {
                      setState(() {
                        reading = !reading;
                      });
                      if (reading == true) {
                        hobbies.add('Reading');
                      } else if (reading == false) {
                        hobbies.remove('Reading');
                      }
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
                        });
                        if (reading == true) {
                          hobbies.add('Reading');
                        } else if (reading == false) {
                          hobbies.remove('Reading');
                        }
                      },
                    ),
                  ),
                  lstile(
                    onTap: () {
                      setState(() {
                        cooking = !cooking;
                      });
                      if (cooking == true) {
                        hobbies.add('Cooking');
                      } else if (cooking == false) {
                        hobbies.remove('Cooking');
                      }
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
                        });
                        if (cooking == true) {
                          hobbies.add('Cooking');
                        } else if (cooking == false) {
                          hobbies.remove('Cooking');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose Your Technology',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10),
                            right: Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            elevation: 8,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: dropdownmenuitem,
                            items: techlist.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: SizedBox(
                                  width: 160,
                                  child: text(
                                    items,
                                    fontsize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownmenuitem = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[500],
                            elevation: 10,
                            shadowColor: Colors.green,
                            fixedSize: const Size(100, 50)),
                        onPressed: () {
                          if (_validationkey.currentState!.validate()) {
                            if (widget.recentuserdata.isEmpty) {
                              final currentuserentries = <String, dynamic>{
                                'Username': usernamecontroller.text,
                                'Email-id': emailcontroller.text.toLowerCase(),
                                'Phone-No': phonecontroller.text,
                                'Gender': _setgender,
                                'Hobbies': hobbies,
                                'Technology': dropdownmenuitem,
                              };
                              userdetails.add(currentuserentries);
                              Fluttertoast.showToast(
                                msg: 'Successfully Data Entered',
                                backgroundColor: Colors.green,
                              );
                              usernamecontroller.clear();
                              emailcontroller.clear();
                              phonecontroller.clear();
                              setState(() {
                                reading = false;
                                cricket = false;
                                photography = false;
                                cooking = false;
                              });
                              dropdownmenuitem = 'Flutter';
                            } else if (widget.recentuserdata.isNotEmpty) {
                              for (int i = 0;
                                  i < widget.recentuserdata.length;
                                  i++) {
                                if (widget.recentuserdata[i]['Username']
                                            .toString() !=
                                        usernamecontroller.text.toString() &&
                                    widget.recentuserdata[i]['Email-id']
                                            .toString()
                                            .toLowerCase() !=
                                        emailcontroller.text
                                            .toLowerCase()
                                            .toString() &&
                                    widget.recentuserdata[i]['Phone-No']
                                            .toString() !=
                                        phonecontroller.text.toString()) {
                                  i = widget.recentuserdata.length - 1;
                                  final currentuserentries = <String, dynamic>{
                                    'Username': usernamecontroller.text,
                                    'Email-id':
                                        emailcontroller.text.toLowerCase(),
                                    'Phone-No': phonecontroller.text,
                                    'Gender': _setgender,
                                    'Hobbies': hobbies,
                                    'Technology': dropdownmenuitem,
                                  };
                                  userdetails.add(currentuserentries);
                                  Fluttertoast.showToast(
                                    msg: 'Successfully Data Entered',
                                    backgroundColor: Colors.green,
                                  );
                                  usernamecontroller.clear();
                                  emailcontroller.clear();
                                  phonecontroller.clear();
                                  setState(() {
                                    reading = false;
                                    cricket = false;
                                    photography = false;
                                    cooking = false;
                                  });
                                  dropdownmenuitem = 'Flutter';
                                } else if (widget.recentuserdata[i]
                                            ['Username'] ==
                                        usernamecontroller.text.toString() ||
                                    widget.recentuserdata[i]['Email-id']
                                            .toString()
                                            .toLowerCase() ==
                                        emailcontroller.text
                                            .toLowerCase()
                                            .toString() ||
                                    widget.recentuserdata[i]['Phone-No']
                                            .toString() ==
                                        phonecontroller.text.toString()) {
                                  // if username is same
                                  if (widget.recentuserdata[i]['Username'] ==
                                          usernamecontroller.text ||
                                      userdetails[i]['Username'] ==
                                          usernamecontroller.text) {
                                    usernamecontroller.clear();
                                    Fluttertoast.showToast(
                                        fontSize: 15,
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        gravity: ToastGravity.BOTTOM,
                                        msg: 'Username already exists...');
                                  }
                                  // if email-id is same
                                  else if (widget.recentuserdata[i]['Email-id']
                                              .toString()
                                              .toLowerCase() ==
                                          emailcontroller.text
                                              .toLowerCase()
                                              .toString() ||
                                      userdetails[i]['Email-id']
                                              .toString()
                                              .toLowerCase() ==
                                          emailcontroller.text
                                              .toLowerCase()
                                              .toString()) {
                                    emailcontroller.clear();
                                    Fluttertoast.showToast(
                                        fontSize: 15,
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        gravity: ToastGravity.BOTTOM,
                                        msg: 'Email-id already exists...');
                                  }
                                  // if phone-no is same
                                  else if (widget.recentuserdata[i]['Phone-No']
                                              .toString() ==
                                          phonecontroller.text.toString() ||
                                      userdetails[i]['Phone-No'].toString() ==
                                          phonecontroller.text.toString()) {
                                    phonecontroller.clear();
                                    Fluttertoast.showToast(
                                        fontSize: 15,
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        gravity: ToastGravity.BOTTOM,
                                        msg: 'Phone-no already exists...');
                                  }
                                }
                              }
                            }
                          } else {
                            // Never Used but for information about we can dismiss keyboard on any button click using these code...
                            // ** FocusManager.instance.primaryFocus?.unfocus();
                            Fluttertoast.showToast(
                                fontSize: 15,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                msg: 'Please,Fill up the above conditions...');
                          }
                        },
                        child: text(
                          'Submit',
                          clr: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 16,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[500],
                            elevation: 10,
                            shadowColor: Colors.red,
                            fixedSize: const Size(100, 50)),
                        onPressed: () {
                          setState(() {
                            userdetails.clear();
                            usernamecontroller.clear();
                            emailcontroller.clear();
                            phonecontroller.clear();
                            reading = false;
                            cricket = false;
                            photography = false;
                            cooking = false;
                            hobbies.clear();
                            dropdownmenuitem = 'Flutter';
                            Fluttertoast.showToast(
                                fontSize: 15,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                gravity: ToastGravity.BOTTOM,
                                msg: 'Data Cleared...');
                          });
                        },
                        child: text(
                          'Clear',
                          clr: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 16,
                        ),
                      ),
                    ],
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

