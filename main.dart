// 메인 파일, 바로 로그인 화면으로 이동

import 'package:color_example/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}