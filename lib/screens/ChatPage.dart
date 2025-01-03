import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  // Predefined patterns and responses
  final Map<String, String> _predefinedResponses = {
    'hello': 'Hi there! How can I assist you today?',
    'how are you': 'I’m just a bot, but I’m doing great! How about you?',
    'bye': 'Goodbye! Have a great day!',
    'help': 'Sure! What do you need help with?',
  };

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();
    setState(() {
      _messages.add({'text': userMessage, 'isUser': true});
    });

    _controller.clear();
    _generateResponse(userMessage);
  }

  void _generateResponse(String userMessage) {
    String response = 'Sorry, I didn’t understand that.';

    // Check for predefined patterns
    _predefinedResponses.forEach((pattern, reply) {
      if (userMessage.toLowerCase().contains(pattern)) {
        response = reply;
      }
    });

    setState(() {
      _messages.add({'text': response, 'isUser': false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatBot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Bubble(
                  margin: const BubbleEdges.only(top: 10),
                  alignment: message['isUser']
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  nip: message['isUser']
                      ? BubbleNip.rightTop
                      : BubbleNip.leftTop,
                  color: message['isUser']
                      ? Colors.blue[100]
                      : Colors.grey[300],
                  child: Text(
                    message['text'],
                    style: const TextStyle(fontSize: 16),
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
                    decoration: const InputDecoration(
                      hintText: 'Type your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
