import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContentPage extends StatefulWidget {
  final String name;
  final int currentorder;
  final int finalorder;
  final int finaltime;
  final String location;

  const ContentPage({Key? key, required this.name, required this.currentorder, required this.finalorder, required this.finaltime, required this.location}) : super(key: key);
  ContentPageState createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage> {
  List Menu = [];
  List menunum = [];
  
  void loadmenu (String name) async {
    var reqbody = {
      "name": name,
    };

    var response = await http.post(
      Uri.parse("http://192.168.123.182:3000/sessions/orderload"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqbody)
    );

    List<dynamic> jsonResponse = json.decode(response.body);
    Menu = jsonResponse;
    menunum = List<int>.filled(Menu.length, 0);

    setState(() {
      
    });
  }

  int calorder() {
    double currentorder = 0;
    for(int i = 0; i < Menu.length; i++) {
      currentorder += Menu[i]['price'] * menunum[i]; 
    }

    return currentorder.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('세션 세부 설명'),
        backgroundColor: Color.fromARGB(200, 200, 1, 80),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.name),
            Text(widget.finalorder.toString()),
            Text(widget.currentorder.toString()),
            Text('finaltime:' + widget.finaltime.toString()),
            Text(widget.location),

            if(Menu.isEmpty) 
              Expanded(
                child: ElevatedButton(
                  child: Text('새로고침'), 
                  onPressed: (){loadmenu(widget.name); setState(() {});},
                )
              )
            else
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                height: 300,
                child: ListView.builder(
                  itemCount: Menu.length,
                  itemBuilder: (BuildContext context, int index) {
                  return  Container(
                      height: 90, width: 180,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color.fromARGB(200, 200, 1, 80), width: 2,),
                          borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 12),
                                Text(Menu[index]['menu'],
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
                                ),
                                Text(' / ',
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
                                ),
                                Text(Menu[index]['price'].toString(),
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 75, 75),),
                                ),
                                Text('원',
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 75, 75),),
                                ),
                              ],
                            ),
                            Row(children: [
                              Container(
                              width: 40,
                              height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Color.fromARGB(200, 200, 1, 80)
                                  ),
                                  onPressed: () {
                                    setState(() {menunum[index]++;});
                                  },
                                  child: Icon(Icons.add)),
                              ),
                              SizedBox(width: 17),
                              Text('${menunum[index]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 75, 75),),),
                              SizedBox(width: 17),
                              Container(
                              width: 40,
                              height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Color.fromARGB(200, 200, 1, 80)
                                  ),
                                  onPressed: () {
                                    if (menunum[index] == 0) {
                                      
                                    }
                                    else {
                                      setState(() {
                                        menunum[index]--;
                                    });
                                    };
                                  },
                                  child: Icon(Icons.remove)),
                              ),
                              SizedBox(width: 12),
                            ],)
                        ],)
                      ),
                    );
                  }
                ),
              ),
          ],
        ),
      ),
    );
  }
}