import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'login_screen.dart';
class IntroScreens extends StatelessWidget {
  const IntroScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                image: Image.asset('assets/images/chat.png'),
                title: 'WeChatting',
                body: 'Allow you to connect with friends'
              ),
              PageViewModel(
                  image: Image.asset('assets/images/people-speaking.png'),
                  title: 'With WeChatting',
                  body: 'Keeping in touch with friends and family has never been easier'
              ),
              PageViewModel(
                  image: Image.asset('assets/images/online-friends.png'),
                  title: 'There New World Waiting for you',
                  body: 'Let\'s discover it!'
              ),
            ],
            showSkipButton: false,
            showNextButton: true,
            next: Text('Next'),
            done: Text('Let\'s go!'),
            onDone: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ),
      )
    );
  }
}
