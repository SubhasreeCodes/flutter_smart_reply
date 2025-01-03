import 'package:flutter/material.dart';
import 'package:flutter_smart_reply/screens/ChatPage.dart'; // Ensure this file is created and the name matches

void main() => runApp(ChatBotApp());

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatPage(), // Updated to use ChatPage
    );
  }
}
