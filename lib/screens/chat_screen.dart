import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/messages_stream.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/ChatScreen';
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  String messageText = '';
  TextEditingController messageTextController = TextEditingController();
  bool _isLoading = false;

  Future<void> getCurrentUser() async {
    try {
      setLoading(true);
      final user = await _auth.currentUser;
      if (mounted) {
        if (user != null) {
          setState(() {
            loggedInUser = user;
            print(loggedInUser.email);
          });
          setLoading(false);
        }
      }
    } catch (e) {
      print(e);
      setLoading(false);
    }
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Center(
          child: Text(
            '⚡️Chat',
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  )
                : MessagesStream(
                    stream: _firestore
                        .collection('messages')
                        .orderBy('sendDateTime', descending: false)
                        .snapshots(),
                    loggedInUser: loggedInUser,
                  ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'sendDateTime': DateTime.now()
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
