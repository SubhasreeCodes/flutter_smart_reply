import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_smart_reply/screens/ChatScreen.dart';
import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}