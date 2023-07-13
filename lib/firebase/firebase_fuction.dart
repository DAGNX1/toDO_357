import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/model/user_model.dart';
import '../model/task_model.dart';

class FireBaseFunction {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance.collection("Task").withConverter(
        fromFirestore: (snapshote, _) {
      return TaskModel.fromJson(snapshote.data()!);
    }, toFirestore: (TaskModel, _) {
      return TaskModel.toJson();
    });
  }

  static Future<void> addTaskeToFireStore(TaskModel task) async {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTaskFromFireStore(DateTime date) {
    return getTaskCollection()
    .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch).

    orderBy("time")
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel taskModel) {
    return getTaskCollection().doc(id).update(taskModel.toJson());
  }

  ////////////////////////////////////////////////////////////////////////////
  //FIREBASE
  ////////////////////////////////////////////////////////////////////////////
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance.collection("User").withConverter(
        fromFirestore: (snapshote, _) {
      return UserModel.fromJson(snapshote.data()!);
    }, toFirestore: (UserModel, _) {
      return UserModel.toJson();
    });
  }

  static Future<void> addUserToFireStore(UserModel userModel) async {
    var collection = getUserCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }
 static Future<UserModel?> readUserFromFireStore(String id)async{
 DocumentSnapshot<UserModel> UserDoc= await getUserCollection().doc(id).get();
 return UserDoc.data();
  }

  static Future<void> createAccount(
      String email, password, Function afterCreate,String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel =
          UserModel(email: email, password: password, id: credential.user!.uid,name: name);
      addUserToFireStore(userModel).then((value) => afterCreate());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<void> login(
      String email, password, Function afterLogin,Function dialog) async {
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      afterLogin();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      dialog(e.message);
      } else if (e.code == 'wrong-password') {
        dialog(e.message);
      }
    } catch (e) {
      print(e);
    }
  }
}
