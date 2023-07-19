import 'package:color_example/realhome.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
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
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
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
                              decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
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
                            Navigator.push(
                            context, MaterialPageRoute(builder:(context) => Main(),)
                          );
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
                )
                  ]
                )
              )
            ]
          )
        )
      )
    )
  );
  }
}