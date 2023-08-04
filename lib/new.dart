import 'package:color_example/home.dart';
import 'package:flutter/material.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 
final List<Map<String, dynamic>> stores = [
  {"id":1, "name": '훈이네 밥집',   "category": '한식', "menu": '제육덮밥, 닭갈비덮밥'},
  {"id":2, "name": '교촌치킨',      "category": '야식', "menu": '후라이드 치킨, 양념치킨'},
  {"id":3, "name": '알찬냄비',      "category": '한식', "menu": '낙곱새, 쭈꾸미볶음'},
  {"id":4, "name": '청송함흥냉면',  "category": '한식', "menu": '물냉면, 비빔냉면'},
  {"id":5, "name": '벽제갈비',      "category": '한식', "menu": '소갈비, 물냉면'},
  {"id":6, "name": '신라호텔',      "category": '양식', "menu": '망고빙수, 스테이크'},
  {"id":7, "name": '마라쿵푸',      "category": '아시안', "menu": '마라탕, 마라샹궈'},
  {"id":8, "name": '가정초밥',      "category": '일식', "menu": '초밥정식, 광어초밥'},
  {"id":9, "name": '신전떡볶이',    "category": '분식', "menu": '신전떡볶이, 김말이튀김'},
];

List<Map<String, dynamic>> filteredStores = stores;
String selectedgage ='';
String category = '';



class add_new extends StatefulWidget {
  const add_new({Key? key}):super(key: key);
  @override
  add_newState createState() => add_newState();
}

class add_newState extends State<add_new> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("세션 추가 페이지"),
        backgroundColor: Color.fromARGB(200, 200, 1, 80),
      ),
      body: add_new1()
    );
  }
}

class add_new1 extends StatefulWidget {
  add_new1({Key? key}):super(key: key);

  @override
  add_new1State createState() => add_new1State();
}

class add_new1State extends State<add_new1> {
  
  TextEditingController searchController = TextEditingController();
  String search = '';

  void runFilter(String Keyword) {
    List<Map<String, dynamic>> results = [];
    if (Keyword == '전체'){
      results = stores;
    }
    else {
      results = stores
                  .where((user) => 
                    user["category"].toLowerCase().contains(Keyword.toLowerCase()))
                  .toList();
    }

    setState(() {
      filteredStores = results;
    });
  }

  @override
  Widget build(BuildContext context){
    String DropdownValue = '전체';
    return Scaffold(
      body: Column(
        children: [
          SizedBox(child: Center(child: Text('ShowStep 이미지 삽입')), height: 80,),
          
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ButtonTheme(
                    alignedDropdown: true, 
                    child: DropdownButton<String>(
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(30),
                      underline: Container(),
                      dropdownColor: Colors.white,
                      focusColor: Colors.transparent,
                      
                      value: DropdownValue,
                      items: <String>['전체', '한식', '중식', '일식', '양식','분식', '야식', '아시안', '디저트']
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 18, color: Color.fromARGB(200, 200, 1, 80)),
                              ),
                            ),
                          );
                        }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          DropdownValue = newValue!;
                          runFilter(DropdownValue);
                        });
                      },),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Container(
                width: 270,
                height: 50,
                child: Center(
                  child: TextField(
                    controller: searchController,
                    onChanged: (Search) {
                        setState(() {
                          search = searchController.text;
                        });
                      },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: '먹고 싶은 메뉴를 검색하세요!',
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Color.fromARGB(200, 200, 1, 80),
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 104, 104, 104),
                        ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), 
                        borderSide: BorderSide(width:1, color: Colors.grey)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), 
                        borderSide: BorderSide(color: Color.fromARGB(200, 200, 1, 80)))
                    ),  
                  ),
                ),
              ),
            ],
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
              child: ListView.builder(
                // items 변수에 저장되어 있는 모든 값 출력
                itemCount: filteredStores.length,
                itemBuilder: (BuildContext context, int index) {
                  // 검색 기능, 검색어가 있을 경우
                  if (search.isNotEmpty &&
                      (!filteredStores[index]["menu"].toString()
                          .toLowerCase()
                          .contains(search.toLowerCase()) &&
                        !filteredStores[index]["name"].toString()
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                    ) {
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
                          title: Text(filteredStores[index]["name"], style:TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                          onTap: () {
                            selectedgage = filteredStores[index]["name"];
                            category = filteredStores[index]["category"];
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => add_new2(),
                                transitionDuration: const Duration(seconds: 0),
                              )
                            );
                          },
                          subtitle: Text('음식 종류: ${filteredStores[index]['menu'].toString()}', maxLines: 1),
                          trailing: Text('기타 정보'),
                        ),
                      ),
                    );
                  }
                  
                },
              ),
            )
        ],)
    );
  }
}

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

class add_new2 extends StatefulWidget {
  add_new2({Key? key}):super(key: key);
  @override
  add_new2State createState() => add_new2State();
}

class add_new2State extends State<add_new2> {
  String address = '도로명 주소를 검색하세요';
  String fulladdress = '';
  String detailaddresshint = '도로명 주소를 먼저 입력하세요';
  String detailaddressstring ='';
  final detailaddress = TextEditingController();
  SliderController _sliderController = SliderController(15000);
  SliderController _sliderController2 = SliderController(15);
  Widget currentpage = add_new();
  bool sangse = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("세션 추가 페이지"),
        backgroundColor: Color.fromARGB(200, 200, 1, 80),
      ),
      body: Column(children: [
        SizedBox(child: Center(child: Text('ShowStep 이미지 삽입')), height: 80,),

        SizedBox(height: 30),

        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('1. 배달 받을 위치 설정',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
            ),
          )
        ),

        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(address, style: TextStyle(color: Color.fromARGB(255, 44, 44, 44), fontSize: 17)),
                
                ElevatedButton(
                    child: Text('주소 검색', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 75, 75, 75),)),
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      alignment: Alignment.centerRight, 
                      
                      ),
                    onPressed: () async {
                      KopoModel model = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RemediKopo(),
                        ),
                      );
                      setState(() {
                        address = '${model.address}';
                        sangse = true;
                        detailaddresshint = '상세 주소를 입력하세요';
                    });
                    },
                  
                ),
              ],
              
            ),
          ),
        ),

        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: detailaddress,
              decoration: InputDecoration(
                hintText: detailaddresshint,
                enabled: sangse,
              ),
            ),
          ),
        ),

        Container(
          child: Divider(color: Color.fromARGB(200, 200,1, 80), thickness: 0.5,)
        ),

        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2. 최소 주문 가격 설정',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
                ),
                Text('${_sliderController.sliderValue.round()} 원    ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 75, 75, 75),)
                )
              ],
            ),
          )
        ),

        SizedBox(height: 20,),

        SliderTheme(
          data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            activeTrackColor: Color.fromARGB(220, 200, 1, 80),
            inactiveTrackColor: Color.fromARGB(50, 200, 1, 80),
            inactiveTickMarkColor: Colors.white,
            thumbColor: Color.fromARGB(200, 200, 1, 80),
          ),
          child: Slider(
            value: _sliderController.sliderValue,
            min: 10000,
            max: 30000,
            label: '${_sliderController.sliderValue.round()} 원',
            divisions: 20,
            onChanged: (double newValue) {
                setState(() {
                  _sliderController.sliderValue = newValue;
                },);
              },
          )
        ),
        
        Container(
          child: Divider(color: Color.fromARGB(200, 200,1, 80), thickness: 0.5,)
        ),

        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('3. 주문 대기 시간 설정',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
                ),
                Text('${_sliderController2.sliderValue.round()} 분    ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 75, 75, 75),)
                )
              ],
            ),
          )
        ),

        SizedBox(height: 20,),

        SliderTheme(
          data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            activeTrackColor: Color.fromARGB(220, 200, 1, 80),
            inactiveTrackColor: Color.fromARGB(50, 200, 1, 80),
            inactiveTickMarkColor: Colors.white,
            thumbColor: Color.fromARGB(200, 200, 1, 80),
          ),
          child: Slider(
            value: _sliderController2.sliderValue,
            min: 5,
            max: 30,
            label: '${_sliderController2.sliderValue.round()} 분',
            divisions: 6,
            onChanged: (double newValue) {
                setState(() {
                  _sliderController2.sliderValue = newValue;
                },);
              },
          )
        ),

        Container(
          child: Divider(color: Color.fromARGB(200, 200,1, 80), thickness: 0.5,)
        ),
        SizedBox(height: 10,),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Color.fromARGB(200, 200, 1, 80)
          ),
          onPressed: () {
            setState(() {
              detailaddressstring = detailaddress.text.toString();
              fulladdress = address + ' ' + detailaddressstring;
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => add_new3(_sliderController.sliderValue.round(), _sliderController2.sliderValue.round(), fulladdress),
                  transitionDuration: const Duration(seconds: 0),
                  )
                );
            });
        }, child: Text('다음', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)))
      ],)
    );
  }
}

List Menu = <String>['마라탕', '마라샹궈', '낙곱새', '짜장면', '볶음밥', '삼겹살'];

class add_new3 extends StatefulWidget {
  final int finalorder;
  final int finaltime;
  final String location;

  const add_new3(this.finalorder, this.finaltime, this.location);

  @override
  add_new3State createState() => add_new3State();
}

class add_new3State extends State<add_new3> {
  void addseesion () async{
    var reqbody = {
      "name": selectedgage,
      "category": category,
      "finalorder": widget.finalorder,
      "finaltime": widget.finaltime,
      "location": widget.location,
    };

    var response = await http.post(
      Uri.parse("http://192.168.123.128:3000/sessions/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqbody),
    );
  }

  var menunum = List<int>.filled(Menu.length, 0);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("세션 추가 페이지"),
        backgroundColor: Color.fromARGB(200, 200, 1, 80),
      ),
      body: Column(children: [
        SizedBox(child: Center(child: Text('ShowStep 이미지 삽입')), height: 80,),

        SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('4. 개인 메뉴 선택',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
              ),
            ),
          ],
        ),

        SizedBox(height: 10),

        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: 500,
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
                          Text(Menu[index],
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromARGB(200, 200, 1, 80),),
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
        SizedBox(height: 15,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Color.fromARGB(200, 200, 1, 80)
          ),
          onPressed: () {

            setState(() {
              addseesion();
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => HomeScreen(),
                  transitionDuration: const Duration(seconds: 0),
                  )
                );
            });
          }, 
          child: Text('다음', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
        )
      ],
      )
    );
  }
}