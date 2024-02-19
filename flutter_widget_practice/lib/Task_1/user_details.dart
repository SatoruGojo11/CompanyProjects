import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/Task_1/registration_page.dart';
import 'package:flutter_widget_practice/models/text.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key, required this.userdetails});

  final List<Map<String, dynamic>> userdetails;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            text(
              'User Details',
              fontsize: 25,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationPage(),
                  )),
              icon: const Icon(
                Icons.logout_outlined,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.userdetails.length,
          itemBuilder: (context, index) {
            return ListTile(
              splashColor: Colors.red,
              title: text(
                "Name :- ${widget.userdetails.elementAt(0)['Username']}",
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("Email-id :- ${widget.userdetails[0]['Email-id']}"),
                  text("Phone-No :- ${widget.userdetails[0]['Phone-No']}"),
                  text("Password :- ${widget.userdetails[0]['Password']}"),
                  text("Gender :- ${widget.userdetails[0]['Gender']}"),
                  text("Hobbies :- ${widget.userdetails[0]['Hobbies']}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
