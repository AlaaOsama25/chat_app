import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key,required this.user}) : super(key: key);
  final User user;
  @override
  _ChatScreenState createState() => _ChatScreenState(user : user);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState({Key? key ,required this.user});
  final User user;
  final TextEditingController _messagecontroller = TextEditingController();
  FirebaseAuth _auth =  FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> callback() async {
    if (_messagecontroller.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': _messagecontroller.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        leading: Image.asset(
          'assets/images/survey-chat.png',
        ),
        actions: [
          IconButton(
              onPressed: (){
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)
          )
        ],
        title: Text('WeChatting'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('date').snapshots(),
                builder: (context , snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                      return Message(
                          text: doc['text'],
                          from: doc['from'],
                          me: user.email == doc['from']
                      );
                    }).toList()
                  );
                },
              )
          ),
          Row(
            children:  [
               Expanded(
                 child:  TextField(
                   controller: _messagecontroller,
                  decoration: const InputDecoration(
                      hintText: 'Enter Your Message...',
                      border: OutlineInputBorder(),
                  //controller: _emailcontroller,
              ),
              ),
               ),
              Container(
                height: 55,
                width: 80,
                child: ElevatedButton(
                  onPressed: (){
                    callback();
                  },
                  child: Text('Send'),
                  style: ElevatedButton.styleFrom(
                      primary:  Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Message extends StatelessWidget {
  const Message({Key? key,required this.text,required this.from,required this.me}) : super(key: key);
 final String from;
 final String text;
 final bool me;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column  (
        crossAxisAlignment:
        me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(from),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              color: me ? Colors.indigo : Colors.red,
              elevation: 6.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Text(text),
              ),
            ),
          )
        ],
      ),
    );
  }
}

