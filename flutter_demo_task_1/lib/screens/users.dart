import 'package:flutter/material.dart';
import 'package:flutter_demo_task/models/text.dart';
import 'package:flutter_demo_task/screens/registration_page.dart';
import 'package:flutter_demo_task/screens/user_details.dart';

class Users extends StatefulWidget {
  const Users({super.key, required this.userdetails});

  final List<Map<String, dynamic>> userdetails;

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool isData = false;
  @override
  void initState() {
    super.initState();
    if (widget.userdetails.isEmpty) {
      isData = false;
    } else {
      isData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: text(
          'Users',
          fontsize: 25,
          fontWeight: FontWeight.bold,
        ),
        leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegistrationPage(recentuserdata: widget.userdetails),
                  ),
                )),
        // If Sign out button Needed
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         barrierDismissible: false,
        //         builder: (context) => AlertDialog(
        //           alignment: Alignment.center,
        //           backgroundColor: Colors.white,
        //           title: text(
        //             'Sign Out',
        //             clr: Colors.red,
        //             fontsize: 25,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           content: text(
        //             'Are you sure?',
        //             fontsize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           actionsAlignment: MainAxisAlignment.spaceEvenly,
        //           actions: [
        //             ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: Colors.red,
        //               ),
        //               onPressed: () {
        //                 Navigator.pushReplacement(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => RegistrationPage(
        //                       recentuserdata: widget.userdetails,
        //                     ),
        //                   ),
        //                 );
        //               },
        //               child: text(
        //                 'Yes',
        //                 clr: Colors.white,
        //                 fontWeight: FontWeight.bold,
        //                 fontsize: 15,
        //               ),
        //             ),
        //             ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 backgroundColor: Colors.green,
        //               ),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //               child: text(
        //                 'No',
        //                 clr: Colors.white,
        //                 fontWeight: FontWeight.bold,
        //                 fontsize: 15,
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //     icon: const Icon(
        //       Icons.logout,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: Center(
        child: isData
            ? ListView.builder(
                itemCount: widget.userdetails.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(widget.userdetails.length),
                    background: Container(
                      color: Colors.red,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          size: 35,
                        ),
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        widget.userdetails.removeAt(index);
                      });
                    },
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsPage(
                              userdetails: widget.userdetails,
                              userinfoindex: index,
                            ),
                          ),
                        );
                      },
                      leading: text(
                        (index + 1).toString(),
                        fontsize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      title: Row(
                        children: [
                          text(
                            widget.userdetails[index]['Username'],
                            fontsize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      trailing: Hero(
                        tag: widget.userdetails[index]['Username'],
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: text(
                  'No Data',
                  fontWeight: FontWeight.bold,
                  fontsize: 30,
                ),
              ),
      ),
    );
  }
}
