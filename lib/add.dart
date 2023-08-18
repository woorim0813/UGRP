import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('추가 페이지')
          )
      ],)
    );
  }
}