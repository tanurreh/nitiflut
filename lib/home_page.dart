import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body:const  Column(
        children: [
          Center(
            child: Text('Hello!'),
          )
        ],
      ),
    );
  }
}