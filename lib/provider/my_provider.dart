import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/firebase/firebase_fuction.dart';
import 'package:to_do/model/user_model.dart';

class MyProvider  extends ChangeNotifier
{
  UserModel ?userModel;
  User?firebaseUser;
  ThemeMode themeMode=ThemeMode.light;
  String langcode="en";
  MyProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initUser();
    }
  }
  void changeTheme(ThemeMode theme){
    themeMode=theme;
    notifyListeners();
}
void changeLang( String lang){
    langcode=lang;
    notifyListeners();
}
void initUser()async
{
  firebaseUser=FirebaseAuth.instance.currentUser;
    userModel = await FireBaseFunction.readUserFromFireStore(firebaseUser!.uid);
  notifyListeners();
}
}