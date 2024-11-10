import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isSender});
  final String text;
  final String sender;
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: isSender ? Radius.circular(30) : Radius.zero,
                topRight: isSender ? Radius.zero : Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: isSender ? Colors.lightBlueAccent : Colors.white,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 15,
                    color: isSender ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
