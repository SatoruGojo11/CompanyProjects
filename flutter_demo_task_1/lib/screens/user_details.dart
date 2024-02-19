import 'package:flutter/material.dart';
import 'package:flutter_demo_task/models/listtile.dart';
import 'package:flutter_demo_task/models/text.dart';
import 'package:flutter_demo_task/models/textformfield.dart';
import 'package:flutter_demo_task/screens/users.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({
    super.key,
    required this.userdetails,
    required this.userinfoindex,
  });

  final List<Map<String, dynamic>> userdetails;
  final int userinfoindex;
  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _validationkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  bool reading = false, cricket = false, photography = false, cooking = false;

  List<String> techlist = [
    'Flutter',
    'React Native',
    'AI-ML',
    '.Net',
  ];

  List<String> hobbies = [];

  String dropdownmenuitem = '';
  String _setgender = '';

  @override
  void initState() {
    super.initState();

    usernamecontroller = TextEditingController(
        text: widget.userdetails[widget.userinfoindex]['Username'].toString());
    emailcontroller = TextEditingController(
        text: widget.userdetails[widget.userinfoindex]['Email-id'].toString());
    phonecontroller = TextEditingController(
        text: widget.userdetails[widget.userinfoindex]['Phone-No']);

    _setgender = widget.userdetails[widget.userinfoindex]['Gender'].toString();
    dropdownmenuitem =
        widget.userdetails[widget.userinfoindex]['Technology'].toString();

    if (widget.userdetails[widget.userinfoindex]['Hobbies']
        .contains('Cricket')) {
      cricket = true;
      hobbies.add('Cricket');
    }
    if (widget.userdetails[widget.userinfoindex]['Hobbies']
        .contains('Photography')) {
      photography = true;
      hobbies.add('Photography');
    }
    if (widget.userdetails[widget.userinfoindex]['Hobbies']
        .contains('Reading')) {
      reading = true;
      hobbies.add('Reading');
    }
    if (widget.userdetails[widget.userinfoindex]['Hobbies']
        .contains('Cooking')) {
      cooking = true;
      hobbies.add('Cooking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: text(
          'User Details',
          fontsize: 25,
          fontWeight: FontWeight.bold,
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Users(
                userdetails: widget.userdetails,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showbottomsheet(),
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: Hero(
        tag: widget.userdetails[widget.userinfoindex]['Username'],
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.blue,
            ),
            height: 200,
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                text(
                  "Username :- ${widget.userdetails[widget.userinfoindex]['Username']}",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
                text(
                  "Email-id :- ${widget.userdetails[widget.userinfoindex]['Email-id']}",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
                text(
                  "Phone-No :- ${widget.userdetails[widget.userinfoindex]['Phone-No']}",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
                text(
                  "Gender :- ${widget.userdetails[widget.userinfoindex]['Gender']}",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
                text(
                  "Hobbies :- ${widget.userdetails[widget.userinfoindex]['Hobbies']}",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
                text(
                  "Technology :- ${widget.userdetails[widget.userinfoindex]['Technology']}",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white38,
      context: context,
      elevation: 0,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
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
                    controller: scrollController,
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
                                usernamecontroller,
                                "",
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
                                "",
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
                                "",
                                "Phone-No",
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
                        StatefulBuilder(
                          builder: (context, setStateGen) => Row(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Radio(
                                  value: 'Male',
                                  groupValue: _setgender,
                                  activeColor: Colors.blue[900],
                                  onChanged: (value) {
                                    setStateGen(() {
                                      _setgender = 'Male';
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateGen(() {
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
                                    setStateGen(() {
                                      _setgender = 'Female';
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateGen(() {
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
                                    setStateGen(() {
                                      _setgender = "Others";
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setStateGen(() {
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
                        StatefulBuilder(
                          builder: (context, setState) => lstile(
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
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => lstile(
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
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => lstile(
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
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => lstile(
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[500],
                              elevation: 10,
                              shadowColor: Colors.green,
                              fixedSize: const Size(100, 50)),
                          onPressed: () {
                            if (_validationkey.currentState!.validate()) {
                              widget.userdetails[widget.userinfoindex].update(
                                  'Username',
                                  (value) => usernamecontroller.text);
                              widget.userdetails[widget.userinfoindex].update(
                                  'Email-id',
                                  (value) =>
                                      emailcontroller.text.toLowerCase());
                              widget.userdetails[widget.userinfoindex].update(
                                  'Phone-No', (value) => phonecontroller.text);
                              widget.userdetails[widget.userinfoindex]
                                  .update('Gender', (value) => _setgender);
                              widget.userdetails[widget.userinfoindex]
                                  .update('Hobbies', (value) => hobbies);
                              widget.userdetails[widget.userinfoindex].update(
                                  'Technology', (value) => dropdownmenuitem);
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
