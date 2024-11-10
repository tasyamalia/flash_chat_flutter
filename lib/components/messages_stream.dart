import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream(
      {super.key, required this.stream, required this.loggedInUser});
  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  final User loggedInUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              ),
            );
          }

          final messages = snapshot.data!.docs;
          List<MessageBubble> messagesWidget = [];

          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final currentUser = loggedInUser.email;

            final messageWidget = MessageBubble(
              text: messageText,
              sender: messageSender,
              isSender: currentUser == messageSender,
            );

            messagesWidget.add(messageWidget);
          }
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: messagesWidget,
                ),
              ),
            ),
          );
        });
  }
}
