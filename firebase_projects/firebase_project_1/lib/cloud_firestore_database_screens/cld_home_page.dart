import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_1/cloud_firestore_database_screens/cld_dash_board_page.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/cloud_firestore_database_screens/cld_login_page.dart';
import 'package:firebase_project_1/cloud_firestore_database_screens/cld_sign_up_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: text('Home Page'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ));
            },
            child: text('View Data'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              child: text(
                'Login Page',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ));
              },
              child: text(
                'Sign-Up Page',
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     CollectionReference collectionReference =
            //         FirebaseFirestore.instance.collection('Demo');
            //     // collectionReference.add({
            //     //   'UserName': 'Naruto',
            //     //   'UserEmail': 'naruto@gmail.com',
            //     //   'UserAge': 20,
            //     // });
            //     collectionReference.get().then((snapShot) {
            //       log(snapShot.size.toString());
            //       snapShot.docs.map((e) => log(e.id)).toList().toString();
            //       snapShot.docs
            //           .map((e) => log(e.data()!.toString()))
            //           .toList()
            //           .toString();
            //     });
            //   },
            //   child: text(
            //     'Add Data',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
