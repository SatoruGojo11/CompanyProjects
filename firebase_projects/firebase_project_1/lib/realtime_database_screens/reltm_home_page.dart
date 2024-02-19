import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:firebase_project_1/realtime_database_screens/reltm_dash_board_page.dart';
import 'package:firebase_project_1/realtime_database_screens/reltm_login_page.dart';
import 'package:firebase_project_1/realtime_database_screens/reltm_sign_up_page.dart';
import 'package:flutter/material.dart';

class HomePageRealTm extends StatefulWidget {
  const HomePageRealTm({super.key});

  @override
  State<HomePageRealTm> createState() => _HomePageRealTmState();
}

class _HomePageRealTmState extends State<HomePageRealTm> {
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
                    builder: (context) => const DashboardPageRealTm(),
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
                      builder: (context) => const LoginPageRealtm(),
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
                      builder: (context) => const SignInPageRealTm(),
                    ));
              },
              child: text(
                'Sign-Up Page',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
