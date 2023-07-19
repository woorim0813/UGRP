import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('세션 세부 설명'),
        backgroundColor: Color.fromARGB(200, 200, 1, 80),
      ),
      body: Center(
        child: Text(content),
      ),
    );
  }
}