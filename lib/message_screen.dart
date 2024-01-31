import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final String value;
  const MessageScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Message Screen'),
      ),
      body:  Column(
        children: [
          Text('This is notification message $value')
        ],
      ),
    );
  }
}