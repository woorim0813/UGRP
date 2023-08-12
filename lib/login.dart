import 'dart:convert';
import 'package:color_example/realhome.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var userid = TextEditingController();
  var password = TextEditingController();


  void PopUp() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("Dialog Title"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Dialog Content",
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void login(String userid, String password) async{

    if(userid.isNotEmpty && password.isNotEmpty) {
      var reqbody = {
        "userid": userid,
        "password": password,
      };

      var response = await http.post(
        Uri.parse("http://192.168.123.182:3000/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqbody)
      );
      
      var jsonResponse = json.decode(json.encode(response.body));

      if (jsonResponse == 'true') {
        Navigator.push(
          context, MaterialPageRoute(builder:(context) => Main()));
      }
      else{
        PopUp();
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                controller: userid,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: '아이디'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                border: InputBorder.none, hintText: '비밀번호'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              login(userid.text, password.text);
                              context.read<UserProvider>().idupdate(userid.text);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(200, 200,1, 80)),
                              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return Color.fromARGB(200, 255, 179, 0); //<-- SEE HERE
                              return null; // Defer to the widget's default.
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              )
                            )
                            ),
                            
                            child: Center(
                              child: Text(
                                '로그인',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('회원이 아니신가요?'),
                      GestureDetector(
                        
                        onTap: (){
                          setState(() {
                            
                          });
                          Navigator.push(
                            context, MaterialPageRoute(builder:(context) => SignupPage(),)
                          );
                        },
                        child: Text(
                          ' 여기를 클릭해 회원가입하세요!',
                          style: TextStyle(
                              color: Color.fromARGB(200, 200,1, 80), fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                    ]
                  )
                )
              ]
            )
          )
        )
      )
      ),
    );
  }
}