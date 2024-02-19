import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project_1/models/text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Test1HomePage extends StatefulWidget {
  const Test1HomePage({super.key});

  @override
  State<Test1HomePage> createState() => _Test1HomePageState();
}

class _Test1HomePageState extends State<Test1HomePage> {
  // final _validationkey = GlobalKey<FormState>();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController pwdController = TextEditingController();
  // TextEditingController usernameController = TextEditingController();
  // String useremail = ''

  final ref = FirebaseDatabase.instance.ref().child('Demo');

  @override
  void initState() {
    super.initState();

    log('Init Method in Home Page');
    // fetchData();
  }

  // dynamic data;
  // Map usersData = {};

  // Future fetchData() async {
  //   final ref = FirebaseDatabase.instance.ref().child('Demo');
  //   ref.onValue.listen((DatabaseEvent event) {
  //     data = event.snapshot.value;
  //   });
  //   log('In Fetch Data');
  //   log(data.toString());
  //   log(data.runtimeType.toString());
  //   usersData.addAll(data);
  //   log(usersData.toString());
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Dash Board Page'),
      ),
      body: Center(
        child: FutureBuilder(
          future: ref.get(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(msg: 'Something went wrong');
              return const CircularProgressIndicator();
            } else if (snapshot.hasData || snapshot.data != null) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.active) {
                final userS = snapshot.data?.value as Map;
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    log('Data :- ${userS.toString()}');

                    return ListTile(
                      onTap: () {
                        // Fluttertoast.showToast(
                        //   msg:
                        //       '${snapshot.data!.docs.map((e) => e['userName']).toList()[index]} Data Deleted',
                        // backgroundColor: Colors.red,
                        // );
                      },
                      title: text(
                          // 'Username :- ${snapshot.data!.docs.map((e) => e['userName']).toList()[index]}'
                          'Username :- ${userS["Users"]['userName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text('Useremail :- ${userS["Users"]['userEmail']}'),
                          text(
                              'User-Password :- ${userS["Users"]['userPassword']}'),
                        ],
                      ),
                      leading: text('${index + 1}'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    );
                  },
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

// class _Test1HomePageState extends State<Test1HomePage> {
//   // final _validationkey = GlobalKey<FormState>();
//   // TextEditingController emailController = TextEditingController();
//   // TextEditingController pwdController = TextEditingController();
//   // TextEditingController usernameController = TextEditingController();
//   // String useremail = '';
//   CollectionReference collectionReference =
//       FirebaseFirestore.instance.collection('Test1');

//   List<String> docIds = [];

//   @override
//   void initState() {
//     super.initState();

//     collectionReference.get().then((QuerySnapshot snapshot) {
//       log('init method Home Page');
//       snapshot.docs
//           .map((e) {
//             log(e.id.toString());
//             setState(() {});
//             docIds.add(e.id);
//           })
//           .toList()
//           .toString();

//       for (int i = 0; i < docIds.length; i++) {
//         collectionReference.doc(docIds[i]).update({
//           'userUid': docIds[i],
//         });
//       }
//     });
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: text('Dash Board Page'),
  //     ),
  //     body: Center(
  //       child: StreamBuilder(
  //         stream: collectionReference.snapshots(),
  //         builder: (BuildContext context,
  //             AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  //           if (snapshot.hasError) {
  //             Fluttertoast.showToast(msg: 'Something went wrong');
  //           } else if (docIds.isEmpty) {
  //             return Center(
  //               child:
  //                   text('No Data', fontsize: 30, fontWeight: FontWeight.bold),
  //             );
  //           } else if (snapshot.hasData || snapshot.data != null) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return const Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             } else if (snapshot.connectionState == ConnectionState.done ||
  //                 snapshot.connectionState == ConnectionState.active) {
  //               log(docIds.toString());
  //               return ListView.builder(
  //                 itemCount: snapshot.data!.docs.length,
  //                 itemBuilder: (context, index) {
  //                   return ListTile(
  //                     onTap: () {
  //                       collectionReference.doc(docIds[index]).delete();
  //                       docIds.removeAt(index);
  //                       log(docIds.toString());
  //                       Fluttertoast.showToast(
  //                         msg:
  //                             '${snapshot.data!.docs.map((e) => e['userName']).toList()[index]} Data Deleted',
  //                         backgroundColor: Colors.red,
  //                       );
  //                     },
  //                     title: text(
  //                         'Username :- ${snapshot.data!.docs.map((e) => e['userName']).toList()[index]}'),
  //                     subtitle: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         text(
  //                             'Useremail :- ${snapshot.data!.docs.map((e) => e['userEmail']).toList()[index]}'),
  //                         text(
  //                             'User-Password :- ${snapshot.data!.docs.map((e) => e['userPassword']).toList()[index]}'),
  //                         text('User-Doc Id :- ${docIds.elementAt(index)}'),
  //                       ],
  //                     ),
  //                     leading: text('${index + 1}'),
  //                     trailing: IconButton(
  //                       onPressed: () {},
  //                       icon: const Icon(Icons.edit),
  //                     ),
  //                   );
  //                 },
  //               );
  //             } else {
  //               return text(snapshot.connectionState.toString());
  //             }
  //           }
  //           return const Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(
  //                 Colors.red,
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
