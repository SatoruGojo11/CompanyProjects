import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key,required this.id});

  final String id;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Center(
        child: Text('Your Message Id :- ${widget.id}'),
      ),
    );
  }
}
