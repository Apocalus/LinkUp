import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget{
  final String message;
  final bool isCurrentUser;

  const ChatBox({
    super.key,
    required this.message,
    required this.isCurrentUser
  });

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser? Colors.blue: Colors.green,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: Text(message, style: TextStyle(color: Colors.white),),
    );
  }
}