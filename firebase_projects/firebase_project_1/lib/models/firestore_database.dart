import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

// final FirebaseFirestore firebaseFirestore =
//     FirebaseFirestore.instance; // Created a instance of FirebaseFirestore

// final CollectionReference reference = firebaseFirestore.collection(
//     'Demo'); // Created a Collection named 'Demo' in CollectionReference using FirebaseFirestore reference

class CloudDatabase {
  static Future<void> addItem({
    required String username,
    required String useremail,
    required String userPassword,
    required String userUid,
  }) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Demo').doc();

    // DocumentReference documentReference = FirebaseFirestore.instance.collection('Demo')
    //     .doc(userUid)
    //     .collection('items')
    //     .doc(
    //         docId1); // Creating a Document using userUid and then create a new collection named 'Items' and then create new Document.

    Map<String, dynamic> data = {
      'UserName': username,
      'UserEmail': useremail,
      'UserPassword': userPassword,
      'UserUid': userUid,
    };

    log(userUid.toString());
    await documentReference
        .set(data)
        .whenComplete(() => log('add Data Completed'))
        .catchError((e) => log(e.toString()));
  }

  static Future<void> updateItem({
    required String username,
    required String useremail,
    required String userPassword,
    required String userUid,
  }) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Demo').doc(userUid);

    // DocumentReference documentReference = reference
    //     .doc(userUid)
    //     .collection('Item')
    //     .doc(
    //         docId2); // update the data that is in the Collection named 'Item' and also going to the document using docId

    Map<String, dynamic> data = {
      'UserName': username,
      'UserEmail': useremail,
      'UserPassword': userPassword,
    };

    await documentReference
        .update(data)
        .whenComplete(() => log('Update Data Completed'))
        .catchError((e) => log(e.toString()));
  }

  static Stream<QuerySnapshot> readItems() {
    // we have to use stream builder for read continuous data so that we created Stream func instead of Future func

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Demo');

    // CollectionReference collectionReference = reference
    //     .doc(userUid)
    //     .collection('Item'); // Read Items from the collection named 'Item'

    return collectionReference.snapshots();
  }

  static Future<void> deleteItem({required String userUid}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Demo').doc(userUid);

    // DocumentReference documentReference = reference.doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => log('Delete Data'))
        .catchError((e) => log(e.toString()));
  }
}
