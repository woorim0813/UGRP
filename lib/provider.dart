import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String _username = '';
  String _userid = '';
  bool _insession = false;

  String get username => _username;
  String get userid => _userid;
  bool get insession => _insession;

  void nameupdate(String username){
    _username = username;
    notifyListeners();
  }

  void idupdate(String userid){
    _userid = userid;
    notifyListeners();
  }

  void inupdate(String userid) async{
    var reqbody = {
      "userid": userid,
    };

    var response = await http.post(
      Uri.parse("http://192.168.123.182:3000/sessions/check"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqbody)
    );

    if (response.body == "true") {
      _insession = true;
      notifyListeners();
    }
    else {
      _insession = false;
      notifyListeners();
    }   
  }
}