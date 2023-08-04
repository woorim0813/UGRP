import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';
  String _userid = '';

  String get username => _username;
  String get userid => _userid;

  void nameupdate(String username){
    _username = username;
    notifyListeners();
  }

  void idupdate(String userid){
    _userid = userid;
    notifyListeners();
  }
}