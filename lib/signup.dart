import 'package:color_example/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var useridController = TextEditingController();
  var passwordController = TextEditingController();
  
  void PopUp() {
    showDialog(
      context: context,
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
        }
      );
  }
  void signup(String username, String userid, String password) async{

    if(username.isNotEmpty && userid.isNotEmpty && password.isNotEmpty) {
      var reqbody = {
        "username": username,
        "userid": userid,
        "password": password,
      };

      var response = await http.post(
        Uri.parse("http://192.168.123.128:3000/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqbody)
      );
      
      var jsonResponse = json.decode(json.encode(response.body));

      if (jsonResponse == 'true') {
        Navigator.push(
          context, MaterialPageRoute(builder:(context) => LoginPage()));
      }
      else{
        PopUp();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                              controller: usernameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '사용자 이름'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                              controller: useridController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '아이디'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                              controller: passwordController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '비밀번호'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            signup(usernameController.text, useridController.text, passwordController.text);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(200, 200,1, 80)),
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Color.fromARGB(200, 255, 179, 0); 
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
                              '회원가입',
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
                    Text('이미 회원이신가요?'),
                    GestureDetector(
                      onTap:() {
                        Navigator.push(
                          context, MaterialPageRoute(builder:(context) => LoginPage(),)
                        );
                      },
                      child: Text(
                        ' 여기를 클릭해 로그인하세요!',
                        style: TextStyle(
                            color: Color.fromARGB(200, 200,1, 80), fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}