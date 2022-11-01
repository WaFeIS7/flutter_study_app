import 'package:flutter/material.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Доброго вечора, Ми з України!!', style: 
        TextStyle(color: Colors.yellow),),
      ),
    body: const Center(
      child: Text('Вітаю тебе друже!',  style: TextStyle(fontSize: 20)),
    ),
    );
  }
}
