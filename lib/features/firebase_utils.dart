import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snak_bar_service.dart';
import 'package:todo_app/core/utils/extract_date.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseUtils {
  CollectionReference<TaskModel> getCollectionReference() {
    var db = FirebaseFirestore.instance;

    return db.collection("Tasks_List").withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStore(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFireStore(),
        );
  }

  Future<void> addNewTask(TaskModel data) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc();

    data.id = docRef.id;
    return docRef.set(data);
  }

  Future<void> deleteTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();

    var docRef = collectionRef.doc(taskModel.id);

    return docRef.delete();
  }

  Future<void> updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();

    var docRef = collectionRef.doc();

    return docRef.update(taskModel.toFireStore());
  }

  Future<List<TaskModel>> getDataFromFireStore(DateTime dateTime) async {
    var collectionRef = getCollectionReference().where(
      "dateTime",
      isEqualTo: extractDateTime(dateTime).millisecondsSinceEpoch,
    );

    var data = await collectionRef.get();

    return data.docs.map((e) => e.data()).toList();
  }

  Stream<QuerySnapshot<TaskModel>> getStreamDataFromFireStore(
      DateTime dateTime) {
    var collectionRef = getCollectionReference().where(
      "dateTime",
      isEqualTo: extractDateTime(dateTime).millisecondsSinceEpoch,
    );

    return collectionRef.snapshots();
  }

  Future<bool> createUserAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarService.showErrorMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for that email.');
        SnackBarService.showErrorMessage(
            "An account already exists for that email.");
      }
      EasyLoading.dismiss();
      return Future.value(false);
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future<bool> loginInUserAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      EasyLoading.dismiss();
      print(credential.user?.email);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackBarService.showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackBarService.showErrorMessage(
            "Wrong password provided for that user.");
      }
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  List tasksList = [];
}
