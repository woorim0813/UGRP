import 'package:flutter/material.dart';
import 'provider.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => UserProvider(),
        child: Column(children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('${context.watch<UserProvider>().userid} ${context.watch<UserProvider>().insession}'),
            ),
          ],)
        )
    );
  }
}