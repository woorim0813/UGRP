// 메인 파일, 바로 로그인 화면으로 이동

// import 'package:color_example/home.dart';
// import 'package:color_example/login.dart';
import 'package:color_example/home.dart';
import 'package:color_example/login.dart';
import 'package:color_example/new.dart';
import 'package:color_example/realhome.dart';
// import 'package:color_example/new.dart';
// import 'package:color_example/realhome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider())
      ],
    child: App()));
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}