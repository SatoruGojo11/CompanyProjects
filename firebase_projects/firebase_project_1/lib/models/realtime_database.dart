import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

// var bool1 = FirebaseDatabase.instance.setPersistenceEnabled(true);
// var bool2 = FirebaseDatabase.instance.ref().keepSynced(true);

class RealtimeDatabase {
  // For Add Data
  static Future<void> addStudentData({
    required String stdName,
    required String stdEmail,
    required int stdAge,
  }) async {
    Map<String, dynamic> data = {
      'StudentName': stdName,
      'StudentEmail': stdEmail,
      'StudentAge': stdAge,
    };

    await FirebaseDatabase.instance
        .ref("RealtmDemo")
        .child(stdEmail.replaceAll(".", ","))
        .set(data)
        .whenComplete(() => log('Add Data in Realtime Database'))
        .catchError((e) => log(e.toString()));
  }

  static Future<void> updateStudentData({
    required String stdName,
    required String stdEmail,
    required int stdAge,
    required String studentEmail,
  }) async {
    Map<String, dynamic> data = {
      'StudentName': stdName,
      'StudentEmail': stdEmail,
      'StudentAge': stdAge,
    };

    await FirebaseDatabase.instance
        .ref("RealtmDemo")
        .child(stdEmail.replaceAll(".", ","))
        .update(data)
        .whenComplete(() => 'Data Updated in Realtime Database')
        .catchError((e) => log(e.toString()));
  }

  static Future<void> deleteStudentData({required String studentEmail}) async {
    await FirebaseDatabase.instance
        .ref("RealtmDemo")
        .child(studentEmail.replaceAll(".", ","))
        .remove()
        .whenComplete(() => log('Data Deleted in Realtime Database'))
        .catchError((e) => log(e.toString()));
  }

  // static Stream<DatabaseEvent> readStudentData() {
  //   // Map<dynamic, dynamic> values = {};
  //   // var db = FirebaseDatabase.instance.ref().child("RealtmDemo");

  //   // db.once().then((DatabaseEvent snapshot) {
  //   //   values = snapshot.value as Map<dynamic, dynamic>;
  //   //   values.forEach((key, values) {
  //   //     log(values["Email"]);
  //   //   });
  //   // });

  //   // return values;

  //   return FirebaseDatabase.instance.ref().child("RealtmDemo").onValue;
  // }
}
