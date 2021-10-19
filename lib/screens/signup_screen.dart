import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
class Sign_UpScreen extends StatefulWidget {
  const Sign_UpScreen({Key? key}) : super(key: key);

  @override
  _Sign_UpScreenState createState() => _Sign_UpScreenState();
}

class _Sign_UpScreenState extends State<Sign_UpScreen> {

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
        //leading: Image.asset('assets/images/survey-chat.png'),
        title: Text('Create an Account'),
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
                                .createUserWithEmailAndPassword(
                                email: _emailcontroller.text,
                                password: _passwordcontroller.text
                            );
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen())
                            );
                        }
                        catch(e) {
                            print(e);
                        }
                      },
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                            primary:  Colors.blue.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )
                        ),
                      ),
                    ),

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
