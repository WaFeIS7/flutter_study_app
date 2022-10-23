import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePageSecond(),
    );
  }
}

class HomePageSecond extends StatelessWidget {
   const HomePageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 158, 156),  
      appBar: AppBar(
        title: const Text("Flutter Demo Study",
            style: TextStyle(
                color: Colors.orangeAccent, fontStyle: FontStyle.italic)),
      ),
      body: const Center(
        child: Text("Homework", style: TextStyle(fontSize: 33, color: Colors.amberAccent )),
      ),
    );
  }
}
