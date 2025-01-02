import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map> _messages = [];

  // Function to send a message to Flask API
  Future<void> sendMessage(String query) async {
    try {
      // Replace with your machine's local IP address (or use 10.0.2.2 for Android Emulator)
      final response = await http.post(
        Uri.parse('http://192.168.x.x:5000/bot'), // Change this IP to your local IP
        body: {'query': query},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          // Add user query and bot response to chat
          _messages.add({"text": query, "isUser": true});
          _messages.add({"text": data['response'], "isUser": false});
        });
      } else {
        setState(() {
          _messages.add({"text": "Error: ${response.statusCode}", "isUser": false});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"text": "Failed to connect: $e", "isUser": false});
      });
    }
  }

  // UI to build chat bubbles and display messages
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with Bot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Bubble(
                  alignment: _messages[index]['isUser']
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  color: _messages[index]['isUser']
                      ? Colors.blueAccent
                      : Colors.grey,
                  child: Text(
                    _messages[index]['text'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
