import 'package:color_example/add.dart';
import 'package:color_example/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'provider.dart';
import 'package:provider/provider.dart';

String userid = '';

class ContentPage extends StatefulWidget {
  final String name;
  final int currentorder;
  final int finalorder;
  final int finaltime;
  final String location;
  final int id;

  const ContentPage({Key? key, required this.name, required this.currentorder, required this.finalorder, required this.finaltime, required this.location, required this.id}) : super(key: key);
  
  ContentPageState createState() => ContentPageState();
}


class ContentPageState extends State<ContentPage> {
  List menunum = [];
  List Menu = [];
  List userorder = [];

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
  void addmember (String userid, int sessionid, int currentorder) async{
    var reqbody = {
      "userid": userid,
      "sessionid": sessionid,
      "currentorder": currentorder,
      "userorder": jsonEncode(userorder),
    };

    var response = await http.post(
      Uri.parse("http://192.168.123.182:3000/sessions/addmember"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqbody),
    );
  }

  int calorder() {
    double currentorder = 0;
    for(int i = 0; i < Menu.length; i++) {
      currentorder += Menu[i]['price'] * menunum[i]; 
    }

    return currentorder.round();
  }

  int calorder2() {
    int a = 0;
    List temp = [];

    for (int i =0; i < Menu.length; i++) {
      temp = [];
      if (menunum[i] == 0) {

      }
      else {
        temp.add(Menu[i]);
        temp.add(menunum[i]); 
        
        userorder.addAll(temp);

        a++;
      }
    }

    print(userorder);

    return a;
  }

  @override
  Widget build(BuildContext context) {
    userid = context.watch<UserProvider>().userid;
    return Scaffold(
      appBar: AppBar(
        title: Text('세션 세부 설명'),
        backgroundColor: Color.fromARGB(200, 200, 1, 80),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity, height: 200,decoration: BoxDecoration(border:  Border.fromBorderSide(BorderSide(color: Color.fromARGB(200, 200, 1, 80), width: 2.0),),),
          
                child:
          
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  ${widget.name} #${widget.id}', style: TextStyle( fontSize: 21,fontWeight: FontWeight.bold,color: Colors.black,),),
                    
                    Row(
                      children: [
                        SizedBox(width: 5), //  간격
                        Icon(Icons.monetization_on_outlined,color: Color.fromARGB(200, 200, 1, 80),), // 아이콘
                        Text(' 최소주문가격: ${widget.finalorder} 원',style: TextStyle( fontSize: 17,color: Color.fromARGB(200, 200, 1, 80),),),
                        //Text( widget.finalorder.toString(),style: TextStyle(letterSpacing: 5.0, fontSize: 17,color: Colors.grey),),
                      ],
                    ),
          
                    Row(
                      children: [
                        SizedBox(width: 5), //  간격
          
                        Icon(Icons.timer_outlined,color: Color.fromARGB(200, 200, 1, 80),), // 아이콘
                        Text(' 주문대기시간(max): ${widget.finaltime} 분',style: TextStyle( fontSize: 17,color: Color.fromARGB(200, 200, 1, 80),),),
                        //Text( widget.finaltime.toString() ,style: TextStyle(letterSpacing: 5.0, fontSize: 17,color: Colors.grey),),
                      ],
                    ),
          
                    Row(
                      children: [
                        SizedBox(width: 5), //  간격
                        Icon(Icons.place,color: Color.fromARGB(200, 200, 1, 80),), // 아이콘
                        Text(' 배달스팟: ${widget.location}',style: TextStyle( fontSize: 17,color: Color.fromARGB(200, 200, 1, 80),),),
                        //Text( widget.location,style: TextStyle(letterSpacing: 5.0, fontSize: 17,color: Colors.grey),),
                      ],
                    ),
          
          
                  ],
                )
          
          
            ),
          ),

          SizedBox(height: 5,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text( '메뉴 주문',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          
            if(Menu.isEmpty) 
              Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('새로고침', style: TextStyle(color: Color.fromARGB(199, 78, 78, 78), fontSize: 17),), 
                    onPressed: (){setState(() {loadmenu(widget.name);});},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      alignment: Alignment.center,
                      side: BorderSide(color: Color.fromARGB(199, 78, 78, 78), width: 1),
                    )
                  ),
                ],
              )
            )
            else
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    height: 370,
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: SizedBox(
                                      width: 240,
                                      child: Text(Menu[index]['menu'],
                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                        child: Text('${Menu[index]['price']} 원',
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 75, 75),),
                                        ),
                                      ),
                                    ],
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
                                      if(menunum[index] == 9){}
                                      else{
                                        setState(() {menunum[index]++;});
                                      }
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Color.fromARGB(200, 200, 1, 80)
                  ),
                  onPressed: 
                  context.watch<UserProvider>().insession
                  ? null
                  : () {
                    
                    int cur = calorder();
                    int cal = calorder2();
                    addmember(userid, widget.id, cur);

                    setState(() {
                      context.read<UserProvider>().inupdate(userid);
                    });
                    
                    setState(() {
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => AddScreen()));
                    });
                  }, 
                child: Text('세션 참여', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}