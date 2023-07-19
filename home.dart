import 'package:flutter/material.dart';
import 'new.dart';
import 'contentpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}):super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum ButtonID { Button1, Button2, Button3, Button4 , Button5 , Button6 , Button7 , Button8 , Button9}

final List<Map<String, dynamic>> sessions = [
  {"id":1, "name": '훈이네 밥집', "category": '한식'},
  {"id":2, "name": '교촌치킨', "category": '야식'},
  {"id":3, "name": '알찬냄비', "category": '한식'},
  {"id":4, "name": '청송함흥냉면', "category": '한식'},
  {"id":5, "name": '벽제갈비', "category": '한식'},
  {"id":6, "name": '신라호텔', "category": '양식'},
  {"id":7, "name": '마라쿵푸', "category": '중식'},
  {"id":8, "name": '가정초밥', "category": '일식'},
];

List<Map<String, dynamic>> filteredSessions = sessions;

class FontWeightChangeButton extends StatefulWidget {
  FontWeightChangeButton({Key? key, required this.notifyParent}) : super(key: key);
  
  Function() notifyParent;

  @override
  _FontWeightChangeButtonState createState() => _FontWeightChangeButtonState();
}

class _FontWeightChangeButtonState extends State<FontWeightChangeButton> {
  
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
    List<Map<String, dynamic>> results = [];
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

    @override
    Widget build(BuildContext context) {
    return Column(
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
                    widget.notifyParent();
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
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String search = '';

  void cardClickEvent(BuildContext context, int index) {
    String content = filteredSessions[index]['name'];
    Navigator.push(
      context,
      MaterialPageRoute(
        // 정의한 ContentPage의 폼 호출
        builder: (context) => ContentPage(content: content),
      ),
    );
  }

  void refresher() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                    child: Text('검색', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
             ],
            ),
           ),
          ),
          
          // floatingactionbutton 구현
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder:(context) => add_new(),)
              );
            },
            backgroundColor: Color.fromARGB(200, 200,1, 80),
            elevation: 15,
            child: Icon(Icons.add),
          ),

          body: 
           Column(
              children: [
                FontWeightChangeButton(notifyParent: refresher),
                Container(
                  child: Divider(color: Color.fromARGB(200, 200,1, 80), thickness: 0.5,)),
                
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
                          title: Text(filteredSessions[index]["name"], style:TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
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
    );
  }
}