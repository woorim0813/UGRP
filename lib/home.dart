import 'dart:convert';
import 'package:color_example/realhome.dart';
import 'package:flutter/material.dart';
import 'new.dart';
import 'contentpage.dart';
import 'package:http/http.dart' as http;
import 'provider.dart';
import 'package:provider/provider.dart';

String userid = '';

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List sessions = [];
  List filteredSessions = [];

  void loadsessions () async {
    var reqbody = {
      "userid": userid,
    };

    var response = await http.post(
      Uri.parse("http://192.168.123.182:3000/sessions/load"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqbody)
    );

    List<dynamic> jsonResponse = json.decode(response.body);
    
    sessions = jsonResponse;
    filteredSessions = sessions;
  }

  TextEditingController searchController = TextEditingController(text: '');
  String search = '';

  void cardClickEvent(BuildContext context, int index) {
    String name = filteredSessions[index]['name'];
    int finalorder = filteredSessions[index]['finalorder'];
    int currentorder = filteredSessions[index]['currentorder'];
    int finaltime = filteredSessions[index]['finaltime'];
    String location = filteredSessions[index]['location'];
    int id = filteredSessions[index]['id'];

    setState(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ContentPage(name: name, currentorder: currentorder, finalorder: finalorder, finaltime: finaltime, location: location, id: id),
        ),
        (route) => true
    );
    });
  }

  void refresher() {
    setState(() {});
  }

  ButtonID _selectedButton = ButtonID.Button1;

  FontWeight _getButtonTextFontWeight(ButtonID buttonID) {
    return buttonID == _selectedButton ? FontWeight.bold : FontWeight.normal;
  }

  void _changeButtonFontWeight(ButtonID buttonID) {
    setState(() {
      _selectedButton = buttonID;
    });
  }

  void runFilter(String Keyword) {
    List results = [];
    if (Keyword == '전체'){
      results = sessions;
    }
    else {
      results = sessions
                  .where((user) => 
                    user["category"].toLowerCase().contains(Keyword.toLowerCase()))
                  .toList();
    }

    setState(() {
      filteredSessions = results;
    });
  }

  bool searching(String search) {
    int a = 0;

    if (search.isEmpty) {
      return false;
    }

    for (int i = 0; i < filteredSessions.length; i++) {
      if (filteredSessions[i]["name"].toString().toLowerCase().contains(search.toLowerCase())) 
          {
            a++;
          }
    }

    if (a > 0) {
      return false;
    }

    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    userid = context.watch<UserProvider>().userid;

    setState(() {
      context.read<UserProvider>().inupdate(userid);
    });

    //loadsessions();
    return MaterialApp(
        home: ChangeNotifierProvider<UserProvider>(
          create:(context) => UserProvider(),
          child: Scaffold(
            backgroundColor: Colors.white,
            
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(64),
              child: AppBar(
                backgroundColor: Color.fromARGB(200, 200,1, 80),
                centerTitle: true,
                title: Column(
                  children: [SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       
                        Icon(Icons.search, color: Color.fromARGB(255, 255, 255, 255), size: 30,),
                       
                        SizedBox(width: 8),
                        Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              style: TextStyle(color: Color.fromARGB(200, 200, 1, 80)),
                              controller: searchController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.1, color: Colors.white)),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '먹고 싶은 메뉴를 입력해주세요',
                                hintStyle: TextStyle(color: Color.fromARGB(200, 200,1, 80)),
                                labelStyle: TextStyle(color: Color.fromARGB(200, 200,1, 80)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    SizedBox(width: 8),
                    
                    TextButton(
                      onPressed: () {
                        setState(() {
                          search = searchController.text;
                        });
                      },
                      child: Text('검색', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
               ],
              ),
             ),
            ),
            
            // floatingactionbutton 구현
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    filteredSessions = sessions;
                    setState(() {
                      loadsessions();
                      runFilter('전체');
                      _changeButtonFontWeight(ButtonID.Button1);
                      search = '';
                      searchController.text = '';
                      });
                  },
                  backgroundColor: Color.fromARGB(200, 200,1, 80),
                  elevation: 15,
                  child: Icon(Icons.refresh),
                  heroTag: null,
                ),
                SizedBox(
                  height: 12,
                ),
                  FloatingActionButton(
                    onPressed: 
                    //context.watch<UserProvider>().insession
                    Provider.of<UserProvider>(context).insession
                    ? null
                    : () {
                      setState(() {
                        Navigator.push(
                        context, MaterialPageRoute(builder:(context) => add_new(),)
                      );
                      });
                    },
                    backgroundColor: Color.fromARGB(200, 200,1, 80),
                    elevation: 15,
                    child: Icon(Icons.add),
                    heroTag: null,
                  ),
              ],
            ),
        
            body: 
             Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button1);
                                  runFilter('전체');
                                  
                                },                  
                                child: Text('전체',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button1),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button2);
                                  runFilter('한식');
                                  
                                  },
                                child: Text('한식',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button2),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button3);
                                  runFilter('중식');
                                  
                                  },
                                child: Text('중식',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button3),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button4);
                                  runFilter('일식');
                                  
                                  },
                                child: Text('일식',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button4),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button5);
                                  runFilter('양식');
                                  
                                  },
                                child: Text('양식',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button5),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button6);
                                  runFilter('분식');
                                  
                                  },
                                child: Text('분식',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button6),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button7);
                                  runFilter('야식');
                                  
                                  },
                                child: Text('야식',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button7),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button8);
                                  runFilter('아시안');
                                  
                                  },
                                child: Text('아시안',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button8),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 70,
                              child: TextButton(
                                onPressed: () {
                                  _changeButtonFontWeight(ButtonID.Button9);
                                  runFilter('디저트');
                                  
                                  },
                                child: Text('디저트',
                                  style: TextStyle(
                                    fontWeight: _getButtonTextFontWeight(ButtonID.Button9),
                                    fontSize: 16,
                                    color: Color.fromARGB(200, 200,1, 80), 
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                  Container(
                    child: Divider(color: Color.fromARGB(200, 200,1, 80), thickness: 0.5,)),
                  if (sessions.isEmpty)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5,),
                                Text('세션 로드를 위해 새로고침하세요!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(199, 78, 78, 78),
                                  ),),
                                SizedBox(height: 8,),
                              ],
                            ), 
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            alignment: Alignment.center,
                            side: BorderSide(color: Color.fromARGB(199, 78, 78, 78), width: 1), // Background color
                          ),
                        ),
                        ]
                      ),
                    )
                  else if (filteredSessions.isEmpty || searching(search)) 
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text('조건에 맞는 세션이 없습니다.',
                              style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(199, 78, 78, 78),
                              ),),
                            SizedBox(height: 5,),
                            Text('세션 추가 버튼을 눌러 세션을 추가하세요!',
                              style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(199, 78, 78, 78),
                            ),
                          ),
                        ]
                      ),
                    )
                  else 
                    Expanded(
                    child: ListView.builder(
                      // items 변수에 저장되어 있는 모든 값 출력
                      itemCount: filteredSessions.length,
                      itemBuilder: (BuildContext context, int index) {
                        // 검색 기능, 검색어가 있을 경우
                        if (search.isNotEmpty &&
                            !filteredSessions[index]["name"].toString()
                                .toLowerCase()
                                .contains(search.toLowerCase())) {
                          return SizedBox.shrink();
                        }
                        // 검색어가 없을 경우, 모든 항목 표시
                        else {
                          return Container(
                            height: 90, width: 180,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color.fromARGB(200, 200, 1, 80), width: 2,),
                                  borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
                              child: ListTile(
                                title: Text(filteredSessions[index]["name"], style:TextStyle(fontWeight: FontWeight.bold, fontSize: 19),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                onTap: () => cardClickEvent(context, index),
                                subtitle: Text('음식 종류: ${filteredSessions[index]['category'].toString()}'),
                                trailing: Text('기타 정보'),
                                //기타정보 표기를 위해서 ListTile이 아니라 다른 위젯을 고려해야 할 듯
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
            ]
          )
              ),
        ),
    );
  }
}



enum ButtonID { Button1, Button2, Button3, Button4 , Button5 , Button6 , Button7 , Button8 , Button9}