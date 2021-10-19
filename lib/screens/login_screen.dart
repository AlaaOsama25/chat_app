import 'package:chat_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();

  FirebaseAuth _auth =  FirebaseAuth.instance;

  bool VisablePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: Image.asset('assets/images/survey-chat.png',),
        title: Text('WeChatting'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/texting.png',width: 300,),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email...',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailcontroller,
                    ),
                    SizedBox(height: 30,),
                    TextField(
                      obscureText: !VisablePassword,
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Password...',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon:  IconButton(
                              icon: VisablePassword ? Icon(Icons.remove_red_eye): Icon(Icons.visibility_off),
                            onPressed: (){
                                setState(() {
                                  VisablePassword = !VisablePassword;
                                });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              UserCredential result = await _auth
                                  .signInWithEmailAndPassword(
                                  email: _emailcontroller.text,
                                  password: _passwordcontroller.text
                              );
                               User? user = result.user;
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(user: user!))
                              );
                            }
                            catch(e) {
                              print(e);
                            }

                          },
                          child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            primary:  Colors.blue.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Sign_UpScreen()));
                            },
                            child: Text('Sign Up')
                        )
                      ],
                    )

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
