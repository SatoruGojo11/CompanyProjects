import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_1/models/firestore_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/models/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final collectionReference = FirebaseFirestore.instance.collection('Demo');

  final _validationkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  List<String> docIds = [];

  @override
  void initState() {
    super.initState();

    collectionReference.get().then((QuerySnapshot snapshot) {
      log('init method Dashboard Page');
      snapshot.docs
          .map((e) {
            log(e.id.toString());
            setState(() {});
            docIds.add(e.id);
          })
          .toList()
          .toString();

      for (int i = 0; i < docIds.length; i++) {
        collectionReference.doc(docIds[i]).update({
          'UserUid': docIds[i],
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Dash Board Page'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: CloudDatabase.readItems(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(msg: 'Something went wrong');
            } else if (docIds.isEmpty) {
              return Center(
                child: text(
                  'No Data',
                  fontsize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else if (snapshot.hasData || snapshot.data != null) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.active) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        CloudDatabase.deleteItem(userUid: docIds[index]);
                        docIds.removeAt(index);
                        Fluttertoast.showToast(
                          msg:
                              '${snapshot.data!.docs.map((e) => e['UserName']).toList()[index]} Data Deleted',
                          backgroundColor: Colors.red,
                        );
                      },
                      title: text(
                          'Username :- ${snapshot.data!.docs.map((e) => e['UserName']).toList()[index]}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                              'Useremail :- ${snapshot.data!.docs.map((e) => e['UserEmail']).toList()[index]}'),
                          text(
                              'User-Password :- ${snapshot.data!.docs.map((e) => e['UserPassword']).toList()[index]}'),
                          text('User-Doc Id :- ${docIds.elementAt(index)}'),
                        ],
                      ),
                      leading: text('${index + 1}'),
                      trailing: IconButton(
                        onPressed: () {
                          showModelBottomSheet(index);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    );
                  },
                );
              } else {
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
      ),
    );
  }

  showModelBottomSheet(int index) {
    return showModalBottomSheet(
      backgroundColor: Colors.white38,
      context: context,
      elevation: 0,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
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
                                usernameController,
                                labeltxt: 'Username',
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
                              CloudDatabase.updateItem(
                                  username: usernameController.text.toString(),
                                  useremail: emailController.text.toLowerCase(),
                                  userPassword: pwdController.text.toString(),
                                  userUid: docIds[index]);
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
